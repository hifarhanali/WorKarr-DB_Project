let eye_ele = document.querySelector('.fa-eye');
let password = document.querySelector('#textbox_passwordID');

eye_ele.addEventListener('click', function(event) {
    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
    password.setAttribute('type', type);

    // toggle the eye slash icon
    eye_ele.classList.toggle('fa-eye');
    eye_ele.classList.toggle('fa-eye-slash');
}, false);