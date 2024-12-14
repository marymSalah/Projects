import { getWebSocket } from "../websockets/websocket.js";

let currentMessages = [];
let currentSlice = 0;
const MESSAGES_PER_SLICE = 10;
let currentOffset = 0;
let firstTime = true;
export async function fetchUsers() {
    try {
        const response = await fetch('/api/users');
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        console.log('Fetched users:', data);
        return data;
    } catch (error) {
        console.error('Error fetching users:', error);
        return [];
    }
}

export async function displayUsers(loggedInUser) {
    const userSection = document.getElementById('users-list');
    if (!userSection) {
        console.error('Element with ID "users-list" not found');
        return;
    }
    userSection.innerHTML = ''; // Clear existing content

    try {
        const data = await fetchUsers();

        if (!data || !Array.isArray(data.users)) {
            console.error('Fetched data is not valid:', data);
            userSection.innerHTML = '<div class="no-posts-message"><p>Error: Users data is not valid.</p></div>';
            return;
        }

        if (data.users.length === 0) {
            userSection.innerHTML = '<div class="no-posts-message"><p>No users available.</p></div>';
            return;
        }

        // Sort and group users
        const { usersWithChat, usersWithoutChat } = await sortAndGroupUsers(data.users, loggedInUser);

        // Create section for users with chat history
        if (usersWithChat.length > 0) {
            const chatHistorySection = document.createElement('div');
            chatHistorySection.className = 'users-section';
            chatHistorySection.innerHTML = '<h3 class="section-title">Recent Chats</h3>';
            userSection.appendChild(chatHistorySection);

            usersWithChat.forEach(user => {
                if (user.id != loggedInUser) {
                    const userElement = createUserElement(user);
                    chatHistorySection.appendChild(userElement);
                }
            });
        }

        // Create section for users without chat history
        if (usersWithoutChat.length > 0) {
            const noChatSection = document.createElement('div');
            noChatSection.className = 'users-section';
            noChatSection.innerHTML = '<h3 class="section-title">Other Users</h3>';
            userSection.appendChild(noChatSection);

            usersWithoutChat.forEach(user => {
                if (user.id != loggedInUser) {
                    const userElement = createUserElement(user);
                    noChatSection.appendChild(userElement);
                }
            });
        }

    } catch (error) {
        console.error('Error displaying users:', error);
        userSection.innerHTML = '<div class="no-posts-message"><p>Error loading users. Please try again later.</p></div>';
    }
}

export function appendMessageToChat(message, loggedInUser) {
    console.log('Appending message:', message);
    console.log('Logged in user ID:', loggedInUser);
    const chatMessages = document.getElementById('chat-messages');
    if (!chatMessages) {
        console.error('Chat messages container not found');
        console.log('recip', message.recipient_id);
        console.log("logged in user", loggedInUser);
        if (message.recipient_id === loggedInUser) {
        alert('you got a new message');
        }
        return;
    }

    const messageElement = document.createElement('div');
    messageElement.classList.add('message');

    const chatid = document.getElementById('receiverID').value;
    console.log("chatID" , chatid);
    console.log("message r", message.recipient_id);
    if (chatid == message.sender_id) {
        console.log("hello");
        if (message.sender_id === loggedInUser) {
            messageElement.classList.add('sent');
        } else if (message.recipient_id === loggedInUser) {
            messageElement.classList.add('received');
        } else {
            return;
        }
    } else if (chatid == message.recipient_id) {
            if (message.sender_id === loggedInUser) {
                messageElement.classList.add('sent');
            } else if (message.recipient_id === loggedInUser) {
                messageElement.classList.add('received');
            } else {
                return;
            }
    } else {
        return;
    }


    messageElement.textContent = message.message_content;
    chatMessages.appendChild(messageElement);
    chatMessages.scrollTop = chatMessages.scrollHeight;

    const date = new Date();
    const options = { year: 'numeric', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric', hour12: true };
    const formattedDate = date.toLocaleDateString('en-US', options);

    const timeElement = document.createElement('div');
    timeElement.classList.add('message-time');
    timeElement.textContent = formattedDate;

    timeElement.style.fontSize = '8px';
    timeElement.style.color = '#888';
    timeElement.style.marginLeft = '10px';
    timeElement.style.marginTop = '5px';
    timeElement.style.marginBottom = '5px';
    timeElement.style.marginRight = '10px';
    timeElement.style.textAlign = 'right';
    timeElement.style.fontFamily = 'Arial, sans-serif';
    timeElement.style.fontWeight = 'bold';
    timeElement.style.textTransform = 'uppercase';
    timeElement.style.letterSpacing = '1px';

    messageElement.appendChild(timeElement);
    chatMessages.insertAfter(messageElement, chatMessages.firstChild);
{
    
}
}

export function loadChat(messages) {
    if (!messages || !messages.length) return;
    
    currentMessages = messages;
    currentSlice = 0;
    
    const chatMessages = document.getElementById('chat-messages');
    chatMessages.innerHTML = '';
    
    // Load initial set of messages (most recent)
    loadMoreMessages();

  
}

export function loadMoreMessages() {
    const startIndex = Math.max(0, currentMessages.length - (currentSlice + 1) * MESSAGES_PER_SLICE);

    
    const endIndex = currentMessages.length - currentSlice * MESSAGES_PER_SLICE;

    if(firstTime){
        currentOffset = Math.max(0, currentMessages.length - 9);
        firstTime = false;
    }else{
        const chat = document.getElementById('chat-messages');
        const oldScrollHeight = chat.scrollHeight; // Store the old scroll height to calculate the adjustment later
        // Load previous messages
        const nextOffset = Math.max(0, currentOffset - 9);
        //const additionalMessages = messageHistory.slice(nextOffset, currentOffset);
        currentOffset = nextOffset; // Update currentOffset
    }
    
    if (startIndex < endIndex) {
        const messagesToLoad = currentMessages.slice(startIndex, endIndex);
        const chatMessages = document.getElementById('chat-messages');
        
        // Store scroll position
        const scrollBottom = chatMessages.scrollHeight - chatMessages.scrollTop;
        
        // Prepend messages in correct order
        messagesToLoad.reverse().forEach(message => {
            const messageElement = document.createElement('div');
            messageElement.classList.add('message');
            
            if (message.sender_id === currentMessages.loggedInUser) {
                messageElement.classList.add('sent');
            } else {
                messageElement.classList.add('received');
            }
            // format data to date and time in the format of "Month Day, Year at Hour:Minute AM/PM"
            const date = new Date(message.created_at);
            const options = { year: 'numeric', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric', hour12: true };
            const formattedDate = date.toLocaleDateString('en-US', options);

            messageElement.textContent = message.message_content;
            // insert time below the text of the message
            const timeElement = document.createElement('div');
            timeElement.classList.add('message-time');
            timeElement.textContent = formattedDate;


            // write css of the message-time only 
            timeElement.style.fontSize = '8px';
            timeElement.style.color = '#888';
            timeElement.style.marginLeft = '10px';
            timeElement.style.marginTop = '5px';
            timeElement.style.marginBottom = '5px';
            timeElement.style.marginRight = '10px';
            timeElement.style.textAlign = 'right';
            timeElement.style.fontFamily = 'Arial, sans-serif';
            timeElement.style.fontWeight = 'bold';
            timeElement.style.textTransform = 'uppercase';
            timeElement.style.letterSpacing = '1px';

            messageElement.appendChild(timeElement);
            chatMessages.insertBefore(messageElement, chatMessages.firstChild);
        });
        
        currentSlice++;
        
        // Hide load more button if no more messages
        const loadMoreBtn = document.getElementById('load-more-btn');
        if (loadMoreBtn && startIndex === 0) {
            loadMoreBtn.style.display = 'none';
        }
        
        return true;
    }
    return false;
}

export function handleSendMessage(loggedInUser) {
    const ws = getWebSocket();
    console.log('WebSocket state:', ws?.readyState);
    console.log('Logged in user:', loggedInUser);
    
    const messageInput = document.getElementById('messageInput');
    const messageText = messageInput.value.trim();
    const recipientID = parseInt(document.getElementById('rID').innerHTML);
    console.log('Recipient ID:', recipientID);

    const senderID = parseInt(loggedInUser);
    console.log('Sender ID (parsed):', senderID);

    if (!ws || ws.readyState !== WebSocket.OPEN) {
        console.error('WebSocket connection is not open. Current state:', ws ? ws.readyState : 'No WebSocket');
        return;
    }

    if (messageText) {
        const message = {
            sender_id: senderID,
            recipient_id: recipientID,
            message_content: messageText
        };

        console.log('Sending message via WebSocket:', message);
        ws.send(JSON.stringify(message));
        messageInput.value = '';
    }
    displayUsers(loggedInUser);
}

export function handleTyping(loggedInUser) {
    const ws = getWebSocket();
    console.log('WebSocket state:', ws?.readyState);
    console.log('Logged in user:', loggedInUser);
    
    const messageInput = document.getElementById('messageInput');
    const messageText = messageInput.value.trim();
    const recipientID = parseInt(document.getElementById('rID').innerHTML);
    console.log('Recipient ID:', recipientID);

    const senderID = parseInt(loggedInUser);
    console.log('Sender ID (parsed):', senderID);

    if (!ws || ws.readyState !== WebSocket.OPEN) {
        console.error('WebSocket connection is not open. Current state:', ws ? ws.readyState : 'No WebSocket');
        return;
    }

    if (messageText) {
        const message = {
            sender_id: senderID,
            recipient_id: recipientID,
            message_content: "toottoot"
        };

        console.log('Sending message via WebSocket:', message);
        ws.send(JSON.stringify(message));      
    }
}

export function updateChatHeader(username, userId, userStatus) {
    if (window.location.hash === "#privateMessage") {
        setTimeout(() => {
            firstTime = true;
            console.log('Updating chat header:', { username, userId });
            document.getElementById('chat-header-username').innerText = username;
            document.getElementById('receiverID').value = userId;
            document.getElementById('rID').innerText = userId;
            document.getElementById('typing').innerText = userStatus;
            document.getElementById('st').innerHTML = userStatus;
        
            const form = document.getElementById('message-form');
            form.hidden = false;
        
            const chatMessage = document.getElementById('chat-messages');
            chatMessage.innerHTML = '';
        
            
            fetchMessages().then(messages => {
                loadChat(messages);
            });
        
            //add event listener for scroll in chat-messages
            const chatMessages = document.getElementById('chat-messages');
            chatMessages.scrollBottom = chatMessages.scrollHeight; 
            chatMessages.addEventListener('scroll', handleScroll);
        }, 100);
    } else {
        console.error('Error updating chat header:');

        // Redirect to privateMessage page
        window.location.href = '#privateMessage';

        // Retry updating the chat header after the page loads
        const retryUpdateChatHeader = () => {
            if (document.readyState === 'complete' && document.getElementById('chat-header-username')) {
                const chatMessages = document.getElementById('chat-messages');
                chatMessages.scrollTo(0, chatMessages.scrollHeight);

                // Call updateChatHeader again after checking the hash
                if (window.location.hash === '#privateMessage') {
                    updateChatHeader(username, userId, userStatus);
                }
            } else {
                // If the document is still loading, wait and try again
                setTimeout(retryUpdateChatHeader, 150);
            }
        };

        // Start the retry logic
        setTimeout(retryUpdateChatHeader, 150);
    }
}
let handleScroll = throttle(() => {
    
    // Get the current scroll position
    const chat = document.getElementById('chat-messages');
    let scrollPosition = chat.clientHeight;
    const maxScrollTop = chat.scrollHeight - chat.clientHeight;

    console.log(chat.scrollTop, maxScrollTop)
    // Assuming that being "near the top" might correspond to a small negative number close to zero
      // Check if the user is near the top of the chat (considering column-reverse layout)
      console.log(chat.scrollTop <= -maxScrollTop + 45)
      console.log("maxscroll",-maxScrollTop + 45)
      console.log(chat.scrollTop )
      console.log("current offset",currentOffset)
if (chat.scrollTop <= 0 && currentOffset > 0) {
    console.log('fetching more messages')
    loadMoreMessages();
    chat.scrollTop = scrollPosition;
}
}, 200);


function throttle(func, limit) {
    let lastFunc;
    let lastRan;
    return function() {
        const context = this;
        const args = arguments;
        if (!lastRan) {
            func.apply(context, args);
            lastRan = Date.now();
        } else {
            clearTimeout(lastFunc);
            lastFunc = setTimeout(function() {
                if ((Date.now() - lastRan) >= limit) {
                    func.apply(context, args);
                    lastRan = Date.now();
                }
            }, limit - (Date.now() - lastRan));
        }
    }
}
export async function fetchMessages() {
    try {
        const response = await fetch('/api/messages');
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        const loggedInUser = data.loggedInUser;
        const recipient_id = parseInt(document.getElementById('receiverID').value);

        // Check if it is there 
        const recievedMessages = Array.isArray(data.recievedMessages) ? data.recievedMessages : [];
        const sentMessages = Array.isArray(data.sentMessages) ? data.sentMessages : [];

        // Combine sent and received messages, then sort them by created_at
        const allMessages = [...sentMessages, ...recievedMessages]
            .sort((a, b) => new Date(a.created_at) - new Date(b.created_at))
            .filter(message =>
                (message.sender_id === loggedInUser && message.recipient_id === recipient_id) ||
                (message.sender_id === recipient_id && message.recipient_id === loggedInUser)
            );

        // Add loggedInUser to the messages array for reference
        allMessages.loggedInUser = loggedInUser;
        return allMessages;
    } catch (error) {
        console.error('Error fetching messages:', error);
        return [];
    }
}

async function sortAndGroupUsers(users, loggedInUser) {
    try {
        console.log('Sorting and grouping users...');
        // Fetch all messages
        const response = await fetch('/api/messages');
        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
        const messageData = await response.json();

        const recievedMessages = Array.isArray(messageData.recievedMessages) ? messageData.recievedMessages : [];
        const sentMessages = Array.isArray(messageData.sentMessages) ? messageData.sentMessages : [];
        // Combine sent and received messages
        const allMessages = [...sentMessages, ...recievedMessages];

        // Create a map to store the latest message timestamp for each user
        const lastMessageMap = new Map();

        // Process all messages to find the latest message for each user
        allMessages.forEach(message => {
            const otherUserId = message.sender_id === loggedInUser ? 
                message.recipient_id : message.sender_id;
            
            const messageTime = new Date(message.created_at).getTime();
            const currentLatest = lastMessageMap.get(otherUserId);
            
            if (!currentLatest || messageTime > currentLatest) {
                lastMessageMap.set(otherUserId, messageTime);
            }
        });

        // Separate users into two groups
        const usersWithChat = [];
        const usersWithoutChat = [];

        users.forEach(user => {
            if (lastMessageMap.has(parseInt(user.id))) {
                usersWithChat.push({
                    ...user,
                    lastMessageTime: lastMessageMap.get(parseInt(user.id))
                });
            } else {
                usersWithoutChat.push(user);
            }
        });

        // Sort users with chat history by last message time
        usersWithChat.sort((a, b) => b.lastMessageTime - a.lastMessageTime);

        // Sort users without chat history alphabetically
        usersWithoutChat.sort((a, b) => a.username.localeCompare(b.username));

        return {
            usersWithChat,
            usersWithoutChat
        };
    } catch (error) {
        console.error('Error sorting users:', error);
        // If there's an error, return all users in alphabetical order
        return {
            usersWithChat: [],
            usersWithoutChat: users.sort((a, b) => a.username.localeCompare(b.username))
        };
    }
}

function createUserElement(user) {
    const userElement = document.createElement('div');
    userElement.className = 'user-item';
        userElement.onclick = () => {
            try {
                updateChatHeader(user.username, user.id, user.status);
            } catch (error) {
                console.error('Error updating chat header:', error);
            }
        };
    
        userElement.innerHTML = `
            <div class="user-avatar"><i class="fas fa-user"></i></div>
            <div class="user-info">
                <div class="user-name">${user.username}</div>
                <div class="user-id">ID: ${user.id}</div>
                <div class="user-status">Status: ${user.status || 'Unknown'}</div>
            </div>
        `;

    return userElement;
}

export function showTyping(message) {
    // Get the logged in user's ID from localStorage
    const loggedInUserID = localStorage.getItem('userID');
    console.log("message: ", message);

    // Get recipient id and staus from the DOM elements
    const recipientID = document.getElementById('receiverID').value;
    const status = document.getElementById('st').innerText;

    // Check if the current chat is with the user who is typing
    if(recipientID == message.sender_id){
        console.log("userId logged IN: ", loggedInUserID);
        // Verify if the typing notification is meant for the logged-in user
        if(message.recipient_id == loggedInUserID){
            const typingIndicator = document.getElementById('typing');
            
            // Only start animation if it's not already running
            if (!window.typingAnimationInterval) {
                // Display the typing indicator with animation
                typingIndicator.textContent = ` is typing.`;
                typingIndicator.style.display = 'block';

                // Initialize animation variables
                let animationStep = 0;
                // Function to animate the dots (...) in the typing indicator
                const animate = () => {
                    // Cycle through 0, 1, 2 for the number of dots
                    animationStep = (animationStep + 1) % 3;
                    // Update the typing indicator text with appropriate number of dots
                    typingIndicator.textContent = ` is typing${'.'.repeat(animationStep + 1)}`;
                    // Schedule next animation frame
                    window.typingAnimationInterval = setTimeout(animate, 500);
                };

                animate();
            }

            // Clear any existing reset timeout to prevent premature hiding
            if (window.typingResetTimeout) {
                clearTimeout(window.typingResetTimeout);
            }

            // Reset typing indicator after 2 seconds of no new typing events
            // This prevents the typing indicator from showing indefinitely
            window.typingResetTimeout = setTimeout(() => {
                clearTimeout(window.typingAnimationInterval);
                window.typingAnimationInterval = null;
                typingIndicator.textContent = status;
            }, 1000);
        }
    }
}