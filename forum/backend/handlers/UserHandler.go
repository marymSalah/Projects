package handlers

import (
	"encoding/json"
	"log"
	"net/http"
	"time"

	"web-forum/backend/db"
	"web-forum/backend/models"

	"golang.org/x/crypto/bcrypt"
)

// ---------------------- SIGNIN and REGISTER HANDLERS -------------------------

func SigninHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		username := r.FormValue("username")
		password := r.FormValue("password")

		// Debugging: Print received values
		log.Println("Received username:", username)
		log.Println("Received password:", password)

		// Validate if user exists
		exists, err := models.LoginUser(db.GetDB(), username, password)
		if err != nil {
			log.Printf("Error logging user: %v", err)
			http.Error(w, `{"error": "Internal Server Error"}`, http.StatusInternalServerError)
			return
		}
		if !exists {
			log.Println("Invalid username or password")
			w.Header().Set("Content-Type", "application/json")
			w.WriteHeader(http.StatusUnauthorized) // Send 401 for unauthorized
			json.NewEncoder(w).Encode(map[string]string{"error": "Invalid username or password"})
			return
		}

		// Create session
		userID, _ := models.GetUserID(db.GetDB(), username)
		err = models.CreateSession(w, r, db.GetDB(), userID)
		if err != nil {
			log.Printf("Error creating session: %v", err)
			http.Error(w, `{"error": "Internal Server Error"}`, http.StatusInternalServerError)
			return
		}

		// Change status
		_, err = models.ChangeStatus(userID, "online")
		if err != nil {
			log.Printf("Error changing status: %v", err)
			http.Error(w, `{"error": "Internal Server Error"}`, http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]int{"user_id": userID})
	}
}

func RegisterHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	
	if r.Method != http.MethodPost {
		http.Error(w, `{"error": "Method Not Allowed"}`, http.StatusMethodNotAllowed)
		return
	}

	db := db.GetDB()
	username := r.FormValue("username")
	password := r.FormValue("password")
	email := r.FormValue("email")
	dobStr := r.FormValue("dob")
	gender := r.FormValue("gender")
	fname := r.FormValue("fname")
	lname := r.FormValue("lname")

	// Helper function to write JSON error responses
	writeJSONError := func(errMsg string, statusCode int) {
		w.WriteHeader(statusCode)
		json.NewEncoder(w).Encode(map[string]string{"error": errMsg})
	}

	// Input Validation with JSON Error Responses
	if err := models.ValidateUsername(db, username); err != nil {
		writeJSONError(err.Error(), http.StatusBadRequest)
		return
	}

	if err := models.ValidatePassword(password); err != nil {
		writeJSONError(err.Error(), http.StatusBadRequest)
		return
	}

	if email == "" {
		writeJSONError("Email cannot be empty.", http.StatusBadRequest)
		return
	}

	// Check if username or email already exists
	exists, err := models.UserExists(db, username, email)
	if err != nil {
		log.Printf("Error checking user existence: %v", err)
		writeJSONError("Internal Server Error: unable to verify username/email", http.StatusInternalServerError)
		return
	}
	if exists {
		writeJSONError("Username or email already exists.", http.StatusConflict)
		return
	}

		// Hash the password
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
		if err != nil {
			log.Printf("Error hashing password: %v", err)
			writeJSONError("Internal Server Error: unable to process password", http.StatusInternalServerError)
			return
		}

		// Parse the date of birth string into a time.Time value
		dob, err := time.Parse("2006-01-02", dobStr)
		if err != nil {
			writeJSONError("Invalid date of birth format; please use YYYY-MM-DD", http.StatusBadRequest)
			return
		}

		// Save user data to the database
		err = models.RegisterUser(db, username, string(hashedPassword), email, fname, lname, gender, dob)
		if err != nil {
			log.Printf("Error saving user to database: %v", err)
			writeJSONError("Internal Server Error: unable to complete registration", http.StatusInternalServerError)
			return
		}
	}


// LogoutHandler handles user logout
func LogoutHandler(w http.ResponseWriter, r *http.Request) {
	// Retrieve the session to get the user ID
	session, err := models.GetSession(r, db.GetDB())
	if err != nil {
		log.Printf("Error getting session: %v", err)
		http.Error(w, "Error getting session", http.StatusInternalServerError)
		return
	}
	// Extract user ID from the session
	uid := session.UserID
	// Delete the session from the database
	err = models.DeleteSession(w, r, db.GetDB())
	if err != nil {
		log.Printf("Error logging out: %v", err)
		http.Error(w, "Error logging out", http.StatusInternalServerError)
		return
	}

	// Change the user's status to "offline"
	_, err = models.ChangeStatus(uid, "offline")
	if err != nil {
		log.Printf("Failed executing the statement: %v", err)
		http.Error(w, "Failed executing the statement", http.StatusInternalServerError)
		return
	}

	// Close the WebSocket connection for the user
	server := models.GetServer()
	server.CloseConnection(uid)

	// Send a success response
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Logged out successfully"))
}

func ProfileHandler(w http.ResponseWriter, r *http.Request) {
	// Retrieve the session to get the logged-in user's ID
	session, err := models.GetSession(r, db.GetDB())
	if err != nil || session == nil {
		log.Printf("Error getting session: %v", err)
		http.Redirect(w, r, "/signin", http.StatusSeeOther)
		return
	}

	// Fetch user details using the session's user ID
	user, err := models.GetUserByID(db.GetDB(), session.UserID)
	if err != nil {
		log.Printf("Error retrieving user data: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	Pro := struct {
		UserID int
		User   *models.Users
	}{
		UserID: session.UserID,
		User:   user,
	}

	w.Header().Set("Content-Type", "application/json")
	if err = json.NewEncoder(w).Encode(Pro); err != nil {
		log.Printf("Error encoding JSON: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

// UserPageHandler handles requests to fetch and display all users
func UserPageHandler(w http.ResponseWriter, r *http.Request) {
	// Validate session
	session, err := models.ValidateSession(w, r, db.GetDB())
	if err != nil {
		log.Printf("Error validating session: %v", err)
		http.Redirect(w, r, "/signin", http.StatusSeeOther)
		return
	}

	// Fetch users
	users, err := models.GetAllUsers(db.GetDB())
	if err != nil {
		log.Printf("Error fetching users: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	// Prepare data for the template
	Profile := struct {
		UserID int
		Users  []models.Users
	}{
		UserID: session.UserID,
		Users:  users,
	}

	w.Header().Set("Content-Type", "application/json")
	if err = json.NewEncoder(w).Encode(Profile); err != nil {
		log.Printf("Error encoding JSON: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}
