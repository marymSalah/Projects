// pages/mainPost.js
import { formatPostContent, fetchPosts } from '../components/posts/postHandlers.js';
import { loadCSS } from '../components/cssLoader.js';
import { handleLogout } from '../components/auth/logout.js'
import { getWebSocket, getUserIDFromWS, initializeWebSocket } from '../components/websockets/websocket.js';
import {displayNotifications, fetchNotifications, setNotificationsAsRead} from '../components/notifications/notificationHandler.js';
import { displayUsers } from '../components/messages/messageHandler.js';

loadCSS('../static/style.css');
let data;
let ws;

export function renderMainPost() {
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
            renderMainPostws(ws);
        }, 1000);
    } else {
        renderMainPostws(ws);
    }
}

export function renderMainPostws(ws) {
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
    const mainPostPage = `
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
                <div class="notification-wrapper">
                    <button id="notiBtn" class="notification-icon">
                        <i class="fa-regular fa-bell"></i>
                        <span id="notiBadge" class="notification-dot"></span> 
                    </button>
                    <div id="notiDropdown" class="notification-dropdown" hidden>
                        <div class="dropdown-header">Notifications</div>
                        <ul class="dropdown-list">
                        </ul>
                    </div>
                </div>        
                <button id="profileBtn"><i class="fas fa-user"></i></button>
                <button id="privMsgBtn"><i class="fas fa-comments"></i></button>
                <button onclick="window.location.href='#mainPost'">Main Page</button>
                <button id="createPostBtn">Create a Post</button>
                <button id="logoutBtn">Logout</button>
            </div>
        </div>
        <div class="content-wrapper">
            <div class="leftContainerMain">
                <div class="users-section-main">
                    <div class="users-header">
                        <h2>Users</h2>
                    </div>
                    <div class="users-list" id="users-list">
                        <!-- Users will be dynamically inserted here -->
                    </div>
                </div>
            </div>
            <div class=rightContainerMain>
                <div id="mainPostSection" class="mainPostSection"></div>
            </div>

        </div>

    </div>
    `;

    app.innerHTML = mainPostPage;

    // Call functions to set up the page
    displayUsers(loggedInUser);
    displayPosts();
    formatPostContent();
    setupEventListeners();
    data = fetchNotifications();
    const notiDot = document.getElementById('notiBadge');
    if (data.num == 0) {
        notiDot.style.display = 'none';
        console.log('No unread notifications');
    } else {
        notiDot.style.display = 'block';
        console.log('Unread notifications:', data.num);
    }
    let uid = localStorage.getItem('userID'); 
    console.log('uid:', uid);
    
}


function setupEventListeners() {
    document.getElementById('profileBtn').addEventListener('click', () => {
        window.location.href = '#profile';
    });

    document.getElementById('privMsgBtn').addEventListener('click', () => {
        window.location.href = '#privateMessage';
    });

    document.getElementById('createPostBtn').addEventListener('click', () => {
        window.location.href = '#createPost'});


    document.getElementById('logoutBtn').addEventListener('click', () => {
         handleLogout(ws);
    });

    // Update fetchNotifications to handle visibility and call displayNotifications
    document.getElementById('notiBtn').addEventListener('click', async () => {
        
        const data = await fetchNotifications();
        if (data) {
            console.log('Received data:', data);
            displayNotifications(data);
        }
        await setNotificationsAsRead();
        
        // Toggle visibility of dropdown
        const notiDropdown = document.getElementById('notiDropdown');
        notiDropdown.hidden = !notiDropdown.hidden;
    });

}

async function displayPosts() {
    let postSection = document.getElementById('mainPostSection');
    if (!postSection) {
        console.error('Element with ID "mainPostSection" not found');
        return;
    }
    postSection.innerHTML = '';  // Clear any existing content

    try {
        const posts = await fetchPosts();
        
        if (!Array.isArray(posts)) {
            console.error('Fetched posts is not an array:', posts);
            postSection.innerHTML = '<div class="no-posts-message"><p>Error: Posts data is not valid.</p></div>';
            return;
        }
        
        if (posts.length === 0) {
            postSection.innerHTML = '<div class="no-posts-message"><p>No posts available.</p></div>';
            return;
        }

        for (const post of posts) {
            console.log('Post data:', post);
            const postElement = document.createElement('div');
            postElement.className = 'mainPostCard';

            postElement.innerHTML = `
            <div class="mainPostCardContent">
                <div class="mainPostCardMeta">
                    <div class="mainPostCardUsername"><i class="fas fa-user-circle"></i> ${post.username}</div>
                    <div class="post-date">Posted on: ${new Date(post.createdAt).toLocaleString()}</div>
                </div>
                <h4 class="mainPostCardTitle">${post.title}</h4>
                <p class="mainPostCardText">${post.content}</p>
                <p class="mainPostCardText" style="font-size: 12px"><b>Category:</b> ${post.category}</span></p>                
                <div class="mainPostCardDivider"></div>
                <div class="comment-section">
                    <button class="comment-btn" onclick="window.location.href='#ViewPost?postId=${post.id}'">
                        View Post
                    </button>
                </div>
            </div>
            `;
            postSection.appendChild(postElement);
        }
    } catch (error) {
        console.error('Error displaying posts:', error);
        postSection.innerHTML = '<div class="no-posts-message"><p>Error loading posts. Please try again later.</p></div>';
    }

    formatPostContent();
}