export async function fetchProfile(postId) {
    console.log(`Fetching comments for postId: ${postId}`); // Verify postId

    try {
        const response = await fetch(`/api/user?userId=${userId}`);

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