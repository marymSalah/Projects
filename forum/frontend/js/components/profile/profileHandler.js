export async function fetchUser() {
    try {
        const response = await fetch('/api/profile');
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error fetching users:', error);
        return null; // Return null instead of an empty array to indicate failure
    }
}