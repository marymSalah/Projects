export async function fetchNotifications() {
    try {
        const response = await fetch('/api/notifications');
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        const notifications = data.Notification
        console.log('Fetched Notifications:', data);
        const notiDot = document.getElementById('notiBadge');

        // Show red dot only if there are unread notifications
        if (data.UnreadNotifications == 0) {
            notiDot.style.display = 'none';
            console.log('No unread notifications');
        } else {
            notiDot.style.display = 'block';
            console.log('Unread notifications:', data.UnreadNotifications);
        }

        return data;
    } catch (error) {
        console.error('Error fetching posts:', error);
        return []; // Return an empty array in case of error
    }
}

export function displayNotifications(data) {
    const notifications2 = data.Notifications || [];
    const notiDropdown = document.getElementById('notiDropdown');
    const dropdownList = notiDropdown.querySelector('.dropdown-list');

    // Toggle red dot based on unread notifications
    let notifications = notifications2.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));

    // Clear and populate notification items
    dropdownList.innerHTML = '';
    if (notifications.length > 0) {
        notifications.forEach(notification => {
            if (notification.IsRead == true ){
            } else {
            // Create a new list item for each notification
            const li = document.createElement('li');
            
                    // Check if notification is unread and add appropriate class
                    if (!notification.is_read) {
                        li.className = 'notification-item unread';
                    } else {
                        li.className = 'notification-item';
                    }
                    li.textContent = notification.message;
                    dropdownList.appendChild(li);
            }
        });
    } else {
        const li = document.createElement('li');
        li.className = 'notification-item';
        li.textContent = 'No notifications';
        dropdownList.appendChild(li);
    }
}

export async function setNotificationsAsRead() {
    try {
        const response = await fetch('/api/notifications/markAsRead', {
            method: 'POST',
        });
        if (!response.ok) {
            throw new Error(`Error marking notifications as read: ${response.status}`);
        }
        console.log('Notifications marked as read');
    } catch (error) {
        console.error('Failed to mark notifications as read:', error);
    }
}
