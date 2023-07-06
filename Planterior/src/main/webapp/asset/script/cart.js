 $(document).ready(function(){
            	   
            	  
            	  $('button[type=button][value=add]').on("click", function(){
					  
              	    var id =$(this).attr("name");//cotiene
              	    $('button[type=button][value=meno][name='+id+']').prop('disabled', false);
              	  var quantity=$('input[id='+ id +']').val();
              	  var max=$('input[id='+ id +']').attr("max");
              	 
              	  if(quantity<=max){
              	  var id_prodtto=$('input[id='+ id +']').attr("id");
              	
              	var prezzo=$('h4.' + id).text().slice(0, -1);
              	var prezzoBase=prezzo/(quantity-1);
              	var nuovoPrezzo=prezzoBase*quantity;
              	var prezzoTotale=$('h3.prezzoTotale').text().slice(0, -1);
              	prezzoTotale=parseFloat(prezzoTotale) + parseFloat(prezzoBase);
              	  
              	$('h4.' + id).text(nuovoPrezzo.toFixed(2)+'$');
          	  	$('h3.prezzoTotale').text(prezzoTotale.toFixed(2)+'$');
          	  	var parametri = {
					  quantity: quantity,
					  id_prodtto: id_prodtto,
					  // Aggiungi altri parametri se necessario
					};
				chiamata(parametri);
          	  	}
          	  	if(quantity==max){
					$(this).prop('disabled', true);

					}
              	  });
              	  /**/
            	  //pulsante shortS
            	  $('button[type=button][value=meno]').on("click", function(){
                	  var   id_meno =$(this).attr("name");//cotiene
                	$('button[type=button][value=add][name='+id_meno+']').prop('disabled', false);
                	   var quantity_meno=$('input[id='+ id_meno +']').val();
                	  
                	  if(quantity_meno>=1){
						  
                	var   id_prodtto_meno=$('input[id='+ id_meno +']').attr("id");
                	
                	var prezzo_meno=$('h4.' + id_meno).text().slice(0, -1);
                	var prezzoBase_meno=prezzo_meno/(parseFloat(quantity_meno)+1);
                	var nuovoPrezzo_meno=prezzoBase_meno*quantity_meno;
                	
                	var prezzoTotale_meno=$('h3.prezzoTotale').text().slice(0, -1);
                	var prezzoTotale_meno=parseFloat(prezzoTotale_meno) - parseFloat(prezzoBase_meno);
                	
               // 	alert("quanitity:"+quantity_meno+"prezzo:"+prezzo_meno+"nuovoPrezzo:"+nuovoPrezzo_meno+"prezzoTotale:"+prezzoTotale_meno);
                	  
                	$('h4.' + id_meno).text(nuovoPrezzo_meno.toFixed(2)+'$');
            	  	$('h3.prezzoTotale').text(prezzoTotale_meno.toFixed(2)+'$');
            	  	var parametri = {
					  quantity: quantity_meno,
					  id_prodtto: id_prodtto_meno,
					  // Aggiungi altri parametri se necessario
					};
					chiamata(parametri);
            	  	}
            	  	if(quantity_meno==1){
						  $(this).prop('disabled', true);
					  }
                	  });
                	  
                	  
            	    

            	});
            	
            	
            	
function chiamata(parametri) {
   $.ajax({
					  url: 'Carrello',
					  method: 'POST',
					  data: parametri,
					  success: function(response) {
					    // Gestisci la risposta della chiamata AJAX
					    console.log(response);
					  },
					  error: function(xhr, status, error) {
					    // Gestisci l'errore della chiamata AJAX
					    console.log(error);
					  }	
					});
} 