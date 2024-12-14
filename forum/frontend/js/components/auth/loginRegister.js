export async function handleRegister(event) {
    event.preventDefault();

    // Call the validation function
    if (validateRegistrationForm()) {

    // Collect form values
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    const email = document.getElementById('email').value.trim();
    const fname = document.getElementById('fname').value.trim();
    const lname = document.getElementById('lname').value.trim();
    const dob = document.getElementById('dob').value.trim();
    const gender = document.getElementById('gender').value;

    // Send registration request
    try {
        const response = await fetch('/api/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                username: username,
                password: password,
                email: email,
                fname: fname,
                lname: lname,
                dob: dob,
                gender: gender
            })
        });

        if (response.ok) {
            // Redirect on success
            window.location.href = '#signin';
        } else {
            // Handle errors
            const result = await response.text();
            showError(result || 'Registration failed.');
        }
        
    } catch (error) {
        console.error('Error during registration:', error);
        showError('An unexpected error occurred.');
    }
}
}

function showError(id, message) {
    const errorContainer = document.getElementById('register-error');
    if (errorContainer) {
        errorContainer.textContent = message;
        errorContainer.classList.remove('hidden');
    }
}

export function validateRegistrationForm() {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    const email = document.getElementById('email').value.trim();
    const fname = document.getElementById('fname').value.trim();
    const lname = document.getElementById('lname').value.trim();
    const dob = document.getElementById('dob').value.trim();
    const gender = document.getElementById('gender').value;
  
    const usernameError = document.getElementById('username-error');
    const passwordError = document.getElementById('password-error');
    const emailError = document.getElementById('email-error');
    const fnameError = document.getElementById('fname-error');
    const lnameError = document.getElementById('lname-error');
    const dobError = document.getElementById('dob-error');
    const genderError = document.getElementById('gender-error');
    const topLevelError = document.getElementById('top-level-error');
  
    let isValid = true;
  
    // Validate username
    if (!username) {
      usernameError.textContent = 'Username is required.';
      usernameError.classList.remove('hidden');
      isValid = false;
    } else {
      usernameError.classList.add('hidden');
    }
  
    // Validate password
    if (!password) {
      passwordError.textContent = 'Password is required.';
      passwordError.classList.remove('hidden');
      isValid = false;
    } else if (password.length < 8) {
      passwordError.textContent = 'Password must be at least 8 characters long.';
      passwordError.classList.remove('hidden');
      isValid = false;
    } else if (password.includes(' ')) {
      passwordError.textContent = 'Password cannot contain spaces.';
      passwordError.classList.remove('hidden');
      isValid = false;
    } else if (!(/[A-Z]/.test(password) && /[a-z]/.test(password) && /[0-9]/.test(password))) {
      passwordError.textContent = 'Password must contain at least one uppercase letter, one lowercase letter, and one number.';
      passwordError.classList.remove('hidden');
      isValid = false;
    } else {
      passwordError.classList.add('hidden');
    }
  
    // Validate email
    if (!email) {
      emailError.textContent = 'Email is required.';
      emailError.classList.remove('hidden');
      isValid = false;
    } else if (!isValidEmail(email)) {
      emailError.textContent = 'Please enter a valid email address.';
      emailError.classList.remove('hidden');
      isValid = false;
    } else {
      emailError.classList.add('hidden');
    }
  
    // Validate first name
    if (!fname) {
      fnameError.textContent = 'First name is required.';
      fnameError.classList.remove('hidden');
      isValid = false;
    } else {
      fnameError.classList.add('hidden');
    }
  
    // Validate last name
    if (!lname) {
      lnameError.textContent = 'Last name is required.';
      lnameError.classList.remove('hidden');
      isValid = false;
    } else {
      lnameError.classList.add('hidden');
    }
  
    // Validate date of birth
    if (!dob) {
      dobError.textContent = 'Date of birth is required.';
      dobError.classList.remove('hidden');
      isValid = false;
    } else {
      dobError.classList.add('hidden');
    }
  
    // Validate gender
    if (!gender) {
      genderError.textContent = 'Please select a gender.';
      genderError.classList.remove('hidden');
      isValid = false;
    } else {
      genderError.classList.add('hidden');
    }
  
    // Clear top-level error
    topLevelError.classList.add('hidden');
  
    return isValid;
  }
  
  function isValidEmail(email) {
    // Add a basic email validation regex
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }