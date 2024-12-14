import { fetchCommentsForPost, submitComment } from '../components/comments/commentHandler.js';
import { loadCSS } from '../components/cssLoader.js';
import { fetchPostById } from '../components/posts/postHandlers.js';
import { getWebSocket, getUserIDFromWS, initializeWebSocket } from '../components/websockets/websocket.js';
import { handleLogout } from '../components/auth/logout.js';
import { displayUsers } from '../components/messages/messageHandler.js';

loadCSS('../static/style.css');
let ws;

export function renderPostCommentsPage(parentElement, postId) {
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
            renderPostCommentsPageWS(parentElement, postId, ws);
        }, 1000);
    } else {
        renderPostCommentsPageWS(parentElement, postId, ws);
    }
}

export async function renderPostCommentsPageWS(parentElement, postId, ws) {
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

    const postCommentsPage = `
        <div class="container">
            <div class="header">
                <button onclick="window.location.href='#mainPost'">Back to Main Page</button>
                <div class="header-placeholder"></div>
                <div class="welcome-section">
                    <h1 class="welcome-heading">
                        <span class="icon-container">
                            <i class="fas fa-lightbulb"></i>
                        </span>Welcome to <span class="forum-text">fikra</span>
                    </h1>
                </div>
                <div class="links-section">
                <button id="profileBtn"><i class="fas fa-user"></i></button>
                <button id="privMsgBtn"><i class="fas fa-comments"></i></button>
                <button onclick="window.location.href='#mainPost'">Back to Main Page</button>
                <button id="createPostBtn">Create a Post</button>
                <button id="logoutBtn">Logout</button>
                </div>
            </div>
            <div class="main-content">
            <div class="leftContainerMain">
                <div class="users-container">
                    <div class="users-header">
                        <h2>Users</h2>
                    </div>
                    <div class="users-list" id="users-list">
                        <!-- Users will be dynamically inserted here -->
                    </div>
                </div>
            </div>
            <div class="rightContainerMain">
                <div class="post-comments-container">
                    <div id="postSection"></div>
                    <div id="commentsSection"></div>
                    <div class="comment-form">
                        <textarea id="commentInput" placeholder="Write a comment..."></textarea>
                        <span id="comment-error" class="error-message hidden"></span>
                        <button id="submitCommentBtn">Submit</button>
                    </div>
                </div>
                </div>
            </div>
        </div>
    `;

    parentElement.innerHTML = postCommentsPage;
    displayUsers(loggedInUser);
    await renderSinglePost(postId);
    await displayComments(postId);
    setupEventListeners();
    setupCommentEventListeners(postId);
}

async function renderSinglePost(postId) {
    const postSection = document.getElementById('postSection');
    postSection.innerHTML = '';

    try {
        const post = await fetchPostById(postId);

        if (!post) {
            postSection.innerHTML = '<div class="no-posts-message"><p>Error: Post not found.</p></div>';
            return;
        }

        const postElement = document.createElement('div');
        postElement.className = 'mainPostCard';

        postElement.innerHTML = `
        <div class="mainPostCardContent">
            <div class="mainPostCardMeta">
                <div class="mainPostCardUsername"><i class="fas fa-user-circle"></i> ${post.Username}</div>
                <div class="post-date">Posted on: ${new Date(post.created_at).toLocaleString()}</div>
            </div>
            <h4 class="mainPostCardTitle">${post.title}</h4>
            <p class="mainPostCardText">${post.content}</p>
            <div class="mainPostCardDivider"></div>
        </div>
        `;
        postSection.appendChild(postElement);
    } catch (error) {
        console.error('Error rendering the post:', error);
        postSection.innerHTML = '<div class="no-posts-message"><p>Error loading the post. Please try again later.</p></div>';
    }
}

async function displayComments(postId) {
    const commentsSection = document.getElementById('commentsSection');
    commentsSection.replaceChildren();

    try {
        const comments = await fetchCommentsForPost(postId);

        if (!Array.isArray(comments)) {
            commentsSection.innerHTML = '<p>Error: Invalid comments data.</p>';
            return;
        }

        if (comments.length === 0) {
            commentsSection.innerHTML = '<p>No comments yet. Be the first to comment!</p>';
            return;
        }

        comments.forEach(comment => {
            const commentElement = document.createElement('div');
            commentElement.className = 'commentCard';
            commentElement.innerHTML = `
                <p><strong>${comment.username}</strong> on ${new Date(comment.created_at).toLocaleString()}</p>
                <p>${comment.content}</p>
            `;
            commentsSection.appendChild(commentElement);
        });
    } catch (error) {
        console.error('Error fetching comments:', error);
        commentsSection.innerHTML = '<p>Error loading comments. Please try again later.</p>';
    }
}

function setupCommentEventListeners(postId) {
    const submitCommentBtn = document.getElementById('submitCommentBtn');
    const commentInput = document.getElementById('commentInput');
    submitCommentBtn.addEventListener('click', async () => {
        const commentValue = commentInput.value.trim();

        if (commentValue === '') return;

        try {
            await submitComment(postId, commentValue);
            await displayComments(postId);
            commentInput.value = '';
            commentInput.focus();
        } catch (error) {
            console.error('Error submitting comment:', error);
        }
    });

    commentInput.addEventListener('keypress', (event) => {
        if (event.key === 'Enter') {
            submitCommentBtn.click();
            event.preventDefault();
        }
    });
}

function setupEventListeners() {
    document.getElementById('profileBtn').addEventListener('click', () => {
        window.location.href = '#profile';
    });

    document.getElementById('privMsgBtn').addEventListener('click', () => {
        window.location.href = '#privateMessage';
    });

    document.getElementById('createPostBtn').addEventListener('click', () => {
        window.location.href = '#createPost';
    });

    document.getElementById('logoutBtn').addEventListener('click', () => {
        handleLogout(ws);
    });
}