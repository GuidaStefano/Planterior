$(document).ready(function(){
	let cardNumberInput = $("#card-number");
	let cvvInput = $("#cvv");
	let cardOwnerInput = $("#card-owner");
	
	cardNumberInput.blur(function(){
    	let cardNumber = cardNumberInput.val();
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
        let numeroCard = cardNumberInput.val().replace(/\s/g, "");
        
        // Dividi l'input in blocchi di quattro numeri
        let blocchi = numeroCard.match(/.{1,4}/g);
        
        // Unisci i blocchi di numeri con uno spazio tra di loro
        let numeroCardFormattato = blocchi.join(" ");
        
        // Aggiorna il valore del campo di input formattato
        cardNumberInput.val(numeroCardFormattato);
    });
    
     cvvInput.blur(function(){
     	let cvv = cvvInput.val();
     	if(cvv.length !== 3 || !/^\d+$/.test(cvv)){
     	 	cvvInput.next(".error-log").show();
     	 	$("#submit").prop("disabled", true);
      	} else {
     		cvvInput.next(".error-log").hide();
     		$("#submit").prop("disabled", false);
      	}
     });
     
     cardOwnerInput.blur(function() {
		 let cardOwner = cardOwnerInput.val();
		 if (!/^[a-zA-Z\s]*$/.test(cardOwner)) {
			 $(this).next(".error-log").show();
			 $("#submit").prop("disabled", true);
		 } else {
			 $(this).next(".error-log").hide();
			 $("#submit").prop("disabled", false);
		 }
	 });
     	
});

