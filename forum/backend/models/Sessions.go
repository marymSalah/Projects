package models

import (
	"database/sql"
	"fmt"
	"net/http"
	"time"

	"github.com/google/uuid"
	_ "github.com/mattn/go-sqlite3"
)

type Session struct {
	ID        int       `json:"id"`
	UserID    int       `json:"user_id"`
	Token     string    `json:"token"`
	CreatedAt time.Time `json:"created_at"`
	ExpiresAt time.Time `json:"expires_at"`
}

// CreateSession creates a new session, stores it in the database, and sets the cookie
func CreateSession(w http.ResponseWriter, r *http.Request, db *sql.DB, userID int) error {
	// Check for an existing active session
	var existingSession Session
	err := db.QueryRow("SELECT id, user_id, token, created_at, expires_at FROM Sessions WHERE user_id = ? AND expires_at > ?", userID, time.Now()).Scan(&existingSession.ID, &existingSession.UserID, &existingSession.Token, &existingSession.CreatedAt, &existingSession.ExpiresAt)

	expiresAt := time.Now().Add(2 * time.Hour) // Session valid for 2 hours

	if err != nil && err != sql.ErrNoRows {
		return fmt.Errorf("error querying existing session: %v", err)
	}

	if err == nil {
		// Existing active session found, delete it
		stmt, err := db.Prepare("DELETE FROM Sessions WHERE id = ?")
		if err != nil {
			return fmt.Errorf("error preparing delete statement: %v", err)
		}
		defer stmt.Close()

		_, err = stmt.Exec(existingSession.ID)
		if err != nil {
			return fmt.Errorf("error executing delete statement: %v", err)
		}
	}

	// Create a new session
	sessionToken := uuid.New().String()

	stmt, err := db.Prepare("INSERT INTO Sessions (user_id, token, created_at, expires_at) VALUES (?, ?, ?, ?)")
	if err != nil {
		return fmt.Errorf("error preparing insert statement: %v", err)
	}
	defer stmt.Close()

	_, err = stmt.Exec(userID, sessionToken, time.Now(), expiresAt)
	if err != nil {
		return fmt.Errorf("error executing insert statement: %v", err)
	}

	// Set the session cookie
	cookie := http.Cookie{
		Name:     "session_token",
		Value:    sessionToken,
		Expires:  expiresAt,
		HttpOnly: true,
		Secure:   true, // Ensure this is set to true in production
		Path:     "/",
	}
	http.SetCookie(w, &cookie)

	return nil
}

// GetSession retrieves the session from the cookie and verifies it against the database
func GetSession(r *http.Request, db *sql.DB) (*Session, error) {
	cookie, err := r.Cookie("session_token")
	if err != nil {
		if err == http.ErrNoCookie {
			return nil, fmt.Errorf("no session token found")
		}
		return nil, err
	}

	sessionToken := cookie.Value

	var s Session
	err = db.QueryRow("SELECT id, user_id, token, created_at, expires_at FROM Sessions WHERE token = ?", sessionToken).Scan(&s.ID, &s.UserID, &s.Token, &s.CreatedAt, &s.ExpiresAt)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("session not found")
		}
		return nil, fmt.Errorf("error querying database: %v", err)
	}

	// Check if the session is expired
	if s.ExpiresAt.Before(time.Now()) {
		return nil, fmt.Errorf("session expired")
	}

	return &s, nil
}

// DeleteSession deletes the session from the database and clears the cookie
func DeleteSession(w http.ResponseWriter, r *http.Request, db *sql.DB) error {
	cookie, err := r.Cookie("session_token")
	if err != nil {
		if err == http.ErrNoCookie {
			return fmt.Errorf("no session token found")
		}
		return err
	}

	sessionToken := cookie.Value

	// Delete the session from the database
	stmt, err := db.Prepare("DELETE FROM Sessions WHERE token = ?")
	if err != nil {
		return fmt.Errorf("error preparing delete statement: %v", err)
	}
	defer stmt.Close()

	_, err = stmt.Exec(sessionToken)
	if err != nil {
		return fmt.Errorf("error executing delete statement: %v", err)
	}

	// Clear the session cookie
	cookie = &http.Cookie{
		Name:     "session_token",
		Value:    "",
		Expires:  time.Unix(0, 0),
		HttpOnly: true,
		Path:     "/",
	}
	http.SetCookie(w, cookie)

	return nil
}

// ValidateSession checks if a session is valid
func ValidateSession(w http.ResponseWriter, r *http.Request, db *sql.DB) (*Session, error) {
	session, err := GetSession(r, db)
	if err != nil {
		// If the session is expired, delete it
		if err.Error() == "session expired" {
			err = DeleteSession(w, r, db)
			if err != nil {
				fmt.Printf("Error deleting expired session: %v\n", err)
			}
		}
		http.Redirect(w, r, "/signin", http.StatusSeeOther)
		return nil, err
	}
	return session, nil
}

// DeleteExpiredSessions deletes all expired sessions from the database
func DeleteExpiredSessions(db *sql.DB) error {
	_, err := db.Exec("DELETE FROM Sessions WHERE expires_at < ?", time.Now())
	if err != nil {
		return fmt.Errorf("error deleting expired sessions: %v", err)
	}
	return nil
}