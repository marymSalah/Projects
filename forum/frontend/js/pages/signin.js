// login.js

import { handleSignIn } from '../components/auth/formHandlers.js';
import { validateForm } from '../components/validation/signinvalidate.js';
import { loadCSS } from '../components/cssLoader.js';

loadCSS('../static/style.css');

export function initLogin(parentElement) {
    const loginHTML = `
        <div class="header">
            <div class="welcome-section">
                <h1 class="welcome-heading"> 
                    <span class="icon-container">
                        <i class="fas fa-lightbulb"></i>
                    </span>
                    Welcome to <span class="forum-text">fikra</span>
                </h1>
            </div>
        </div>
        <div class="container">
            <div class="left-side">
                <div class="card-container">
                    <div class="signin">
                        <h2>Sign In</h2>
                        <p id="server-error" class="error-message hidden"></p>
                        <form id="signinForm" method="POST">
                            <label for="username">Username/Email:</label>
                            <input type="text" id="username" name="username" required><br>
                            <span id="username-error" class="error-message hidden"></span><br>
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" required><br>
                            <span id="password-error" class="error-message hidden"></span><br>
                            <button type="submit">Sign In</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="right-side">
                <h2>New here?</h2>
                <p>Sign up and discover a new network</p>
                <button id="register-btn">Register</button>
            </div>
        </div>
    `;
    parentElement.innerHTML = loginHTML;

    const form = document.getElementById('signinForm');
    const usernameInput = document.getElementById('username');
    const passwordInput = document.getElementById('password');
    const serverError = document.getElementById('server-error');

    usernameInput.addEventListener('input', () => validateForm('username'));
    passwordInput.addEventListener('input', () => validateForm('password'));

    form.addEventListener('submit', async (event) => {
        event.preventDefault();
        serverError.classList.add('hidden');

        if (validateForm()) { // Full form validation on submit
            await handleSignIn();
        }
    });

    document.getElementById('register-btn').addEventListener('click', () => {
        window.location.href = '#register';
    });
}
