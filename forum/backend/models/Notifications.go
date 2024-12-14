package models

import (
	"fmt"
	"time"
	"web-forum/backend/db"
)

type Notification struct {
	ID        int    `json:"id"`
	UserID    int    `json:"user_id"`
	Message   string `json:"message"`
	IsRead    bool   `json:"is_read"`
	CreatedAt string `json:"created_at"`
}

func AddNotification(userID int, message string) error {
	createdAt := time.Now().Format(time.RFC3339)
	db := db.GetDB()

	stmt, err := db.Prepare("INSERT INTO notifications (user_id, message, is_read, created_at) VALUES (?, ?, ?, ?)")
	if err != nil {
		return fmt.Errorf("error preparing insert statement: %v", err)
	}
	defer stmt.Close()

	_, err = stmt.Exec(userID, message, false, createdAt)
	if err != nil {
		return fmt.Errorf("error executing insert statement: %v", err)
	}
	fmt.Println("Notification added successfully")
	return nil
}

func MarkAsRead(userid int) error {
	db := db.GetDB()

	stmt, err := db.Prepare("UPDATE notifications SET is_read = true WHERE user_id = ?")
	if err != nil {
		return fmt.Errorf("error preparing update statement: %v", err)
	}
	defer stmt.Close()
	_, err = stmt.Exec(userid)
	if err != nil {
		return fmt.Errorf("error executing update statement: %v", err)
	}
	return nil
}

func GetNotifications(userid int) ([]Notification, error) {
	db := db.GetDB()

	rows, err := db.Query("SELECT * FROM notifications WHERE user_id = ?", userid)
	if err != nil {
		return nil, fmt.Errorf("error querying notifications: %v", err)
	}
	defer rows.Close()
	notifications := []Notification{}
	for rows.Next() {
		var notification Notification
		err := rows.Scan(&notification.ID, &notification.UserID, &notification.Message, &notification.IsRead, &notification.CreatedAt)
		if err != nil {
			return nil, fmt.Errorf("error scanning notification: %v", err)
		}
		notifications = append(notifications, notification)
	}
	return notifications, nil
}

func GetUnReadNotification(userid int) ([]Notification, int, error) {
	db := db.GetDB()
	count := 0

	rows, err := db.Query("SELECT * FROM notifications WHERE user_id = ? AND is_read = false", userid)
	if err != nil {
		return nil, 0, fmt.Errorf("error querying notifications: %v", err)
	}
	defer rows.Close()
	notifications := []Notification{}
	for rows.Next() {
		var notification Notification
		err := rows.Scan(&notification.ID, &notification.UserID, &notification.Message, &notification.IsRead, &notification.CreatedAt)
		if err != nil {
			return nil, 0, fmt.Errorf("error scanning notification: %v", err)
		}
		notifications = append(notifications, notification)
		count++
	}
	return notifications, count, nil
}
