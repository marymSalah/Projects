import { loadCSS } from '../components/cssLoader.js';
import { handleSendMessage, displayUsers,handleTyping } from '../components/messages/messageHandler.js';
import { getWebSocket, getUserIDFromWS, initializeWebSocket } from '../components/websockets/websocket.js';
import { handleLogout } from '../components/auth/logout.js';

loadCSS('./static/style.css');
let ws;

export function renderPrivateMessagePage() {
        // Check if user is logged in
        const loggedInUserID = localStorage.getItem('userID');
        if (!loggedInUserID) {
            console.error('No logged in user found');
            window.location.href = '#signin';
            return;
        }
    
        // Initialize WebSocket if not already initialized
        if (!ws) {
            initializeWebSocket(loggedInUserID);
            // Wait for WebSocket to be established
            setTimeout(() => {
                ws = getWebSocket();
                if (!ws) {
                    console.error('Failed to initialize WebSocket');
                    window.location.href = '#signin';
                    return;
                }
                renderPageWithWebSocket(ws);
            }, 1000);

            
        } else {
            renderPageWithWebSocket(ws);
        }
}

export function renderPageWithWebSocket(ws) {
    const loggedInUser = getUserIDFromWS(ws);
    if (!loggedInUser) {
        const storedUserID = localStorage.getItem('userID');
        if (storedUserID) {
            // Reinitialize WebSocket if user ID exists but WebSocket is not connected
            initializeWebSocket(storedUserID);
            setTimeout(() => {
                ws = getWebSocket();
                if (ws) {
                    renderMainPostws(ws);
                } else {
                    console.error('Failed to reinitialize WebSocket');
                    window.location.href = '#signin';
                }
            }, 1000);
            return;
        }
        console.error('Failed to get logged-in user from WebSocket');
        window.location.href = '#signin';
        return;
    } else {
        console.log('Logged in user:', loggedInUser);
    }


    const app = document.getElementById('app');
    if (!app) {
        console.error('Element with ID "app" not found');
        return;
    }

    app.innerHTML = `
        <div class="container">
            <div class="header">
                <div class="header-placeholder"></div>
                    <div class="welcome-section">
                        <h1 class="welcome-heading">
                            <span class="icon-container">
                                <i class="fas fa-lightbulb"></i>
                            </span>Welcome to <span class="forum-text">fikra</span>
                        </h1>
                    </div>
                <div class="links-section">
                <button onclick="window.location.href='#mainPost'">Back to Main Page</button>
                    
                    <button id="logoutBtn">Logout</button>
            </div>
        </div>
        <div class="app-container">
            <div class="chat-container">
                <div class="chat-header" id="chat-header">
                    <h2 id="chat-header-username"><span id="us"></span>'s Chats</h2>
                    <p id="typing"></p>
                    <p id="st" hidden></p>
                    <p id="rID" hidden></p>
                </div>
                <div class="chat-messages" id="chat-messages"></div>
                <div class="input-area">
                    <form action="/privateMessage" method="POST" id="message-form" hidden>
                        <input type="hidden" name="receiverID" id="receiverID" value="">
                        <input type="hidden" name="senderID" id="senderID" value="">
                        <input type="text" name="messageInput" id="messageInput" placeholder="Type a message...">
                        <button type="submit" id="send-button">➤</button>
                        
                    </form>
                </div>
            </div>
            <div class="users-container">
                <div class="users-header">
                    <h2>Users</h2>
                </div>
                <div class="users-list" id="users-list">
                    <!-- Users will be dynamically inserted here -->
                </div>
            </div>
        </div>
    `;

    document.getElementById('us').innerText = "User";
    const messageForm = document.getElementById('message-form');
    if (messageForm) {
        messageForm.addEventListener('submit', (event) => {
            event.preventDefault();
            handleSendMessage(loggedInUser);
        });
    }


    displayUsers(loggedInUser);
    setupEventListeners();
}

function setupEventListeners() {
    document.getElementById('logoutBtn').addEventListener('click', () => {
        handleLogout(ws); 
    });
    
    console.log("hello");


    const messageInput = document.getElementById('messageInput');
    const receiver = document.getElementById('receiverID');
    const senderId = document.getElementById('senderID');
    console.log("senderID", senderId.value);
  
    const loggedInUserID = localStorage.getItem('userID');

    console.log("loggedInUserID", loggedInUserID);
    messageInput.addEventListener('input', () => {
        const typing = {
            sender_id: loggedInUserID,
            recipient_id: receiver.value,
            message_content: "toottoot"
        };

        console.log('sending to websocket', typing);

        handleTyping(loggedInUserID);
        
    });
}