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
<style type="text/css">
.immagine{
    height: 50px;
    flex:1;
    text-align: center;
    width: 100px;
}
.image{
	height: 40px;
	
}


</style>
<link rel="stylesheet" href="asset/style/text-style.css" />
<link rel="stylesheet" href="asset/style/product-style.css" />
<link rel="stylesheet" href="asset/style/number-input-style.css" />

<link rel="stylesheet" href="asset/style/administrator-style.css">

		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
<meta charset="ISO-8859-1">
<title>Carrello</title>
</head>
<body>
<%@ include file="header.jsp" %>
<br>
<h1>Prodotti nel Carrello</h1>
<br>
<%
float prezzoTotale = 0;
HttpSession sessione = request.getSession();
Set<Carrello> carrello= null;

 if (sessione == null ) {
	 %>
     	<h2>Non ci sono prodotti nel carrello</h2>
     
 <%

     }
 	
        else {
        	Object listaObj = sessione.getAttribute("carrello");
        	if (listaObj instanceof HashSet<?>) {
        		carrello = (HashSet<Carrello>) listaObj;
            } else {
            	carrello = new HashSet<>();
            }
            
        	if(!carrello.isEmpty()) {
        		
        	%>	
        	
       <div class="v-box" id="table">
						<div class="h-box" id="table-header">
							
							<div class="table-col h-box justify-center">
								<h3>nome</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3>Immagine</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>quantità</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>prezzo</h3> 
							</div>
							<div class="table-col justify-center">
								<h3>opzioni</h3> 
							</div>
						</div>
						<% for (Carrello elemento : carrello) { 
							int prodotto= elemento.getProdotto();
							Optional<Product> product = ProductDao.getInstance().getById(prodotto);
							prezzoTotale = prezzoTotale + product.get().getPrice();
							prezzoTotale= Math.round(prezzoTotale * 100.0f) / 100.0f;
							 
						%>
						<div class="h-box table-row">
								<h4 class="table-col"><%= product.get().getName() %></h4>
								<div class=" immagine"><img class="image" src="asset/images/<%= product.get().getId() %>.jpg" alt="">
						</div>
								
							<div class="number-input">
	                       
		                        <button id="go" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
		                        <input id="quant" min="1" max="<%= product.get().getAvailableAmount() %>" name="quantity" value="<%= elemento.getQuantita() %>" type="number">
		                        <button id="check" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
	                      	</div>
								<h4 class="table-col"><%= Math.round(product.get().getPrice() * 100.0f) / 100.0f %>$</h4>
								<form action="Carrello" class="h-box table-col justify-center" style="column-gap: 25px;">
									<input type="hidden" name="id" value=<%= product.get().getId() %> />
									<input type="hidden" name="quantity" value=<%= elemento.getQuantita() %> />
									<button type="submit" name="action" value="delete" class="icon-button">
										<i class="fa-solid fa-trash"></i> 
									</button>	
								</form>
							</div>
							  
						<% } %>
						<div class="table-col h-box justify-center">
								<h3>Prezzo Totale</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3><%= prezzoTotale %>$</h3> 
							</div>
						
						
					</div>
					<br><br>
					<form action="Carrello" class="h-box table-col justify-center" style="column-gap: 25px;">
					<input type="hidden" name="totale" value=<%=prezzoTotale%> />
						<button  type="submit" value="acquisto" name="action" class="add-to-cart">Conferma Acquisto</button>	
					</form>
       				
        
     <%
     }else{
    	 %>
    	      	<h2>Non ci sono prodotti nel carrello</h2>
    	 
    	 
    <%  }
        	
        }
    %>
	



<br><br>
  <%@ include file="footer.jsp" %>
</body>
</html>