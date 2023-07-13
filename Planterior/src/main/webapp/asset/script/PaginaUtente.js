/**
 * 
 
/* verifica se l'email è già in uso */
$(document).ready(function(){
	
	$("#email").blur(function(){
		var email = $("#email").val();
	    var data = "email=" + email;
	    
		//chiamata ajax
		$.ajax({
			url: 'check-email',
			data: data,
			type:'POST',
			success: function(response){
				if(response == 1){ //presente del db
					$("#email").val("").css("borderBottomColor" , "red");
					$("#Error").html("Email già in uso").css("color", "red");
				} else {
					
					$("#email").css("borderBottomColor", "green");
					
				}
			}
		});	
	});
 
	$("#email").keyup(function(){
		if( validateEmail($("#email").val())){
       		$("#Error").html("Formato email valido").css("color","green");
       		$("#email").css("borderBottomColor" , "green");
       		$("#submit").prop('disabled', false);
       		console.log("valido");
        } else {
			$("#Error").html("Formato email non valido").css("color","red");
			$("#email").css("borderBottomColor" , "red");
			$("#submit").prop('disabled', true);
			console.log("non valido");
		}
	});
});


function validateEmail(email) {
    var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-. ]\w+)*$/;
    return reg.test(email);
}