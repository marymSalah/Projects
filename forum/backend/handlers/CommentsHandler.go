package handlers

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"strings"
	"web-forum/backend/db"
	"web-forum/backend/models"
)

// ------------------------- COMMENTS HANDLERS ---------------------------

// Struct to send post and comments data
type CommentWithUser struct {
	Comment  models.Comments `json:"comment"`
	Username string          `json:"username"`
}

// Handles fetching a single post and its comments
func PostCommentsHandler(w http.ResponseWriter, r *http.Request) {
	postIdStr := r.URL.Query().Get("postId")
	if postIdStr == "" {
		http.Error(w, "Missing postId parameter", http.StatusBadRequest)
		return
	}

	postID, err := strconv.Atoi(postIdStr)
	if err != nil {
		log.Printf("Invalid post ID: %v", err)
		http.NotFound(w, r)
		return
	}

	post, err := models.GetPostByID(db.GetDB(), postID)
	if err != nil {
		log.Printf("Error fetching post: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	comments, err := models.GetCommentsByPostID(db.GetDB(), postID)
	if err != nil {
		log.Printf("Error fetching comments: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	data := struct {
		Post     models.Posts      `json:"post"`
		Comments []models.Comments `json:"comments"`
	}{
		Post:     post,
		Comments: comments,
	}

	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(data); err != nil {
		log.Printf("Error encoding JSON: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

// Handles adding a new comment to a post
func AddCommentHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method Not Allowed", http.StatusMethodNotAllowed)
		return
	}

	postIDStr := r.FormValue("post_id")
	content := r.FormValue("content")

	if content == "" {
		http.Error(w, "Content cannot be empty", http.StatusBadRequest)
		return
	}

	postID, err := strconv.Atoi(postIDStr)
	if err != nil {
		log.Printf("Error converting post_id to int: %v", err)
		http.Error(w, "Invalid Post ID", http.StatusBadRequest)
		return
	}

	session, err := models.ValidateSession(w, r, db.GetDB())
	if err != nil || session == nil {
		log.Printf("Error validating session: %v", err)
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	username, ree := models.GetUsername(db.GetDB(), session.UserID)
	if ree != nil {
		log.Printf("Error fetching username: %v", ree)  // Corrected variable
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	// Sanitize content (simple check)
	if strings.Contains(content, "<br>") {
		content = strings.ReplaceAll(content, "<br>", "<2br>")
	}

	err = models.CreateComment(db.GetDB(), session.UserID, postID, content, username)
	if err != nil {
		log.Printf("Error creating comment: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	// Send JSON response instead of a redirect for AJAX compatibility
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	fmt.Fprintf(w, `{"message": "Comment added successfully"}`)
}
