package models

import (
	"log"
	"time"
	"web-forum/backend/db"
)

type Messages struct {
	ID             int       `json:"id"`
	SenderID       int       `json:"sender_id"`
	RecipientID    int       `json:"recipient_id"`
	MessageContent string    `json:"message_content"`
	SentAt         time.Time `json:"created_at"`
}

func CreateMessage(senderID, recipientID int, messageContent string) {
	sentAt := time.Now()

	stat, err := db.GetDB().Prepare("INSERT INTO Messages (sender_id, recipient_id, message_content, sent_at) VALUES (?, ?, ?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer stat.Close()
	_, err = stat.Exec(senderID, recipientID, messageContent, sentAt)
	if err != nil {
		log.Fatal(err)
	}
}

func GetRecievedMessages(recipientID int) ([]Messages, error) {
	rows, err := db.GetDB().Query("SELECT * FROM Messages WHERE recipient_id = ?", recipientID)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	var messages []Messages
	for rows.Next() {
		var message Messages
		err := rows.Scan(&message.ID, &message.SenderID, &message.RecipientID, &message.MessageContent, &message.SentAt)
		if err != nil {
			log.Fatal(err)
			return []Messages{}, err
		}
		messages = append(messages, message)
	}
	return messages, nil
}

func GetSentMessages(senderID int) ([]Messages, error) {
	rows, err := db.GetDB().Query("SELECT * FROM Messages WHERE sender_id = ?", senderID)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	var messages []Messages
	for rows.Next() {
		var message Messages
		err := rows.Scan(&message.ID, &message.SenderID, &message.RecipientID, &message.MessageContent, &message.SentAt)
		if err != nil {
			log.Fatal(err)
			return []Messages{}, err
		}
		messages = append(messages, message)
	}
	return messages, nil
}
