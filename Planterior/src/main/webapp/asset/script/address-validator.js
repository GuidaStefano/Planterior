$(document).ready(function(){
	let streetInput = $("#street");
	let houseNumberInput = $("#house-number");
	let postalCodeInput = $("#postal-code");
	
	streetInput.blur(function() {
		 let street = streetInput.val();
		 if (!/^[a-zA-Z\s]*$/.test(street)) {
			 $(this).next(".error-log").show();
			 $("#submit").prop("disabled", true);
		 } else {
			 $(this).next(".error-log").hide();
			 $("#submit").prop("disabled", false);
		 }
	 });
	 
	houseNumberInput.blur(function() {
		 let houseNumber = houseNumberInput.val();
		 if (!/^\d{1,4}$/.test(houseNumber)) {
			 $(this).next(".error-log").show();
			 $("#submit").prop("disabled", true);
		 } else {
			 $(this).next(".error-log").hide();
			 $("#submit").prop("disabled", false);
		 }
	 });
	 
	postalCodeInput.blur(function() {
		 let postalCode = postalCodeInput.val();
		 if (!/^\d{5}$/.test(postalCode)) {
			 $(this).next(".error-log").show();
			 $("#submit").prop("disabled", true);
		 } else {
			 $(this).next(".error-log").hide();
			 $("#submit").prop("disabled", false);
		 }
	 });
});
