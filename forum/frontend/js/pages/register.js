import { loadCSS } from '../components/cssLoader.js'; // Updated path
import { handleRegister } from '../components/auth/loginRegister.js';

loadCSS('../static/style.css'); // Corrected path for style.css
 

export function initRegisterPage(parentElement) {
    const registerFormHTML = `
        <div class="header">
            <div class="welcome-section">
                <h1 class="welcome-heading">
                    <span class="icon-container">
                        <i class="fas fa-lightbulb"></i>
                    </span>
                    Welcome to <span class="forum-text">fikra</span>
                </h1>
            </div>
            <div class="links-section">
                <button id="back-to-login">
                    <i class="fas fa-arrow-circle-left"></i> Back To Login
                </button>
            </div>
        </div>
        <div class="registration-card">
            <h2>Register</h2>
            <form id="registerForm" class="register-form" method="POST">
            <span id="top-level-error" class="error-message hidden"></span>
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
                <span id="username-error" class="error-message hidden"></span><br>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <span id="password-error" class="error-message hidden"></span><br>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <span id="email-error" class="error-message hidden"></span><br>
                <label for="fname">First Name:</label>
                <input type="text" id="fname" name="fname" required>
                <span id="fname-error" class="error-message hidden"></span><br>
                <label for="lname">Last Name:</label>
                <input type="text" id="lname" name="lname" required>
                <span id="lname-error" class="error-message hidden"></span><br>
                <label for="dob">Date Of Birth:</label>
                <input type="date" id="dob" name="dob" required>
                <span id="dob-error" class="error-message hidden"></span><br>
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="" disabled selected>Choose a Gender</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                </select>
                <span id="gender-error" class="error-message hidden"></span><br>
                <button type="submit">Register</button>
            </form>
        </div>
    `;

    parentElement.innerHTML = registerFormHTML;

    // Attach event listeners
    document.getElementById('registerForm').addEventListener('submit', handleRegister);

    document.getElementById('back-to-login').addEventListener('click', () => {
        window.location.href = '#signin';
    });
}
