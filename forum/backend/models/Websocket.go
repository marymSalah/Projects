package models

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"sync"
	"web-forum/backend/db"

	// "web-forum/backend/db"

	"github.com/gorilla/websocket"
)

// Server manages WebSocket connections and message routing
type Server struct {
	conns map[int]*websocket.Conn // Map userID to WebSocket connection
	mu    sync.RWMutex
}

// serverInstance is the singleton instance of Server
var serverInstance *Server
var once sync.Once

// GetServer returns the singleton instance of Server
func GetServer() *Server {
	once.Do(func() {
		serverInstance = &Server{
			conns: make(map[int]*websocket.Conn),
		}
	})
	return serverInstance
}

// HandleWS handles new WebSocket connections
func (ser *Server) HandleWS(w http.ResponseWriter, r *http.Request) {
	upgrader := websocket.Upgrader{
		CheckOrigin: func(r *http.Request) bool { return true },
	}
	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		fmt.Println("Error during WebSocket upgrade:", err)
		return
	}

	fmt.Println("New Incoming Connection from client:", ws.RemoteAddr())

	userID := ExtractUserIDFromQuery(r)
	if userID == 0 {
		fmt.Println("Failed to extract user ID from query")
		ws.Close()
		return
	}

	ser.mu.Lock()
	ser.conns[userID] = ws
	ser.mu.Unlock()

	defer func() {
		ser.mu.Lock()
		delete(ser.conns, userID)
		ser.mu.Unlock()
		ws.Close()
	}()

	ser.ReadLoop(ws)
}

// SendMessageToUser sends a message to a specific user by their user ID

func (s *Server) ReadLoop(ws *websocket.Conn) {
	userID, connected := s.GetUserIDFromConnection(ws)
	if !connected {
		fmt.Println("Error getting user ID")
		return
	}

	fmt.Printf("Starting ReadLoop for user %d\n", userID)

	// Mark user as online when they connect
	ChangeStatus(userID, "online")

	defer func() {
		fmt.Printf("ReadLoop ending for user %d\n", userID)
		// Mark user as offline when they disconnect
		ChangeStatus(userID, "offline")
	}()

	for {
		var message Messages
		err := ws.ReadJSON(&message)
		if err != nil {
			if websocket.IsCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
				fmt.Printf("Client %d disconnected: %v\n", userID, err)
			} else {
				fmt.Printf("Read error for user %d: %v\n", userID, err)
			}
			return
		}

		msg, err := json.Marshal(message)
		fmt.Printf("Received message from user %d: %s\n", userID, string(msg))
		if err != nil {
			fmt.Printf("Error marshalling message from user %d: %v\n", userID, err)
			continue
		}

		s.Broadcast(msg, nil)
	}
}

func ExtractUserIDFromQuery(r *http.Request) int {
	values := r.URL.Query()
	userIDStr := values.Get("username")
	fmt.Printf("Received userIDStr from query: %s\n", userIDStr)

	userID, err := strconv.Atoi(userIDStr)
	if err != nil {
		fmt.Printf("Error converting user ID: %v\n", err)
		return 0
	}
	fmt.Printf("Extracted User ID: %d\n", userID)
	return userID
}

// Broadcast sends a message to all connected users
func (s *Server) Broadcast(msg []byte, msg2 map[string]interface{}) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	var wg sync.WaitGroup
	for userID, ws := range s.conns {
		wg.Add(1)
		go func(id int, conn *websocket.Conn) {
			defer wg.Done()
			if err := conn.WriteMessage(websocket.TextMessage, msg); err != nil {
				fmt.Printf("Error broadcasting to user %d: %v\n", id, err)
			}
		}(userID, ws)
	}
	wg.Wait()

	var message Messages
	err := json.Unmarshal(msg, &message)
	if err != nil {
		fmt.Printf("Error unmarshalling message: %v\n", err)
		return
	}
	 if (message.MessageContent != "toottoot") {
		CreateMessage(message.SenderID, message.RecipientID, message.MessageContent)
		senderUsername, err := GetUsername(db.GetDB(), message.SenderID)
		if err != nil {
			fmt.Printf("Error getting sender username: %v\n", err)
			return
		}
		notificationContent := "You Recieved a New message from " + senderUsername
		AddNotification(message.RecipientID, notificationContent)
	 }

}

func (s *Server) GetUserIDFromConnection(ws *websocket.Conn) (int, bool) {
	s.mu.RLock()
	defer s.mu.RUnlock()
	for userID, conn := range s.conns {
		if conn == ws {
			return userID, true
		}
	}
	return 0, false
}

// CloseConnection closes the WebSocket connection for a specific user
func (s *Server) CloseConnection(userID int) {
	s.mu.Lock()
	defer s.mu.Unlock()

	if ws, exists := s.conns[userID]; exists {
		ws.Close()
		delete(s.conns, userID)
		fmt.Printf("Closed connection for user %d\n", userID)
	}
}
