package models

import (
	"database/sql"
	"fmt"
)

type Category struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

func GetAllCategories(db *sql.DB) ([]Category, error) {
	query := `
    SELECT * FROM Categories;
    `
	rows, err := db.Query(query)
	if err != nil {
		return nil, fmt.Errorf("error querying categories: %v", err)
	}
	defer rows.Close()

	var categories []Category
	for rows.Next() {
		var category Category
		err := rows.Scan(&category.ID, &category.Name)
		if err != nil {
			return nil, fmt.Errorf("error scanning category: %v", err)
		}
		categories = append(categories, category)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating categories: %v", err)
	}

	return categories, nil
}

func GetPostsByCategory(db *sql.DB, categoryID int) ([]Posts, error) {
	query := `
        SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at
        FROM Posts p
        JOIN Users u ON p.user_id = u.id
        JOIN PostCategories pc ON p.id = pc.post_id
        WHERE pc.category_id = ?
        ORDER BY p.created_at DESC
    `
	rows, err := db.Query(query, categoryID)
	if err != nil {
		return nil, fmt.Errorf("error querying posts by category: %v", err)
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

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating over rows: %v", err)
	}

	return posts, nil
}

func GetCategoriesOfPosts(db *sql.DB, postID int) (string, error) {
	query := `
        SELECT c.name
        FROM PostCategories pc
        JOIN Categories c ON pc.category_id = c.id
        WHERE pc.post_id = ?
    `
	var categoryName string
	err := db.QueryRow(query, postID).Scan(&categoryName)
	if err != nil {
		return "", fmt.Errorf("error querying category of post: %v", err)
	}
	return categoryName, nil
}

func GetCategoryNamesByIDs(db *sql.DB, categoryIDs []int) ([]string, error) {
	// SELECT id,name FROM Categories;
	var categoryNames []string
	for _, id := range categoryIDs {
		query := `
		SELECT name FROM Categories WHERE id = ?
	`
		var categoryName string
		err := db.QueryRow(query, id).Scan(&categoryName)
		if err != nil {
			return nil, fmt.Errorf("error querying category name: %v", err)
		}
		categoryNames = append(categoryNames, categoryName)
	}

	return categoryNames, nil
}
