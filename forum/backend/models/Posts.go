package models

import (
	"database/sql"
	"fmt"
	"strconv"
	"strings"
	"time"

	"web-forum/backend/db"
)

type Posts struct {
	ID           int `json:"id"`
	UserID       int `json:"user_id"`
	Username     string
	Title        string    `json:"title"`
	Content      string    `json:"content"`
	CreatedAt    time.Time `json:"created_at"`
	CategoryName string
}
type UserReaction struct {
	UserID   int
	PostID   int
	Reaction string
}
type MainPostCounter struct {
	PostID               int
	MainPostLikecount    int
	MainPostDislikecount int
}

// CreatePost inserts a new post into the Posts table
func CreatePost(db *sql.DB, userID int, title, content string, category int) error {
	createdAt := time.Now().Format(time.RFC3339)

	stmt, err := db.Prepare("INSERT INTO Posts (user_id, title, content, created_at) VALUES (?, ?, ?, ?)")
	if err != nil {
		return fmt.Errorf("error preparing insert statement: %v", err)
	}
	defer stmt.Close()

	// Execute the insert statement and retrieve the result
	result, err := stmt.Exec(userID, title, content, createdAt)
	if err != nil {
		return fmt.Errorf("error executing insert statement: %v", err)
	}

	// Get the last inserted ID from the result
	postID, err := result.LastInsertId()
	if err != nil {
		return fmt.Errorf("error getting last inserted ID: %v", err)
	}

	// Call CreatePostCategory with the postID as an int
	err = CreatePostCategory(db, int(postID), category)
	if err != nil {
		return fmt.Errorf("error creating post category: %v", err)
	}

	return nil
}

// GetAllPosts retrieves all posts from the Posts table, including the username for each post
func GetAllPosts(db *sql.DB) ([]Posts, error) {
	query := `
		SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at
		FROM Posts p
		JOIN Users u ON p.user_id = u.id
		ORDER BY p.created_at DESC
	`
	rows, err := db.Query(query)
	if err != nil {
		return nil, fmt.Errorf("error querying posts: %v", err)
	}
	defer rows.Close()

	var posts []Posts
	for rows.Next() {
		var post Posts
		if err := rows.Scan(&post.ID, &post.UserID, &post.Username, &post.Title, &post.Content, &post.CreatedAt); err != nil {
			return nil, fmt.Errorf("error scanning post: %v", err)
		}
		posts = append(posts, post)
		// fmt.Println(post.Username)
	}
	return posts, nil
}

func GetMyPosts(db *sql.DB, userID int) ([]Posts, error) {
	// Prepare the query to select posts where user_id matches the given userID
	rows, err := db.Query(`
		SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at
		FROM Posts p
		JOIN Users u ON p.user_id = u.id
		Where user_id = ?
		ORDER BY p.created_at DESC
	`, userID)
	if err != nil {
		return nil, fmt.Errorf("error querying posts: %v", err)
	}
	defer rows.Close()

	var posts []Posts

	for rows.Next() {
		var post Posts
		if err := rows.Scan(&post.ID, &post.UserID, &post.Username, &post.Title, &post.Content, &post.CreatedAt); err != nil {
			return nil, fmt.Errorf("error scanning post: %v", err)
		}
		posts = append(posts, post)
	}

	return posts, nil
}

func GetPostID(userID int, title string, content string, createdAt string) (int, error) {
	DB := db.GetDB()
	// write me a select statement to get the post id by using all the parameters that have been passed
	statement, err := DB.Prepare("SELECT id FROM Posts WHERE user_id = ? AND title = ? AND content = ? AND created_at = ?")
	if err != nil {
		return 0, fmt.Errorf("error preparing select statement: %v", err)
	}
	defer statement.Close()

	var postID int
	err = statement.QueryRow(userID, title, content, createdAt).Scan(&postID)
	if err != nil {
		return 0, fmt.Errorf("error querying post ID: %v", err)
	}

	return postID, nil
}

// GetPostsByCategories retrieves posts that match any of the given category IDs
func GetPostsByCategories(db *sql.DB, categoryIDs []int) ([]Posts, error) {
	if len(categoryIDs) == 0 {
		return GetAllPosts(db)
	}

	// Prepare a query with placeholders for the category IDs
	query := `
        SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at
        FROM Posts p
        JOIN Users u ON p.user_id = u.id
        JOIN PostCategories pc ON p.id = pc.post_id
        WHERE pc.category_id IN (`

	// Append placeholders for the number of categories
	for i := 0; i < len(categoryIDs); i++ {
		if i > 0 {
			query += ", "
		}
		query += "?"
	}
	query += " )GROUP BY p.id ORDER BY p.created_at DESC"

	rows, err := db.Query(query, convertToInterfaceSlice(categoryIDs)...)
	if err != nil {
		return nil, fmt.Errorf("error querying posts: %v", err)
	}
	defer rows.Close()

	var posts []Posts
	for rows.Next() {
		var post Posts
		if err := rows.Scan(&post.ID, &post.UserID, &post.Username, &post.Title, &post.Content, &post.CreatedAt); err != nil {
			return nil, fmt.Errorf("error scanning post: %v", err)
		}
		posts = append(posts, post)
	}
	return posts, nil
}

// GetPostsByCategories retrieves posts that match any of the given category IDs
func GetMyPostsByCategories(db *sql.DB, categoryIDs []int, userId int) ([]Posts, error) {
	if len(categoryIDs) == 0 {
		return GetAllPosts(db)
	}
	// convert int into string
	strUserId := strconv.Itoa(userId)

	// Prepare a query with placeholders for the category IDs
	query := `
        SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at
        FROM Posts p
        JOIN Users u ON p.user_id = u.id
        JOIN PostCategories pc ON p.id = pc.post_id
        WHERE pc.category_id IN (`

	// Append placeholders for the number of categories
	for i := 0; i < len(categoryIDs); i++ {
		if i > 0 {
			query += ", "
		}
		query += "?"
	}
	query += " ) AND user_id = " + strUserId + " GROUP BY p.id ORDER BY p.created_at DESC"

	rows, err := db.Query(query, convertToInterfaceSlice(categoryIDs)...)
	if err != nil {
		return nil, fmt.Errorf("error querying posts: %v", err)
	}
	defer rows.Close()

	var posts []Posts
	for rows.Next() {
		var post Posts
		if err := rows.Scan(&post.ID, &post.UserID, &post.Username, &post.Title, &post.Content, &post.CreatedAt); err != nil {
			return nil, fmt.Errorf("error scanning post: %v", err)
		}
		posts = append(posts, post)
	}
	return posts, nil
}

// Helper function to convert int slice to interface slice
func convertToInterfaceSlice(ints []int) []interface{} {
	iface := make([]interface{}, len(ints))
	for i, v := range ints {
		iface[i] = v
	}
	return iface
}

func GetMyReactedPosts(userID int, reaction string) ([]Posts, error) {
	DB := db.GetDB()

	// Parameterized query to get posts liked by the user
	query := `
	SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at 
	FROM Reactions r
	JOIN Posts p ON r.post_id = p.id
	JOIN Users u ON p.user_id = u.id
	WHERE r.comment_id = 0 AND r.user_id = ? AND r.type = ?`

	var rows *sql.Rows
	var err error

	if reaction == "L" {
		rows, err = DB.Query(query, userID, "L")
	} else {
		rows, err = DB.Query(query, userID, "D")
	}

	if err != nil {
		return nil, fmt.Errorf("error querying posts: %v", err)
	}
	defer rows.Close()

	var posts []Posts
	for rows.Next() {
		var post Posts
		if err := rows.Scan(&post.ID, &post.UserID, &post.Username, &post.Title, &post.Content, &post.CreatedAt); err != nil {
			return nil, fmt.Errorf("error scanning post: %v", err)
		}
		posts = append(posts, post)
	}

	return posts, nil
}

func RemoveDuplicatePosts(posts []Posts) []Posts {
	seen := make(map[int]bool)
	uniquePosts := []Posts{}

	for _, post := range posts {
		if !seen[post.ID] {
			uniquePosts = append(uniquePosts, post)
			seen[post.ID] = true
		}
	}

	return uniquePosts
}

func CreatePostCategory(db *sql.DB, postID int, categoryID int) error {
	stmt, err := db.Prepare("INSERT INTO PostCategories (post_id, category_id) VALUES (?, ?)")
	if err != nil {
		return fmt.Errorf("error preparing insert statement: %v", err)
	}
	defer stmt.Close()
	_, err = stmt.Exec(postID, categoryID)
	if err != nil {
		return fmt.Errorf("error executing insert statement: %v", err)
	}
	return nil
}

func GetLikedCategoriesPosts(db *sql.DB, categoryIDs []int, userID int, reaction string) ([]Posts, error) {
	var query strings.Builder
	query.WriteString(`
        SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at
        FROM Posts p
        JOIN Users u ON p.user_id = u.id
        LEFT JOIN PostCategories pc ON p.id = pc.post_id
        LEFT JOIN Reactions r ON p.id = r.post_id AND r.user_id = ? 
        WHERE 1=1 AND r.type = "?"`)

	args := []interface{}{userID, reaction}

	if len(categoryIDs) > 0 {
		query.WriteString(" AND pc.category_id IN (")
		for i := 0; i < len(categoryIDs); i++ {
			if i > 0 {
				query.WriteString(", ")
			}
			query.WriteString("?")
			args = append(args, categoryIDs[i])
		}
		query.WriteString(")")
	}

	query.WriteString(" GROUP BY p.id ORDER BY p.created_at DESC")

	// Debugging output
	fmt.Println("Executing Query:", query.String())
	fmt.Println("With Args:", args)

	rows, err := db.Query(query.String(), args...)
	if err != nil {
		return nil, fmt.Errorf("error querying posts: %v", err)
	}
	defer rows.Close()

	var posts []Posts
	for rows.Next() {
		var post Posts
		if err := rows.Scan(&post.ID, &post.UserID, &post.Username, &post.Title, &post.Content, &post.CreatedAt); err != nil {
			return nil, fmt.Errorf("error scanning post: %v", err)
		}
		posts = append(posts, post)
	}
	return posts, nil
}

func FilterLikedByCategory(likedPosts []Posts, categoryIDs []int) ([]Posts, error) {
	filteredPosts := []Posts{}
	catPosts, _ := GetPostsByCategories(db.GetDB(), categoryIDs)
	catPostsID := []int{}

	for _, post := range catPosts {
		catPostsID = append(catPostsID, post.ID)
	}
	for _, post := range likedPosts {
		for _, catID := range catPostsID {
			if post.ID == catID {
				filteredPosts = append(filteredPosts, post)
			}
		}
	}

	return filteredPosts, nil
}

func FilterLikedByMine(likedPosts []Posts, userID int) ([]Posts, error) {
	filteredPosts := []Posts{}
	postsByUser, _ := GetMyPosts(db.GetDB(), userID)
	postsID := []int{}

	for _, post := range postsByUser {
		postsID = append(postsID, post.ID)
	}
	for _, post := range likedPosts {
		for _, postID := range postsID {
			if post.ID == postID {
				filteredPosts = append(filteredPosts, post)
			}
		}
	}

	return filteredPosts, nil
}
