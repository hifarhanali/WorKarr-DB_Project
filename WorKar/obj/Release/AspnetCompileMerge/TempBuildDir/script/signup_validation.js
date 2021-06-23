let firstname = document.getElementById('textbox_firstnameID');
let lastname = document.getElementById('textbox_lastnameID');
let terms_chkbox = document.getElementById('chkbox_terms_conditionsID');


// msg container for input fields
var firstname_container = document.querySelector('#first_name_containerID');
var lastname_container = document.querySelector('#last_name_containerID');



// add event listener to each input field
firstname.addEventListener('textInput', firstname_verify);
lastname.addEventListener('textInput', lastname_verify);
email.addEventListener('textInput', function () {
	email_verify("Email Address");
}, false);




// return true, if object value is alphanumeric
function isAlphabetic(obj) {
	let letters = /^[A-Za-z]+$/;
	return obj.value.match(letters);
}


// return true, if name is valid
function firstname_verify() {
	let label = document.querySelector('#label_name_errorID');
	if (isAlphabetic(firstname)) {
		firstname_container.style.border = "2px solid #004675";
		document.getElementById('name_error_block').style.display = "none";
		firstname.classList.add("valid");		// to indicate that first name is valid
		return true;
	}
	label.innerHTML = "Firstname should contain <strong>alphabets only</strong>";
	firstname_container.style.border = "2px solid red";
	document.getElementById('name_error_block').style.display = "block";
	firstname.classList.remove("valid");		// to indicate that first name is valid
	return false;
}

function lastname_verify() {
	let label = document.querySelector('#label_name_errorID');
	if (isAlphabetic(lastname)) {
		lastname_container.style.border = "2px solid #004675";
		document.getElementById('name_error_block').style.display = "none";
		lastname.classList.add("valid");		// to indicate that last name is valid
		return true;
	}
	label.innerHTML = "Lastname should contain <strong>alphabets only</strong>";
	lastname_container.style.border = "2px solid red";
	document.getElementById('name_error_block').style.display = "block";
	lastname.classList.remove("valid");		// to indicate that last name is valid
	return false;
}


// verify email is valid or not
function email_verify(msg_type) {
	let label = document.querySelector('#label_email_errorID');
	if (email.value.length >= 9) {
		if (/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(email.value)) {
			email_container.style.border = "2px solid #004675";
			document.getElementById('email_error_block').style.display = "none";
			email.classList.add("valid");		// to indicate that email is valid
			return true;
		}
		label.innerHTML = "Kindly enter <strong>valid " + msg_type.toLowerCase() + "</strong>";
	}
	else {
		label.innerHTML = msg_type + " is <strong>too short</strong> to proceed";
	}
	email_container.style.border = "2px solid red";
	document.getElementById('email_error_block').style.display = "block";
	email.classList.remove("valid");
	return false;
}

function isFirstNameValid() {
	return (firstname.classList.contains("valid"));
}
function isLastNameValid() {
	return (lastname.classList.contains("valid"));
}

function isCheckedTerms() {
	return (terms_chkbox.classList.contains("valid"));
}



// verify email is valid or not
function terms_verify() {
	let label = document.querySelector('#label_terms_errorID');
	if (terms_chkbox.checked == true) {
		terms_chkbox.classList.add("valid");
		return true;
	}

	label.innerHTML = "Have you read <strong>Terms and Conditions?</strong>";
	document.getElementById('terms_error_blockID').style.display = "block";
	terms_chkbox.classList.remove("valid");
	return false;
}



document.getElementById("button_signupID").addEventListener("click", function () {
	if (!isFirstNameValid() || !isLastNameValid() || !isEmailValid() || !isPasswordValid() || !isCheckedTerms())
	{
		event.preventDefault();

		if (!isCheckedTerms()) {
			terms_verify();
        }

		if (!isFirstNameValid()) {
			firstname_verify();
		}

		if (!isLastNameValid()) {
			lastname_verify();
        }

		if (!isEmailValid()) {
			email_verify("Email Address");
		}

		if (!isPasswordValid()) {
			pass_verify();
		}
		return false;
	}
	return true;
}, true);
