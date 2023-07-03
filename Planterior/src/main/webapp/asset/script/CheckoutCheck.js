 $(document).ready(function(){
        	  
        	  $("#numeroCard").blur(function(){
         		 var numeroCarta =$("#numeroCard").val();
         	 	  if( numeroCarta.replace(/\s/g, '').length !== 16 || !/^\d+$/.test(numeroCarta.replace(/\s/g, '')) ){
         			 $("#ErrorCard").show().css("color","red");
         			$("#submit").prop("disabled", true);
         		  }else{
         			 $("#ErrorCard").hide();
         			$("#submit").prop("disabled", false);
         		  }
         	  });
         	
        	});
         
         $(document).ready(function(){
       	  
       	  $("#cvv").blur(function(){
        		 var cvv =$("#cvv").val();
        	 	  if( cvv.length !== 3 || !/^\d+$/.test(cvv) ){
        			 $("#ErrorCvv").show().css("color","red");
        			 $("#submit").prop("disabled", true);
        		  }else{
        			 $("#ErrorCvv").hide();
        			 $("#submit").prop("disabled", false);
        		  }
        	  });
        	
       	});
         
         $(document).ready(function() {
        	    var today = new Date();
        	    var minDate = new Date("2023-08-01");  // Data di inizio consentita
        	    
        	    // Imposta il valore minimo consentito per il campo del mese
        	    $("#Scadenza").attr("min", minDate.toISOString().slice(0, 7));
        	    
        	    // Aggiungi l'evento di controllo alla selezione del campo del mese
        	    $("#Scadenza").on("change", function() {
        	        var selectedDate = new Date($(this).val());
        	        
        	        // Verifica se la data selezionata è successiva alla data minima
        	        if (selectedDate < minDate) {
        	            $(this).get(0).setCustomValidity("Devi selezionare una data successiva ad agosto 2023.");
        	        } else {
        	            $(this).get(0).setCustomValidity("");  // Rimuovi l'eventuale messaggio di errore
        	        }
        	    });
        	});
        	
        	$(document).ready(function(){
       	  
       	  $("#cap").blur(function(){
        		 var cap =$("#cap").val();
        	 	  if( cap.length !== 5|| !/^\d+$/.test(cap) ){
        			 $("#ErrorCap").show().css("color","red");
        			 $("#submit").prop("disabled", true);
        		  }else{
        			 $("#ErrorCap").hide();
        			 $("#submit").prop("disabled", false);
        		  }
        	  });
        	
       	});
       	
       	
     	$(document).ready(function(){
       	  
       	  $("#civico").blur(function(){
        		 var civico =$("#civico").val();
        	 	  if( civico.length > 3 || !/^\d+$/.test(civico) ){
        			 $("#ErrorCivico").show().css("color","red");
        			 $("#submit").prop("disabled", true);
        		  }else{
        			 $("#ErrorCivico").hide();
        			 $("#submit").prop("disabled", false);
        		  }
        	  });
        	
       	});
        	
        	// check email
        	
        	function validateEmail(email){
      		  
      		var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-. ]\w+)*$/;
        	  if(reg.test(email)){
        			return true;
        		  }
        		return false;
          }
        	
        	$(document).ready(function(){
          	   
          	  $("#EmailLogin").keyup(function(){
          		   $("#submit").prop("disabled", false);
          		  if( validateEmail($("#EmailLogin").val())){
          			$("#ErrorLogin").html("Formato email valido").css("color","green");
          			$("#EmailLogin").css("borderBottomColor" , "green");
          		  }else{
          			
          			$("#ErrorLogin").html("Formato email non valido").css("color","red");
          			$("#EmailLogin").css("borderBottomColor" , "red");
          			$("#submit").prop("disabled", true);
          		  }
          	  });
          	
         	});
         	
         	// spazio ogni 4 numeri
         	$(document).ready(function() {
      // Ottieni il campo di input
      var numeroCardInput = $("#numeroCard");

      // Aggiungi un gestore di eventi per l'input
      numeroCardInput.on("input", function() {
		  // Rimuovi tutti gli spazi dall'input corrente
        var numeroCard = numeroCardInput.val().replace(/\s/g, "");
        
        // Dividi l'input in blocchi di quattro numeri
        var blocchi = numeroCard.match(/.{1,4}/g);
        
        // Unisci i blocchi di numeri con uno spazio tra di loro
        var numeroCardFormattato = blocchi.join(" ");
        
        // Aggiorna il valore del campo di input formattato
        numeroCardInput.val(numeroCardFormattato);
        });
      });
    
