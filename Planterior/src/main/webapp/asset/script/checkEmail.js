/*<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  */      
  /*SE EMAIL ESISTE GIA   E SE FORMATO VALIDO DELLA REGISTRAZIONE*/
       
        $(document).ready(function(){
        	 $("#ErrorSignup").hide();
				$("#EmailSignUp").blur(function(){
					
					var email=$("#EmailSignUp").val();
					var dati = "email="+email;
				//	$("#checkEmail").hide();
					
					//chiamata ajax
					$.ajax({
						url: 'checkEmailServlet',
						data: dati,
						type:'get',
						success: function(response){
							 if(response==1){ //presente del db
								 $("#EmailSignUp").val("").css("borderBottomColor" , "red");
							 	 $("#ErrorSignup").show();
							 	 $("#ErrorSignup").html("Email già in uso").css("color","red");
							 }
							 else{
							 	 $("#ErrorSignup").hide();
							 	  $("#EmailSignUp").css("borderBottomColor" , "green");
							 }
						}
					});	
				});
				});
				
				
			/*   CHECK FORMATO EMAIL REGISAZIONE */
          
          $(document).ready(function(){
          	   
          	  $("#EmailSignUp").keyup(function(){
          		   
          		  if( validateEmail($("#EmailSignUp").val())){
          			$("#ErrorSignup").html("Formato email valido").css("color","green");
          			$("#EmailSignUp").css("borderBottomColor" , "green");
          		  }else{
          			
          			$("#ErrorSignup").html("Formato email non valido").css("color","red");
          			$("#EmailSignUp").css("borderBottomColor" , "red");
          		  }
          	  });
          	
         	});
				
				 
				
        	 
         
      /*   CHECK FORMATO EMAIL LOGIN */
          
          $(document).ready(function(){
          	   
          	  $("#EmailLogin").keyup(function(){
          		   
          		  if( validateEmail($("#EmailLogin").val())){
          			$("#ErrorLogin").html("Formato email valido").css("color","green");
          			$("#EmailLogin").css("borderBottomColor" , "green");
          		  }else{
          			
          			$("#ErrorLogin").html("Formato email non valido").css("color","red");
          			$("#EmailLogin").css("borderBottomColor" , "red");
          		  }
          	  });
          	
         	});
         	
          function validateEmail(email){
      		  
      		var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-. ]\w+)*$/;
        	  if(reg.test(email)){
        			return true;
        		  }
        		return false;
          }
          
         /*disabilitare pulsante LOGIN*/
        
      
        	$(document).ready(function(){
          	   
          	  $("#Login").click(function(){
          		   
          		  if( validateEmail($("#EmailLogin").val())){
          			$("#Login").removeAttr('disabled','disabled');
          		  }else{
          			
          			$("#Login").attr('disabled','disabled');
          		  }
          	  });
          	
          	
         	});
         	$(document).ready(function(){
          	   
          	  $("#SignUp").click(function(){
          		   
          		  if( validateEmail($("#EmailSignup").val())){
          			$("#SignUp").removeAttr('disabled','disabled');
          		  }else{
					$("#EmailSignUp").css("borderBottomColor" , "red");
          			$("#SignUp").attr('disabled','disabled');
          		  }
          	  });
          	
          	
         	});
        