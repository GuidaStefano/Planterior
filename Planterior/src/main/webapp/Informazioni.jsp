<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Autenticazione</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="asset/style/Informazioni-Style.css" />
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script> 
        <script src="asset/script/html2canvas.min.js"></script>
            
 
    </head>
    <body>
        <div id="screen">
        <div class="v-row">
            <h1>UTENTI COINVOLTI</h1>
            <div class="h-row">
                <div class="form-wrapper">
                    <h3>CEDENTE</h3>
                    <div class="form">
                        <div>
                            <label>Nome</label>
                            <h3 class="text-input" >STD spa</h3>
                            
                        </div>
                        <div>
                             <label>Indirizzo</label>
                            <h3 class="text-input" >Via Giovanni Paolo II, 132, 84084 Fisciano SA</h3>
                        </div>
                        <div>
                             <label>Cell</label>
                            <h3 class="text-input" >+39 339 570 1330</h3>
                        </div>
                        
                        </div>
                       
                    </div>
                </div>
                <div class="form-wrapper">
                    <h3>COMMITTENTE</h3>
                    <div class="form" >
                        <div class="form-row">
                            <div>
                                <label>Nome</label>
                            <h3 class="text-input" >Salvatore</h3>
                            </div>
                            <div>
                                <label>Cognome</label>
                            <h3 class="text-input" >Mattiello</h3>
                            </div>
                        </div>
                        <div class="form-row">
                            <div>
                                <label for="name">Email</label>
                                 <h3 class="text-input" >totomatt03@gmail.com</h3>
                            </div>
                            <div>
                                <label for="surname">Metodo Di Pagamento</label>
                                <h3 class="text-input" >VISA</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
 
         </div>
         			<button id="screenshotBtn" class="add-to-cart">Scarica Fattura</button>	
					
       				
        
 <script>
 $(document).ready(function() {
     $('#screenshotBtn').click(function() {
       var element = $('#screen');

   /*    html2canvas(element).then(function(canvas) {
         var link = document.createElement('a');
         link.href = canvas.toDataURL();
         link.download = 'Fattura.png';
         link.click(); 
       });*/
       html2canvas(document.querySelector(element)).then(canvas => {
    	    document.body.appendChild(canvas)
    	});
     });
   });
  </script>
       
         
   
    </body>
</html>