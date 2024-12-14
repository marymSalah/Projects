// badrequest.js
import { loadCSS } from '../components/cssLoader.js'; // Updated path

loadCSS('../static/style.css'); // Corrected path for style.css

export function renderBadRequestPage() {
    const app = document.getElementById('app');
    app.innerHTML = `
        <br>
        <button onclick="goBack()"><i class="fas fa-arrow-circle-left"></i> Back</button>
        <img src="static/images/badRequest.png" style="width: 100%; height: 100%; align-items: center;" />
    `;
    
    // Add event listeners for interactive elements
    document.querySelector('button').addEventListener('click', () => {
        window.history.back();
    });
}
