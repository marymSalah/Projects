// Import necessary functions or modules
import { initRegisterPage } from './pages/register.js';
import { initLogin } from './pages/signin.js';
import { initProfilePage } from './pages/profile.js';
import { renderBadRequestPage } from './pages/badrequest.js';
import { renderMainPost } from './pages/mainPost.js';
import { renderCreatePostPage } from './pages/createPostPage.js';
import { renderPrivateMessagePage } from './pages/privateMessage.js';
import { renderPostCommentsPage } from './pages/ViewPost.js';
import { renderNotFoundPage } from './pages/notfound.js';
import { handleLogout } from './components/auth/logout.js';
import { fetchUser } from './components/profile/profileHandler.js';

// Initialize the application
document.addEventListener('DOMContentLoaded', () => {
    const app = document.getElementById('app');
    let ws;

    // Redirect to the last saved location or default to '#signin'
    const savedLocation = localStorage.getItem('location');
    if (savedLocation) {
        window.location.hash = savedLocation;
    } else {
        window.location.hash = '#signin';
    }

    // Function to load the page based on the hash in the URL
    async function loadPage() {
        const hash = window.location.hash.substring(1);
        const [route, queryString] = hash.split('?');
        const urlParams = new URLSearchParams(queryString);

        // Store current route in localStorage
        localStorage.setItem('location', `#${route}`);

        switch (route) {
            case 'signin':
                initLogin(app);
                break;
            case 'register':
                initRegisterPage(app);
                break;
            case 'badrequest':
                renderBadRequestPage();
                break;
            case 'createPost':
                renderCreatePostPage();
                break;
            case 'mainPost':
                renderMainPost();
                break;
            case 'profile': {
                const userData = await fetchUser();
                if (userData) {
                    initProfilePage(app, userData);
                } else {
                    window.location.hash = '#signin'; // Redirect to login if not authenticated
                }
                break;
            }
            case 'privateMessage':
                renderPrivateMessagePage();
                break;
            case 'ViewPost': {
                const postId = urlParams.get('postId');
                if (postId) {
                    localStorage.setItem('location', `#ViewPost?postId=${postId}`);
                    renderPostCommentsPage(app, postId);
                } else {
                    console.error('Post ID is missing in the URL parameters');
                }
                break;

            }
            case 'logout':
                handleLogout();
                break;
            default:
                renderNotFoundPage();
                break;
        }
    }

    // Function to update the content based on the current hash
    function updateContent() {
        loadPage();
    }

    // Initial content load
    loadPage();

    // Listen for hash changes
    window.addEventListener('hashchange', updateContent);
    window.addEventListener('load', loadPage);
});
