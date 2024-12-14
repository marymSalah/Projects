package main

import (
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"web-forum/backend/db"
	"web-forum/backend/handlers"
	"web-forum/backend/models"
)

// main is the entry point of the web forum application.
// It initializes the database, deletes expired sessions, and sets up the HTTP handlers for various routes.
// The server is then started and listens on port 8080.

func main() {
	err := db.InitDatabase()
	if err != nil {
		log.Fatalf("Error initializing database: %v", err)
	}
	defer db.CloseDatabase()

	err = models.DeleteExpiredSessions(db.GetDB())
	if err != nil {
		log.Printf("Error deleting expired sessions: %v", err)
	}

	server := models.GetServer()

	// Set up routes
	http.HandleFunc("/", handlers.HomeHandler)
	http.HandleFunc("/signin", handlers.SigninHandler)
	// http.HandleFunc("/mainPost", handlers.MainPostHandler)
	// -------------------------- new additions -------------------------------
	http.HandleFunc("/privateMessage", handlers.MessagesPageHandler)
	http.HandleFunc("/logout", handlers.LogoutHandler)
	http.HandleFunc("/profile", handlers.ProfileHandler)
	// ------------------------------------------------------------------------
	http.HandleFunc("/createPost", handlers.CreatePostHandler)
	http.HandleFunc("/post/", handlers.PostCommentsHandler)
	http.HandleFunc("/addComment", handlers.AddCommentHandler)

	// new
	http.HandleFunc("/api/posts", handlers.MainPostHandler)
	http.HandleFunc("/api/users", handlers.MessagesPageHandler)
	http.HandleFunc("/api/login", handlers.SigninHandler)
	http.HandleFunc("/api/logout", handlers.LogoutHandler)
	http.HandleFunc("/api/register", handlers.RegisterHandler)
	http.HandleFunc("/api/messages", handlers.MessagesPageHandler)
	http.HandleFunc("/api/posts/", handlers.MainPostHandler)
	http.HandleFunc("/api/comments", handlers.PostCommentsHandler)
	http.HandleFunc("/api/addComment", handlers.AddCommentHandler)
	http.HandleFunc("/api/profile", handlers.ProfileHandler)
	http.HandleFunc("/api/notifications", handlers.NotificationHandler)
	http.HandleFunc("/api/notifications/markAsRead", handlers.MarkNotificationsAsReadHandler)

	http.HandleFunc("/static/", serveStatic)
	http.HandleFunc("/js/", serveJavaScript)

	http.Handle("/ws", http.HandlerFunc(server.HandleWS))

	// Ensure logs are printed
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	log.Println("Server started on :8080 \n url: http://localhost:8080/")
	err = http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatalf("Error starting server: %v", err)
	}
}

func serveStatic(w http.ResponseWriter, r *http.Request) {
	staticDir := "frontend/static/"                                // base directory for static files
	path := filepath.Join(staticDir, r.URL.Path[len("/static/"):]) // constructs a full file path

	file, err := os.Open(path)
	if err != nil {
		http.NotFound(w, r) // returns a 404 error if the file is not found
		return
	}
	defer file.Close()

	info, err := file.Stat()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError) // returns a 505 error if file info cannot be retrieved
		return
	}

	// Detect the content type of the file
	contentType := http.DetectContentType([]byte{})
	switch {
	case strings.HasSuffix(path, ".css"):
		contentType = "text/css"
	case strings.HasSuffix(path, ".png"), strings.HasSuffix(path, ".jpg"), strings.HasSuffix(path, ".jpeg"), strings.HasSuffix(path, ".gif"):
		contentType = http.DetectContentType([]byte{})
	}

	w.Header().Set("Content-Type", contentType)
	http.ServeContent(w, r, info.Name(), info.ModTime(), file)
}

func serveJavaScript(w http.ResponseWriter, r *http.Request) {
	jsDir := "frontend/js/"
	path := filepath.Join(jsDir, r.URL.Path[len("/js/"):])

	file, err := os.Open(path)
	if err != nil {
		http.NotFound(w, r)
		return
	}
	defer file.Close()

	info, err := file.Stat()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/javascript")
	http.ServeContent(w, r, info.Name(), info.ModTime(), file)
}
