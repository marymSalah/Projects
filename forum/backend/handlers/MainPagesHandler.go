package handlers

import (
	"encoding/json"
	"html/template"
	"log"
	"net/http"

	"web-forum/backend/db"
	"web-forum/backend/models"
)

func HomeHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		models.ErrorHandler(w, r, 404)
		return
	}

	tmpl, err := template.ParseFiles("frontend/index.html")
	if err != nil {
		models.ErrorHandler(w, r, 500)
		return
	}
	err = tmpl.ExecuteTemplate(w, "index.html", r)
	if err != nil {
		models.ErrorHandler(w, r, 500)
		return
	}
}

func NotificationHandler(w http.ResponseWriter, r *http.Request) {
	session, err := models.ValidateSession(w, r, db.GetDB())
	if err != nil {
		return
	}
	if r.Method == http.MethodPost {
		if err := models.MarkAsRead(session.UserID); err != nil {
			http.Error(w, "Error marking notifications as read", http.StatusInternalServerError)
			return
		}
		return
	}

	Notifications, err := models.GetNotifications(session.UserID)
	if err != nil {
		http.Error(w, "Error fetching notifications", http.StatusInternalServerError)
		return
	}
	unreadNotifications, num, err := models.GetUnReadNotification(session.UserID)
	if err != nil {
		http.Error(w, "Error fetching unread notifications", http.StatusInternalServerError)
		return
	}
	count := len(unreadNotifications)
	if count != num {
		return
	}

	data := struct {
		Notifications       []models.Notification
		UnreadNotifications int
	}{
		Notifications:       Notifications,
		UnreadNotifications: num,
	}
	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(data); err != nil {
		log.Printf("Error encoding JSON: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

// MarkNotificationsAsReadHandler marks all notifications as read for a user
func MarkNotificationsAsReadHandler(w http.ResponseWriter, r *http.Request) {
	session, err := models.ValidateSession(w, r, db.GetDB())
	if err != nil {
		return
	}
	userID := session.UserID

	err = models.MarkAsRead(userID)
	if err != nil {
		http.Error(w, "Failed to mark notifications as read", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
}
