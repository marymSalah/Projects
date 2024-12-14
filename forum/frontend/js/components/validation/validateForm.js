// createPostFunctions.js
export function validateForm() {
    const title = document.getElementById('title').value.trim();
    const content = document.getElementById('content').value.trim();
    const category = document.getElementById('category').value;
    const titleError = document.getElementById('title-error');
    const contentError = document.getElementById('content-error');  
    const categoryError = document.getElementById('category-error');

    let valid = true;

    if (!title) {
        titleError.textContent = 'Title is required.';
        titleError.style.display = 'block';
        valid = false;
    } else if (title.includes(">") || title.includes("<")) {
        titleError.textContent = 'Title cannot contain < or > tags';
        titleError.style.display = 'block';
        valid = false;
    } else {
        titleError.style.display = 'none';
    }

    if (!content) {
        contentError.textContent = 'Content is required.';
        contentError.style.display = 'block';
        valid = false;
    } else if (content.includes('<br>')) {
        contentError.textContent = 'Content cannot contain <br> tag.';
        contentError.style.display = 'block';
        valid = false;
    } else if (content.length < 3) {
        contentError.textContent = 'Content must be at least 3 characters.';
        contentError.style.display = 'block';
        valid = false;          
    } else if (content.includes(">") || content.includes("<")) {
        contentError.textContent = 'Content cannot contain < or > tags';
        contentError.style.display = 'block';
        valid = false;
    } else {
        contentError.style.display = 'none';
    } 

    if (!category) {
        categoryError.textContent = 'Category is required.';
        categoryError.style.display = 'block';
        valid = false;
    } else {
        categoryError.style.display = 'none';
    }

    return valid;
}
export function validateCommentForm() {
    const commentInput = document.getElementById('commentInput').value.trim();
    const commentError = document.getElementById('comment-error'); // Add an error span in HTML if you want visual feedback

    let isValid = true;

    if (!commentInput) {
        if (commentError) commentError.textContent = 'Comment cannot be empty.';
        isValid = false;
    } else if (commentInput.includes('<') || commentInput.includes('>')) {
        if (commentError) commentError.textContent = 'Comment cannot contain < or > tags.';
        isValid = false;
    } else {
        if (commentError) commentError.textContent = '';
    }

    return isValid;
}
