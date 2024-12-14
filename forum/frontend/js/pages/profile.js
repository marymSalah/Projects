import { loadCSS } from '../components/cssLoader.js'; 
import { formatDate } from '../components/profile/formatdate.js';
import { handleLogout } from '../components/auth/logout.js';
import { getWebSocket, initializeWebSocket, getUserIDFromWS } from '../components/websockets/websocket.js';
import { displayUsers } from '../components/messages/messageHandler.js';

loadCSS('../static/style.css'); // Corrected path for style.css
let ws;

export function initProfilePage(app, userData) {
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
                initProfilePageWS(app, userData, ws);
            }, 1000);
        } else {
            initProfilePageWS(app, userData, ws);
        }
}

export function initProfilePageWS(app, userData, ws) {
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
    const userInfo = userData.User || {};           
        
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
      <div class="users-container">
            <div class="users-header">
                <h2>Users</h2>
            </div>
            <div class="users-list" id="users-list">
                <!-- Users will be dynamically inserted here -->
            </div>
    </div>
    <div class="profilecontainer">
            <div class="profile-header">
            <h1>${userInfo.first_name || 'N/A'} ${userInfo.last_name || 'N/A'}</h1>
            <p>Username: ${userInfo.username || 'N/A'}</p>
            <p>Email: ${userInfo.email || 'N/A'}</p>
            <p>${userInfo.dob ? formatDate(userInfo.dob) : 'N/A'}</p>
            </div>
            <div class="profile-details">
                <h2>Personal Information</h2>
                <p><strong>Date of Birth:</strong> ${userInfo.dob ? formatDate(userInfo.dob) : 'N/A'}</p>
                <p><strong>Gender:</strong> ${userInfo.gender || 'N/A'}</p>
                <p><strong>Member Since:</strong> ${userInfo.created_at ? formatDate(userInfo.created_at) : 'N/A'}</p>
            </div>
    </div>
  
    `;

    setupEventListeners();
    displayUsers(loggedInUser);
}

function setupEventListeners() {
    document.getElementById('logoutBtn').addEventListener('click', () => {
        handleLogout(ws); 
    });
}
