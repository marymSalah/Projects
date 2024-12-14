package handlers

import (
	"encoding/json"
	"log"
	"net/http"

	"web-forum/backend/db"
	"web-forum/backend/models"
)

func MessagesPageHandler(w http.ResponseWriter, r *http.Request) {
	// Validate session
	session, err := models.ValidateSession(w, r, db.GetDB())
	if err != nil {
		log.Printf("couldn't validate session: %v", err)
		http.Redirect(w, r, "/login", http.StatusSeeOther)
		return
	}

	uid := session.UserID

	user, err := models.GetUsername(db.GetDB(), uid)
	if err != nil {
		log.Printf("Error fetching username: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	users, err := models.GetAllUsers(db.GetDB())
	if err != nil {
		log.Printf("Error fetching users: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	sentMsgs, err := models.GetSentMessages(uid)
	if err != nil {
		log.Printf("Error fetching sent messages: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	recMsgs, err := models.GetRecievedMessages(uid)
	if err != nil {
		log.Printf("Error fetching recieved messages: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	data := struct {
		Username         string            `json:"username"`
		Users            []models.Users    `json:"users"`
		LoggedInUser     int               `json:"loggedInUser"`
		SentMessages     []models.Messages `json:"sentMessages"`
		RecievedMessages []models.Messages `json:"recievedMessages"`
	}{
		Username:         user,
		Users:            users,
		LoggedInUser:     uid,
		SentMessages:     sentMsgs,
		RecievedMessages: recMsgs,
	}

	// Prepare response
	w.Header().Set("Content-Type", "application/json")
	if err = json.NewEncoder(w).Encode(data); err != nil {
		log.Printf("Error encoding JSON: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}
