
var email = document.querySelector('#textbox_emailID');
var pass = document.querySelector('#textbox_passwordID');

// msg container for input fields
var email_container = document.querySelector('.email-container');
var pass_container = document.querySelector('.password-container');


// add event listener to each input field
email.addEventListener('textInput', function () {
	email_verify("Username");
}, false);
pass.addEventListener('textInput', pass_verify);


// verify email is valid or not
function email_verify(msg_type)
{
	let label = document.querySelector('#label_email_errorID');
	if (email.value.length < 9) {
		label.innerHTML = msg_type + " is <strong>too short</strong> to proceed";
		email_container.style.border = "2px solid red";
		document.getElementById('email_error_block').style.display = "block";
		email.classList.remove('valid');
		return false;
	}
	else {
		email_container.style.border = "2px solid #004675";
		document.getElementById('email_error_block').style.display = "none";
		email.classList.add("valid");		// to indicate that email is valid
		return true;

    }
}

// verify password is valid or not
function pass_verify()
{
	let label = document.querySelector('#label_pass_errorID');
	if (pass.value.length >= 8)
	{
		let decimal = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,30}$/;
		if (pass.value.match(decimal))
		{
			pass_container.style.border = "2px solid #004675";
			document.getElementById('pass_error_block').style.display = "none";
			pass.classList.add("valid");		// to indicate that password is valid
			return true;
		}
		label.innerHTML = "Password should contain <strong>digit, lower and upper case alphabet, special character</strong>";
	}
	else {
		label.innerHTML = "Password should contain <strong>atleast 8 digits</strong>";
	}
	pass_container.style.border = "2px solid red";
	document.getElementById('pass_error_block').style.display = "block";
	pass.classList.remove("valid");
	return false;
}


function isEmailValid() {
	return (email.classList.contains("valid"));
}
function isPasswordValid() {
	return (pass.classList.contains("valid"));
}

document.getElementById("button_loginID").addEventListener("click", function ()
{
	if (!isEmailValid() || !isPasswordValid())
	{
		event.preventDefault();

		if (!isEmailValid()) {
			email_verify("Username");
        }

		if (!isPasswordValid()) {
			pass_verify();
        }
		return false;
	}
	return true;
}, true);
