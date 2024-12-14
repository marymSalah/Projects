// components/posts/postHandlers.js
console.log('postHandlers.js loaded'); 
export function formatPostContent() {
    document.addEventListener('DOMContentLoaded', () => {
        const postElements = document.querySelectorAll('.mainPostCardText');
        postElements.forEach(element => {
            element.innerHTML = element.innerText.replace("&lt;br&gt;", "\n").replace('&lt;2br&gt;', "&lt;br&gt;");
        });
    });
}

export async function fetchPosts() {
    try {
        const response = await fetch('/api/posts');
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        console.log('Fetched posts:', data);
        return data;
    } catch (error) {
        console.error('Error fetching posts:', error);
        return []; // Return an empty array in case of error
    }
}


export async function fetchPostById(postId) {
    try {
        const response = await fetch(`/api/comments?postId=${postId}`);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        // Log the raw response body as text to check for issues
        const rawData = await response.text();

        // Try parsing the raw text to JSON
        try {
            const data = JSON.parse(rawData);
            console.log('Post Data:', data); // Verify parsed data

            // Access only the comments array
            const post = data.post || []; 
            console.log('Fetched Post:', post); // Log the comments for verification
            return post; // Return only the comments array
        } catch (jsonError) {
            console.error('JSON Parsing Error:', jsonError);
            return []; // Return empty array on parsing failure
        }
    } catch (error) {
        console.error('Error fetching post:', error);
        return null; // Return null if an error occurs
    }
}