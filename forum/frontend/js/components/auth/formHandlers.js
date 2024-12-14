// formHandlers.js
import { initializeWebSocket, getWebSocket } from "../websockets/websocket.js";

export async function handleSignIn() {
    // Collect form values
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    const serverError = document.getElementById('server-error');

    // Reset error display
    serverError.classList.add('hidden');
    serverError.textContent = '';

    // Perform sign-in request
    try {
        const response = await fetch('/api/login', { 
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                username: username,
                password: password,
            }),
        });

        if (response.ok) {
            const data = await response.json();
            const loggedInUser = data.user_id;
            console.log("Response data:", data);
            
            // Store user ID in localStorage
            localStorage.setItem('userID', loggedInUser);
            
            // Initialize WebSocket and wait for connection
            initializeWebSocket(loggedInUser);
            
            // Wait for WebSocket to connect before redirecting
            await new Promise((resolve) => {
                const checkWebSocket = () => {
                    const ws = getWebSocket();
                    if (ws && ws.readyState === WebSocket.OPEN) {
                        resolve();
                    } else if (ws && ws.readyState === WebSocket.CONNECTING) {
                        setTimeout(checkWebSocket, 100);
                    } else {
                        resolve(); // Resolve anyway after a few attempts
                    }
                };
                setTimeout(checkWebSocket, 100);
            });

            // Redirect on success
            window.location.href = '#mainPost';
        } else {
            const errorData = await response.json();
            serverError.textContent = errorData.error || 'An unexpected error occurred';
            serverError.classList.remove('hidden');
        }
    } catch (error) {
        console.error('Error during sign-in:', error);
        serverError.textContent = 'Network error. Please check your connection.';
        serverError.classList.remove('hidden');
    }
}
