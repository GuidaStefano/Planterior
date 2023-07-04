<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@ page import="it.unisa.planterior.model.bean.Product"%>
<%@page import=" it.unisa.planterior.model.bean.Carrello"%>
<%@page import=" java.util.*"%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.planterior.model.bean.Customer"%>
 

<head>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>  
	<script src="asset/script/html2canvas.min.js.js"></script>
<link rel="stylesheet" href="asset/style/text-style.css" />
<link rel="stylesheet" href="asset/style/Informazioni-Style.css" />
<link rel="stylesheet" href="asset/style/product-style.css" />
<link rel="stylesheet" href="asset/style/number-input-style.css" />

<link rel="stylesheet" href="asset/style/administrator-style.css">

		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
<meta charset="ISO-8859-1">
<title>Conferma Pagamento</title>
</head>
<body>
<%@ include file="header.jsp" %>
<br>
 
<%

HttpSession sessione = request.getSession();
if(sessione.getAttribute("ordine")==null){
	request.getRequestDispatcher("authentication.jsp").forward(request, response);
}else{
			Customer customer=null;
	 		customer = (Customer)sessione.getAttribute("user");
 
			Set<Carrello> carrello= null;
			float Totale = (float)sessione.getAttribute("prezzoTotale");
        	Object listaObj = sessione.getAttribute("carrello");
        	if (listaObj instanceof HashSet<?>) {
        		carrello = (HashSet<Carrello>) listaObj;
            } else {
            	carrello = new HashSet<>();
            }
     // 	sessione.removeAttribute("carrello");
        	
        		
        	%>	
        <h1>CONFERMA PAGAMENTO</h1>
		<h3>Grazie mille <%= customer.getName() %> </h3>
		<br><br><br>
		<h1>RIEPILOGO ORDINE</h1>
		<br><br>
		<div id="screen"> <!-- da qui parte lo screen -->
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
 
         
       
         
   
       <div class="v-box" id="table">
						<div class="h-box" id="table-header">
							
							<div class="table-col h-box justify-center">
								<h3>NOME</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3>ID</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>quantità</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>prezzo</h3> 
							</div>
							
						</div>
						<% for (Carrello elemento : carrello) { 
							int prodotto= elemento.getProdotto();
							Optional<Product> product = ProductDao.getInstance().getById(prodotto);
							
							 
						%>
						<div class="h-box table-row">
								<h4 class="table-col"><%= product.get().getName() %></h4>
								<h4 class="table-col"><%= product.get().getId() %></h4>
		                       <h4 class="table-col"><%= elemento.getQuantita() %></h4>
		                       <h4 class="table-col"><%= Math.round(product.get().getPrice() * 100.0f) / 100.0f %>$</h4>
									
								</div>
							
							  
						<% } %>
						
						<div class="table-col h-box justify-center">
								<h3>TOTALE SPESO</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3><%= Totale %>$</h3> 
							</div>
					</div>
					</div>
					<br><br>
					
						<button id="generate-pdf" class="add-to-cart">Scarica Fattura</button>	
					
       				
        
 <script>
 $(document).ready(function () {
     // Funzione per generare il PDF
     function generaPDF() {
         // Crea una nuova istanza di jsPDF
         var doc = new jsPDF();

         // Ottieni l'elemento HTML da convertire in PDF
         var element = $('#screen')[0];

         // Converti l'elemento HTML in PDF
         doc.fromHTML(element, 10, 10);

         // Salva il documento PDF
         doc.save('fattura.pdf');
     }

     // Aggiungi l'evento di click al pulsante per generare il PDF
     $('#generate-pdf').click(function () {
         generaPDF();
     });
 });
  </script>
    
	



<br><br>
  <%@ include file="footer.jsp" %>
  <% 
  sessione.removeAttribute("carrello");
  sessione.removeAttribute("order");
	} %>
</body>
</html>