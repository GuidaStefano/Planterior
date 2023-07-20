$(document).ready(function(){
	var streetInput = $("#street");
	var houseNumberInput = $("#house-number");
	var postalCodeInput = $("#postal-code");
	
	streetInput.blur(function() {
		 var street = streetInput.val();
		 if (!/^[a-zA-Z\s]*$/.test(street)) {
			 $(this).next(".error-log").show();
			 $("#submit").prop("disabled", true);
		 } else {
			 $(this).next(".error-log").hide();
			 $("#submit").prop("disabled", false);
		 }
	 });
	 
	houseNumberInput.blur(function() {
		 var houseNumber = houseNumberInput.val();
		 if (!/^[0-9]{1,4}$/.test(houseNumber)) {
			 $(this).next(".error-log").show();
			 $("#submit").prop("disabled", true);
		 } else {
			 $(this).next(".error-log").hide();
			 $("#submit").prop("disabled", false);
		 }
	 });
	 
	postalCodeInput.blur(function() {
		 var postalCode = postalCodeInput.val();
		 if (!/^[0-9]{5}$/.test(postalCode)) {
			 $(this).next(".error-log").show();
			 $("#submit").prop("disabled", true);
		 } else {
			 $(this).next(".error-log").hide();
			 $("#submit").prop("disabled", false);
		 }
	 });
});
