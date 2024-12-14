import { appendMessageToChat,showTyping } from "../messages/messageHandler.js";

let ws = null;
let reconnectAttempts = 0;
const MAX_RECONNECT_ATTEMPTS = 5;
const RECONNECT_DELAY = 3000;
let reconnectTimeout = null;
let userID = null;
let isIntentionalClosure = false;  // New flag to track intentional closures

export function initializeWebSocket(logUser) {
    if (!logUser) {
        console.error('No username provided for WebSocket initialization');
        return;
    }

    isIntentionalClosure = false;  // Reset flag when initializing
    userID = parseInt(logUser);
    console.log('Initializing WebSocket with user:', userID);

    if (reconnectTimeout) {
        clearTimeout(reconnectTimeout);
    }

    connectWebSocket();
}

function connectWebSocket() {
    if (isIntentionalClosure) {
        console.log('WebSocket was intentionally closed, not reconnecting');
        return;
    }

    if (ws && ws.readyState === WebSocket.OPEN) {
        console.log('WebSocket is already connected');
        return;
    }

    try {
        ws = new WebSocket(`ws://localhost:8080/ws?username=${userID}`);
        
        ws.onopen = () => {
            console.log('WebSocket connection established with userID:', userID);
            reconnectAttempts = 0;
        };

        ws.onerror = (event) => {
            console.error('WebSocket error details:', event);
        };

        ws.onclose = (event) => {
            console.log('WebSocket connection closed. Code:', event.code, 'Reason:', event.reason, 'Clean:', event.wasClean);
            if (!isIntentionalClosure) {
                handleReconnection();
            }
        };

        ws.onmessage = (event) => {
            try {
                const message = JSON.parse(event.data);
                console.log('Received message:', message);
                
                if (message.message_content === 'toottoot') {
                    showTyping(message);
                    console.log('Received typing event');
                    return;
                }
                appendMessageToChat(message, userID);
            } catch (error) {
                console.error('Error parsing message:', error);
            }
        };

    } catch (error) {
        console.error('Error creating WebSocket:', error);
        if (!isIntentionalClosure) {
            handleReconnection();
        }
    }
}

function handleReconnection() {
    if (isIntentionalClosure) {
        console.log('Not reconnecting due to intentional closure');
        return;
    }

    if (reconnectAttempts >= MAX_RECONNECT_ATTEMPTS) {
        console.error('Maximum reconnection attempts reached');
        return;
    }

    reconnectAttempts++;
    console.log(`Attempting to reconnect (${reconnectAttempts}/${MAX_RECONNECT_ATTEMPTS}) in ${RECONNECT_DELAY}ms...`);

    reconnectTimeout = setTimeout(() => {
        connectWebSocket();
    }, RECONNECT_DELAY);
}

document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'visible' && !isIntentionalClosure) {
        if (!ws || ws.readyState !== WebSocket.OPEN) {
            console.log('Page visible - checking WebSocket connection');
            reconnectAttempts = 0;
            connectWebSocket();
        }
    }
});

export function getWebSocket() {
    if (!ws || ws.readyState !== WebSocket.OPEN) {
        console.error('WebSocket is not initialized or not open');
        return null;
    }
    console.log('WebSocket available');
    return ws;
}

export function closeWebSocket(ws) {
    isIntentionalClosure = true;  // Set flag before closing
    if (reconnectTimeout) {
        clearTimeout(reconnectTimeout);
        reconnectTimeout = null;
    }
    if (ws) {
        ws.close(1000, 'Intentional closure');
        ws = null;
        userID = null;
        reconnectAttempts = 0;
    }
}

export function getUserIDFromWS(ws) {
    if (!ws) {
        console.error('WebSocket is null');
        return null;
    }
    
    try {
        const wsURL = new URL(ws.url);
        const userID = wsURL.searchParams.get('username');
        console.log('Extracted userID from WS:', userID);
        return parseInt(userID);
    } catch (err) {
        console.error('Error getting user ID from WebSocket:', err);
        return null;
    }
}