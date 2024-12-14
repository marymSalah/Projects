import { closeWebSocket } from '../websockets/websocket.js';

export async function handleLogout(ws) {
    try {
        // First close the WebSocket connection
        closeWebSocket(ws);  // This now sets isIntentionalClosure to true

        // Make the logout API call
        const response = await fetch('/api/logout', { 
            method: 'POST',
            credentials: 'include'
        });

        if (response.ok) {
            // Clear all stored data
            localStorage.removeItem('userID');
            sessionStorage.clear();
            
            console.log("Logged out successfully!");
            
            // Add a small delay to ensure WebSocket is properly closed
            await new Promise(resolve => setTimeout(resolve, 100));
            
            // Redirect to signin page
            window.location.href = '#signin';
        } else {
            const errorText = await response.text();
            console.error('Failed to log out:', errorText);
            
            // Clean up client-side anyway
            localStorage.removeItem('userID');
            sessionStorage.clear();
            
            window.location.href = '#signin';
        }
    } catch (error) {
        console.error('Error during logout:', error);
        
        // Clean up client-side
        localStorage.removeItem('userID');
        sessionStorage.clear();
        
        window.location.href = '#signin';
    }
}