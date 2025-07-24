document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('loginForm');
    const registerForm = document.getElementById('registerForm');

    // Login Form Submission
    if (loginForm) {
        loginForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;

            // Add your login API call or validation here
            console.log('Login:', { email, password });
            alert('Login Successful! (Simulated)');
        });
    }

    // Register Form Submission
    if (registerForm) {
        registerForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const phone = document.getElementById('phone').value;

            // Add your register API call or validation here
            console.log('Register:', { name, email, password, phone });
            alert('Registration Successful! (Simulated)');
        });
    }
});
