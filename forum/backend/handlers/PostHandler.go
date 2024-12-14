package handlers

import (
	"encoding/json"
	"log"
	"net/http"
	"strings"
	"time"

	"web-forum/backend/db"

	"web-forum/backend/models"
)

// ------------------------- POSTS HANDLERS ---------------------------

func MainPostHandler(w http.ResponseWriter, r *http.Request) {

	var posts []models.Posts
	posts, err := models.GetAllPosts(db.GetDB())
	if err != nil {
		log.Printf("Error fetching posts: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	// get categories
	for i, post := range posts {
		// Fetch categories for each post
		category, err := models.GetCategoriesOfPosts(db.GetDB(), post.ID)
		if err != nil {
			log.Printf("Error fetching categories for post %d: %v", post.ID, err)
			continue
		}

		post.CategoryName = category

		if strings.Contains(post.Content, "\n") {
			post.Content = strings.ReplaceAll(post.Content, "\n", "\\n")
		}
		posts[i] = post
	}

	var response []struct {
		ID           int       `json:"id"`
		Username     string    `json:"username"`
		Title        string    `json:"title"`
		Content      string    `json:"content"`
		CreatedAt    time.Time `json:"createdAt"`
		CategoryName string    `json:"category"`
	}

	for _, post := range posts {
		username, err := models.GetUsername(db.GetDB(), post.UserID)
		if err != nil {
			log.Printf("Error fetching username for user ID %d: %v", post.UserID, err)
			continue
		}

		response = append(response, struct {
			ID           int       `json:"id"`
			Username     string    `json:"username"`
			Title        string    `json:"title"`
			Content      string    `json:"content"`
			CreatedAt    time.Time `json:"createdAt"`
			CategoryName string    `json:"category"`
		}{
			ID:           post.ID,
			Username:     username,
			Title:        post.Title,
			Content:      post.Content,
			CreatedAt:    post.CreatedAt,
			CategoryName: post.CategoryName,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	if err = json.NewEncoder(w).Encode(response); err != nil {
		log.Printf("Error encoding JSON: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

}

func CreatePostHandler(w http.ResponseWriter, r *http.Request) {
	// Validate session
	session, err := models.ValidateSession(w, r, db.GetDB())
	if err != nil {
		log.Printf("couldn't validate session: %v", err)
		http.Redirect(w, r, "/login", http.StatusSeeOther)
		return
	}

	if r.Method == http.MethodPost {
		if r.Header.Get("Content-Type") != "application/json" {
			log.Println("Invalid content type")
			http.Error(w, "Content-Type must be application/json", http.StatusUnsupportedMediaType)
			return
		}

		var postData struct {
			Title    string `json:"title"`
			Content  string `json:"content"`
			Category int    `json:"category"`
		}

		err := json.NewDecoder(r.Body).Decode(&postData)
		if err != nil {
			log.Printf("Error decoding request body: %v", err)
			http.Error(w, "Invalid request body", http.StatusBadRequest)
			return
		}

		if postData.Title == "" || postData.Content == "" || postData.Category == 0 {
			log.Println("Title or content or category is missing")
			http.Error(w, "Title and content are required", http.StatusBadRequest)
			return
		}

		log.Printf("Creating post for user %d with title: %s", session.UserID, postData.Title)

		err = models.CreatePost(db.GetDB(), session.UserID, postData.Title, postData.Content, postData.Category)
		if err != nil {
			log.Printf("Error creating post: %v", err)
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}

		log.Println("Post created successfully")

		w.WriteHeader(http.StatusCreated)
	}
}
