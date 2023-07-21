/* verifica se l'email è già in uso */
$(document).ready(function(){
	$("#ErrorSignup").hide();
	$("#EmailSignUp").blur(function(){
		let email = $("#EmailSignUp").val();
	    let data = "email=" + email;
	    
		//chiamata ajax
		$.ajax({
			url: 'check-email',
			data: data,
			type:'get',
			success: function(response){
				if(response == 1){ //presente del db
					$("#EmailSignUp").val("").css("borderBottomColor" , "red");
					$("#ErrorSignup").show();
					$("#ErrorSignup").html("Email già in uso").css("color", "red");
				} else {
					$("#ErrorSignup").hide();
					$("#EmailSignUp").css("borderBottomColor", "green");
					$("#Registrati").prop("disabled", false);
				}
			}
		});	
	});
});
			
/* controlla il formato dell'email nel form registrazione */
$(document).ready(function(){
	$("#EmailSignUp").keyup(function(){
		if( validateEmail($("#EmailSignUp").val())){
       		$("#ErrorSignup").html("Formato email valido").css("color","green");
       		$("#EmailSignUp").css("borderBottomColor" , "green");
        } else {
			$("#ErrorSignup").html("Formato email non valido").css("color","red");
			$("#EmailSignUp").css("borderBottomColor" , "red");
		}
	});
});
				
/* controlla il formato dell'email nel form login */
$(document).ready(function() {
    $("#EmailLogin").keyup(function() {
        $("#Accedi").prop("disabled", false);
        if (validateEmail($("#EmailLogin").val())) {
            $("#ErrorLogin").html("Formato email valido").css("color", "green");
            $("#EmailLogin").css("borderBottomColor", "green");
        } else {

            $("#ErrorLogin").html("Formato email non valido").css("color", "red");
            $("#EmailLogin").css("borderBottomColor", "red");
        }
    });

});

function validateEmail(email) {
    let reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-. ]\w+)*$/;
    return reg.test(email);
}

/* disabilitare pulsante LOGIN */
$(document).ready(function() {
    $("#Accedi").click(function() {
        if (!validateEmail($("#EmailLogin").val()))
            $("#Accedi").prop("disabled", true);
    });
});

/* disabilitare pulsante REGISTRAZIONE */
$(document).ready(function() {
    $("#registrati").click(function() {
        if (!validateEmail($("#EmailSignup").val())) {
            $("#Registrati").prop("disabled", true);
            $("#EmailSignUp").css("borderBottomColor", "red");
        }
    });
});
