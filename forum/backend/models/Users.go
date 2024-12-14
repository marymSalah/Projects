package models

import (
	"database/sql"
	"fmt"
	"regexp"
	"strings"
	"time"
	"web-forum/backend/db"

	// "web-forum/backend/db"

	_ "github.com/mattn/go-sqlite3"
	"golang.org/x/crypto/bcrypt"
)

type Users struct {
	ID        int       `json:"id"`
	Username  string    `json:"username"`
	FirstName string    `json:"first_name"`
	LastName  string    `json:"last_name"`
	Gender    string    `json:"gender"`
	DOB       time.Time `json:"dob"`
	Email     string    `json:"email"`
	Password  string    `json:"password,omitempty"`
	CreatedAt time.Time `json:"created_at"`
	Status    string    `json:"status"`
}

// --------------------- Registration + Login --------------------------------

// RegisterUser inserts a new user into the database
func RegisterUser(db *sql.DB, username, password, email, fname, lname, gender string, dob time.Time) error {

	// Prepare the SQL statement
	stmt, err := db.Prepare("INSERT INTO Users (username, first_name, last_name, email, password, dob, age, gender, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")
	if err != nil {
		return fmt.Errorf("failed to prepare statement: %v", err)
	}
	defer stmt.Close()

	// Calculate age from dob
	age := calculateAge(dob)

	// Get the current timestamp
	createdAt := time.Now().Format(time.RFC3339)

	// Execute the statement with parameter binding
	_, err = stmt.Exec(username, fname, lname, email, password, dob.Format("2006-01-02"), age, gender, createdAt)
	if err != nil {
		return fmt.Errorf("failed to execute statement: %v", err)
	}

	return nil
}

// LoginUser checks if the provided username and password match a record in the Users table
func LoginUser(db *sql.DB, usernameOrEmail, password string) (bool, error) {
	var hashedPassword string
	err := db.QueryRow("SELECT password FROM Users WHERE username = ? OR email = ?", usernameOrEmail, usernameOrEmail).Scan(&hashedPassword)
	if err != nil {
		if err == sql.ErrNoRows {
			// Username/Email not found
			fmt.Println("Username or Email not found")
			return false, nil
		}
		return false, fmt.Errorf("error querying database: %v", err)
	}

	// Compare the provided password with the hashed password from the database
	err = bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
	if err != nil {
		// Invalid password
		fmt.Println("Invalid password")
		return false, nil
	}

	// Username/Email and password match
	return true, nil
}
// ----------------------------- Getters ----------------------------------

// GetUserID retrieves the user ID based on the username
func GetUserID(db *sql.DB, username string) (int, error) {
	var userID int
	err := db.QueryRow("SELECT id FROM Users WHERE username = ? OR email = ?", username, username).Scan(&userID)
	if err != nil {
		return 0, fmt.Errorf("error querying user ID: %v", err)
	}
	return userID, nil
}

// GetUsername retrieves the username based on the user ID
func GetUsername(db *sql.DB, userID int) (string, error) {
	var username string
	err := db.QueryRow("SELECT username FROM Users WHERE id = ?", userID).Scan(&username)
	if err != nil {
		if err == sql.ErrNoRows {
			return "", fmt.Errorf("user ID not found")
		}
		return "", fmt.Errorf("error querying username: %v", err)
	}
	return username, nil
}

// ---------------------------- VALIDATION ------------------------------

func ValidateUsername(db *sql.DB, username string) error {
	// Check if the username is empty
	if len(username) == 0 {
		return fmt.Errorf("username cannot be empty")
	}

	// Check the length of the username
	if len(username) < 3 {
		return fmt.Errorf("username must be at least 3 characters")
	}

	// Check if the username exceeds the maximum length
	if len(username) > 25 {
		return fmt.Errorf("username cannot be more than 25 characters")
	}

	// Check if the username contains only allowed characters
	matched, err := regexp.MatchString("^[a-zA-Z0-9_.]+$", username)
	if err != nil {
		return fmt.Errorf("error validating username: %v", err)
	}
	if !matched {
		return fmt.Errorf("username can only contain letters, numbers, underscores, and dots")
	}

	// Check if the username contains spaces
	if strings.Contains(username, " ") {
		return fmt.Errorf("username cannot contain spaces")
	}

	// Check if the username is already taken
	err = db.QueryRow("SELECT 1 FROM Users WHERE username = ?", username).Scan(&[]byte{})
	if err == nil {
		// Username already exists
		return fmt.Errorf("username already exists")
	} else if err != sql.ErrNoRows {
		return fmt.Errorf("error querying database: %v", err)
	}

	return nil
}

func ValidatePassword(password string) error {
	// Check if the password is empty
	if len(password) == 0 {
		return fmt.Errorf("password cannot be empty")
	}

	// Check the length of the password
	if len(password) < 8 {
		return fmt.Errorf("password must be at least 8 characters")
	}

	// Check if the password exceeds the maximum length
	if len(password) > 30 {
		return fmt.Errorf("password cannot be more than 30 characters")
	}

	// Check if the password contains at least one uppercase letter
	matched, err := regexp.MatchString("[A-Z]", password)
	if err != nil {
		return fmt.Errorf("error validating password: %v", err)
	}
	if !matched {
		return fmt.Errorf("password must contain at least one uppercase letter")
	}

	// Check if the password contains at least one lowercase letter
	matched, err = regexp.MatchString("[a-z]", password)
	if err != nil {
		return fmt.Errorf("error validating password: %v", err)
	}
	if !matched {
		return fmt.Errorf("password must contain at least one lowercase letter")
	}

	// Check if the password contains at least one digit
	matched, err = regexp.MatchString("[0-9]", password)
	if err != nil {
		return fmt.Errorf("error validating password: %v", err)
	}
	if !matched {
		return fmt.Errorf("password must contain at least one digit")
	}

	// Check if the password contains spaces
	if matched, _ := regexp.MatchString(`\s`, password); matched {
		return fmt.Errorf("password cannot contain spaces")
	}

	// Check if the password contains any symbols
	matched, err = regexp.MatchString(`[!@#\$%\^&\*(),.?":{}|<>]`, password)
	if err != nil {
		return fmt.Errorf("error validating password: %v", err)
	}
	if matched {
		return fmt.Errorf("password cannot contain special symbols")
	}

	return nil
}

func IsUserLoggedIn(db *sql.DB, username string) (bool, error) {
	var userID int
	err := db.QueryRow("SELECT id FROM Sessions WHERE username = ?", username).Scan(&userID)
	if err != nil {
		if err == sql.ErrNoRows {
			return false, nil
		}
		return false, fmt.Errorf("error querying user ID: %v", err)
	}
	return true, nil
}

// UserExists checks if a username or email already exists in the database
func UserExists(db *sql.DB, username, email string) (bool, error) {
	var count int
	query := `SELECT COUNT(*) FROM Users WHERE username = ? OR email = ?`
	err := db.QueryRow(query, username, email).Scan(&count)
	if err != nil {
		return false, err
	}
	return count > 0, nil
}

// calculateAge computes age based on date of birth
func calculateAge(dob time.Time) int {
	now := time.Now()
	age := now.Year() - dob.Year()
	if now.YearDay() < dob.YearDay() {
		age--
	}
	return age
}

func GetUserByID(db *sql.DB, userID int) (*Users, error) {
	var user Users
	query := `SELECT id, username, first_name, last_name, email, dob, gender, created_at FROM Users WHERE id = ?`
	err := db.QueryRow(query, userID).Scan(
		&user.ID,
		&user.Username,
		&user.FirstName,
		&user.LastName,
		&user.Email,
		&user.DOB,
		&user.Gender,
		&user.CreatedAt,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("user not found")
		}
		return nil, fmt.Errorf("error retrieving user: %v", err)
	}

	return &user, nil
}

// GetAllUsers retrieves all users from the database
func GetAllUsers(db *sql.DB) ([]Users, error) {
	var users []Users
	query := `SELECT id, username, first_name, last_name, email, dob, gender, created_at, status FROM Users`

	rows, err := db.Query(query)
	if err != nil {
		return nil, fmt.Errorf("error querying database: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var user Users
		if err := rows.Scan(
			&user.ID,
			&user.Username,
			&user.FirstName,
			&user.LastName,
			&user.Email,
			&user.DOB,
			&user.Gender,
			&user.CreatedAt,
			&user.Status,
		); err != nil {
			return nil, fmt.Errorf("error scanning row: %v", err)
		}
		users = append(users, user)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating rows: %v", err)
	}

	return users, nil
}

func ChangeStatus(uid int, status string) (bool, error) {
	db := db.GetDB()
	// change the status in the users table from offline to online based on the logged in user
	stmt, err := db.Prepare("UPDATE Users SET status =? WHERE id = ?;")
	if err != nil {
		return false, fmt.Errorf("failed to prepare statement: %v", err)
	}
	defer stmt.Close()

	_, err = stmt.Exec(status, uid)
	if err != nil {
		return false, fmt.Errorf("failed to execute statement: %v", err)
	}

	return true, nil
}
