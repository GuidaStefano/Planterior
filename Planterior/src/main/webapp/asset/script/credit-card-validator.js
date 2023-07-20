$(document).ready(function(){
	var cardNumberInput = $("#card-number");
	var cvvInput = $("#cvv");
	var cardOwnerInput = $("#card-owner");
	
	cardNumberInput.blur(function(){
    	var cardNumber = cardNumberInput.val();
    	if(cardNumber.replace(/\s/g, '').length !== 16 || !/^\d+$/.test(cardNumber.replace(/\s/g, '')) ){
        	cardNumberInput.next(".error-log").show();
        	$("#submit").prop("disabled", true);
       	} else {
			cardNumberInput.next(".error-log").hide();
         	$("#submit").prop("disabled", false);
		}
	});

    cardNumberInput.on("input", function() {
		  // Rimuovi tutti gli spazi dall'input corrente
        var numeroCard = cardNumberInput.val().replace(/\s/g, "");
        
        // Dividi l'input in blocchi di quattro numeri
        var blocchi = numeroCard.match(/.{1,4}/g);
        
        // Unisci i blocchi di numeri con uno spazio tra di loro
        var numeroCardFormattato = blocchi.join(" ");
        
        // Aggiorna il valore del campo di input formattato
        cardNumberInput.val(numeroCardFormattato);
    });
    
     cvvInput.blur(function(){
     	var cvv = cvvInput.val();
     	if(cvv.length !== 3 || !/^\d+$/.test(cvv)){
     	 	cvvInput.next(".error-log").show();
     	 	$("#submit").prop("disabled", true);
      	} else {
     		cvvInput.next(".error-log").hide();
     		$("#submit").prop("disabled", false);
      	}
     });
     
     cardOwnerInput.blur(function() {
		 var cardOwner = cardOwnerInput.val();
		 if (!/^[a-zA-Z\s]*$/.test(cardOwner)) {
			 $(this).next(".error-log").show();
			 $("#submit").prop("disabled", true);
		 } else {
			 $(this).next(".error-log").hide();
			 $("#submit").prop("disabled", false);
		 }
	 });
     	
});

