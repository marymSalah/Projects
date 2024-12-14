// Fetch comments for a specific post
export async function fetchCommentsForPost(postId) {
    console.log(`Fetching comments for postId: ${postId}`); // Verify postId

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
            console.log('Parsed Data:', data); // Verify parsed data

            // Access only the comments array
            const comments = data.comments || []; 
            console.log('Fetched Comments:', comments); // Log the comments for verification
            return comments; // Return only the comments array
        } catch (jsonError) {
            console.error('JSON Parsing Error:', jsonError);
            return []; // Return empty array on parsing failure
        }
    } catch (error) {
        console.error('Error fetching Comments:', error);
        return []; // Return empty array in case of error
    }
}



export async function submitComment(postId, content) {
    console.log(`Submitting comment with postId: ${postId} and content: ${content}`);

    const formData = new URLSearchParams();
    formData.append('post_id', postId);
    formData.append('content', content);

    try {
        const response = await fetch('http://localhost:8080/api/addComment', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData,
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        
    } catch (error) {
        console.error('Error submitting comment:', error);
    }
}
