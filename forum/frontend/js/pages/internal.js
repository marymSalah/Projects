import { loadCSS } from '../components/cssLoader.js'; // Updated path

loadCSS('../static/style.css'); // Corrected path for style.css

export function renderInternalErrorPage() {
    const app = document.getElementById('app');
    app.innerHTML = `
        <button id="go-back-button">
            <i class="fas fa-arrow-circle-left"></i> Back
        </button>
        <img src="static/images/internalError.png" style="width: 100%; height: 100%; align-items: center;"/>
    `;

    // Add event listener for the go-back button
    document.getElementById('go-back-button').addEventListener('click', () => {
        window.history.back();
    });
}
