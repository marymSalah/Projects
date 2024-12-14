// signinvalidate.js

export function validateForm(field) {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    const usernameError = document.getElementById('username-error');
    const passwordError = document.getElementById('password-error');
    const serverError = document.getElementById('server-error');
    let valid = true;

    if (!field || field === 'username') {
        if (!username) {
            usernameError.textContent = 'Username or email is required.';
            usernameError.classList.remove('hidden');
            valid = false;
        } else {
            usernameError.classList.add('hidden');
        }
    }

    if (!field || field === 'password') {
        if (!password) {
            passwordError.textContent = 'Password is required.';
            passwordError.classList.remove('hidden');
            valid = false;
        } else {
            passwordError.classList.add('hidden');
        }
    }

    if (serverError) {
        serverError.classList.add('hidden');
    }

    return valid;
}

