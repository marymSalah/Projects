import { validateForm } from '../components/validation/validateForm.js';
import { loadCSS } from '../components/cssLoader.js';
import { handleLogout } from '../components/auth/logout.js'
import { getWebSocket, getUserIDFromWS, initializeWebSocket } from '../components/websockets/websocket.js';
import { displayUsers } from '../components/messages/messageHandler.js';


loadCSS('./static/style.css');
let ws;

export function renderCreatePostPage() {
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
            renderCreatePostPageWS(ws);
        }, 1000);
    } else {
        renderCreatePostPageWS(ws);
    }
}

export function renderCreatePostPageWS(ws) {    
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

    loadCSS('./static/style.css');
    
    app.innerHTML = `
        <div class="creatingcontainer">
            <div class="header">
                <div class="welcome-section">
                    <h1 class="welcome-heading"> 
                        <span class="icon-container">
                            <i class="fas fa-lightbulb"></i>
                        </span>
                        Welcome to <span class="forum-text">fikra</span>
                    </h1>
                </div>
                <div class="links-section">
                    <button id="mainPageBtn">Main Page</button>
                    <button id="logoutBtn">Logout</button>
                </div>
            </div>

            <div class="form-and-sidebar-container">
                <form id="create-post-form">
                    <div class="messtrial"></div>
                    <div class="main-creating">
                        <h3>Creating post ...</h3>
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" id="title" name="title" required><br>
                            <span id="title-error" class="error-message hidden"></span><br>
                        </div>
                        <div class="form-group">
                            <label for="content">Content</label>
                            <textarea id="content" name="content" rows="10" required></textarea><br>
                            <span id="content-error" class="error-message hidden"></span><br>
                        </div>
                        <div class="form-group">
                        <label for="category">Categories</label>
                        <select id="category" name="category" required>
                            <option value=1>Technology</option>
                            <option value=2>Sports</option>
                            <option value=3>Music</option>
                            <option value=4>Life</option>
                            <option value=5>Random</option>
                            </select>
                            <span id="category-error" class="error-message hidden"></span><br>
                        </div>
                            <button type="submit">
                            <i class="fas fa-paper-plane"></i> Send
                        </button>

                    </div>
                </form>
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

    // Attach event listeners instead of inline handlers
    document.getElementById('mainPageBtn').addEventListener('click', () => {
        window.location.hash = 'mainPost'; // Use hash for navigation
    });

    document.getElementById('logoutBtn').addEventListener('click', () => {
        handleLogout(ws);
    });

    // Add event listener for form validation and submission
    document.getElementById('create-post-form').addEventListener('submit', async (event) => {
        event.preventDefault(); // Prevent default form submission

        console.log('Form submitted');
        const title = document.getElementById('title').value;
        const content = document.getElementById('content').value;
        const categorystring = document.getElementById('category').value;
        const category = parseInt(categorystring);
        

        // Validate inputs
        if (!validateForm()) {
            console.log('Validation failed');
            return; // If validation fails, stop submission
        }

        // Send the POST request to the backend as JSON
        try {
            console.log('Sending POST request to /createPost');
            const response = await fetch('/createPost', { // Normal URL
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ title, content, category }),
            });

            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(errorText);
            }

            // Redirect or show success message on success
            window.location.hash = 'mainPost'; // Use hash for navigation
        } catch (error) {
            console.error('Error creating post:', error);
            // Optionally, show an error message to the user
        }
    });

    displayUsers(loggedInUser);
}