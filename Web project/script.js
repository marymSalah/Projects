// function to check everything is filled in the form
function formCheck(){
	// to get the first name from form 
var fName = document.getElementById("firstName").value;
	// to get the last name from form 
var lName = document.getElementById("lastName").value;
	//to get the first letter of the last name from form 		
var lletter = lName.charAt(0);
    // to get the email from form 
var email = document.getElementById("email").value;
	// to get the phone from form
var phone = document.getElementById("phone").value;
	// to get the text from form
var text = document.getElementById("Text").value;
//reset spans if submitted again
document.getElementById("error1").innerHTML=("");
document.getElementById("error2").innerHTML=("");
document.getElementById("error3").innerHTML=("");
document.getElementById("error4").innerHTML=("");
document.getElementById("error5").innerHTML=("");
	// if first name is empty, display error message 
if(fName=="")
{
document.getElementById("error1").innerHTML=("Please Enter First Name");
}
	// if last name is empty, display error message 
else if(lName==""){
document.getElementById("error2").innerHTML=("Please Enter Last Name");
}
	// if email is empty, display error message 
else if(email== ""){
document.getElementById("error3").innerHTML=("Please Enter Your Email");
}
	// if phone is empty, display error message
else if(phone == ""){
document.getElementById("error4").innerHTML=("Please Enter Your Phone Number");
}
	// if text is empty, display error message
else if (text == ""){
 document.getElementById("error5").innerHTML=("Please Enter Your Inquiry");
}
// if everything is filled , display thank you message
else {
document.getElementById("success").innerHTML=("Thank you for reaching out "+fName+ "!<br>"+ "We will be in contact with you soon." );
document.getElementById("success").focus();
document.getElementById("user").style.display= "block";
document.getElementById("login").innerHTML=("  "+fName+" "+lletter);
sessionStorage.setItem("email",email);
document.getElementById("emailup").innerHTML = email;
sessionStorage.setItem("fName", fName);
sessionStorage.setItem("lletter", lletter);
}
}
	//this function checks if the user submitted the form 
function check(){
	// if there is nothing in the storage, display nothing 
	if(sessionStorage.length ==0){
		document.getElementById("user").style.display= "none";
		
	}
	// if there is something in the storage, display the block in every page 
	else{
		document.getElementById("user").style.display= "block";
		var fName= sessionStorage.getItem("fName");
		var lletter =sessionStorage.getItem("lletter");
		var email =sessionStorage.getItem("email");
		document.getElementById("logina").innerHTML=(fName +" "+lletter);
		document.getElementById("emailup").innerHTML = email;
	}
}