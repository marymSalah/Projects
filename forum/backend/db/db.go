package db

import (
	"database/sql"
	"fmt"

	_ "github.com/mattn/go-sqlite3"
)

var database *sql.DB

// InitDatabase initializes the database schema and opens a connection
func InitDatabase() error {
	var err error
	database, err = sql.Open("sqlite3", "./backend/db/forum.db")
	if err != nil {
		return fmt.Errorf("error opening database: %v", err)
	}

	schema := getSchema()
	// Create all tables
	_, err = database.Exec(schema)
	if err != nil {
		return fmt.Errorf("error creating tables: %v", err)
	}

	return nil
}

// CloseDatabase closes the database connection
func CloseDatabase() error {
	if database != nil {
		return database.Close()
	}
	return nil
}

func GetDB() *sql.DB {
	return database
}

// getSchema returns the SQL schema as a string
func getSchema() string {
	return `-- Users table
	CREATE TABLE IF NOT EXISTS Users (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		username TEXT NOT NULL UNIQUE,             
		first_name TEXT NOT NULL,    
		last_name TEXT NOT NULL,     
		email TEXT NOT NULL UNIQUE,  
		password TEXT NOT NULL,      
		dob DATE,                    
		age INTEGER,                 
		gender TEXT,                 
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
		status TEXT DEFAULT 'offline'
	);
	

	-- Posts table
	CREATE TABLE IF NOT EXISTS Posts (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		user_id INTEGER NOT NULL,
		title TEXT NOT NULL,
		content TEXT NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (user_id) REFERENCES Users(id)
	);

	-- Comments table
	CREATE TABLE IF NOT EXISTS Comments (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		post_id INTEGER NOT NULL,
		user_id INTEGER NOT NULL,
		content TEXT NOT NULL,
		username TEXT NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (post_id) REFERENCES Posts(id),
		FOREIGN KEY (user_id) REFERENCES Users(id)
	);

	-- Categories table
	CREATE TABLE IF NOT EXISTS Categories (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL UNIQUE
	);


	-- Sessions table
	CREATE TABLE IF NOT EXISTS Sessions (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		user_id INTEGER NOT NULL,
		token TEXT NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		expires_at TIMESTAMP NOT NULL,
		FOREIGN KEY (user_id) REFERENCES Users(id)
	);

	-- Messages table
	CREATE TABLE IF NOT EXISTS Messages (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		sender_id INTEGER NOT NULL,
		recipient_id INTEGER NOT NULL,
		message_content TEXT NOT NULL,
		sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (sender_id) REFERENCES Users(id), 
		FOREIGN KEY (recipient_id) REFERENCES Users(id)
	);

	CREATE TABLE IF NOT EXISTS Notifications (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		user_id INTEGER NOT NULL,
		message TEXT NOT NULL,
		is_read boolean DEFAULT false,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (user_id) REFERENCES Users(id)
	);

	CREATE TABLE IF NOT EXISTS PostCategories (
		post_id INTEGER NOT NULL,
		category_id INTEGER NOT NULL,
		PRIMARY KEY (post_id, category_id),
		FOREIGN KEY (post_id) REFERENCES Posts(id),
		FOREIGN KEY (category_id) REFERENCES Categories(id)
	);

	INSERT OR IGNORE INTO Posts (id, user_id, title, content) VALUES 
		(1, 1, 'Welcome to my blog!', 'This is my first post. Excited to share my thoughts here!'),
		(2, 2, 'Best Coding Practices', 'Some insights on best practices for coding'),
		(3, 1, 'Tips for Data Science', 'Sharing some data science tips and resources.'),
		(4, 3, 'Traveling the World', 'Just returned from my trip around Europe! Here are my experiences.');


	INSERT OR IGNORE INTO Comments (id, post_id, user_id, content, username) VALUES 
		(1, 1, 2, 'Great post! Looking forward to more.', 'msalah'),
		(2, 1, 3, 'Thanks for sharing!', 'rali'),
		(3, 2, 1, 'Very informative, thanks for the tips.', 'fnaser'),
		(4, 3, 2, 'I love data science too!', 'msalah');

	-- Inserting Sample Data into Categories table
	INSERT INTO Categories (name) SELECT 'Technology' WHERE NOT EXISTS (SELECT 1 FROM Categories WHERE name = 'Technology');
	INSERT INTO Categories (name) SELECT 'Sports' WHERE NOT EXISTS (SELECT 1 FROM Categories WHERE name = 'Sports');
	INSERT INTO Categories (name) SELECT 'Music' WHERE NOT EXISTS (SELECT 1 FROM Categories WHERE name = 'Music');
	INSERT INTO Categories (name) SELECT 'Life' WHERE NOT EXISTS (SELECT 1 FROM Categories WHERE name = 'Life');
	INSERT INTO Categories (name) SELECT 'Random' WHERE NOT EXISTS (SELECT 1 FROM Categories WHERE name = 'Random');

	INSERT OR IGNORE INTO PostCategories (post_id, category_id) VALUES 
		(1, 5), 
		(2, 1),
		(3, 1),
		(4, 4);
		`
}
