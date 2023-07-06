<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.*"%>
<%@page import="it.unisa.planterior.model.dao.*"%>
<%@ page import="it.unisa.planterior.model.bean.Product"%>
<%@page import=" it.unisa.planterior.model.bean.Carrello"%>
<%@page import=" java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/cart-style.css" />
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="asset/script/cart.js"></script>
        <title>Carrello</title>
    </head>
    <body>
     <%@ include file="header.jsp" %>  
    <br><br>
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
 
         
        <div class="cart-wrapper">
            <h1 class="cart-title">CARRELLO</h1>
            <% 
            
            for (Carrello elemento : carrello) { 
							int prodotto= elemento.getProdotto();
							Optional<Product> product = ProductDao.getInstance().getById(prodotto);
							float prezzoProdotto=elemento.getQuantita()*product.get().getPrice();
							System.out.println("la quanita scelta "+elemento.getQuantita()+"moltiplicato per il prezzo "+product.get().getPrice());
							prezzoTotale = prezzoTotale +prezzoProdotto;
							prezzoTotale= Math.round(prezzoTotale * 100.0f) / 100.0f;
							 
							 
						%>
            <div class="cart">
                <div class="cart-product">
                    <div class="product-info">
                        <a href=""><img src="asset/images/<%= product.get().getId() %>.jpg" /></a>
                        <div class="product-details">
                            <h4><a href=""><%= product.get().getName() %></a></h4>
                            <p><a href=""><%= product.get().getCategory() %></a></p>
                        </div>
                    </div>
                    <div class="number-input">
                   		
                        <button value="meno" name="<%=product.get().getId()%>" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
		                 <input name="quant" readonly  id="<%=product.get().getId()%>" min="1" max="<%= product.get().getAvailableAmount() %>" value="<%= elemento.getQuantita() %>" type="number">
		                 <button value="add" name="<%=product.get().getId()%>" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
                    </div>
                    <h4 class="price <%=product.get().getId()%>"  ><%= (Math.round(prezzoProdotto* 100.0f) / 100.0f)%>€</h4>
                    <form action="Carrello" class="h-box table-col justify-center" style="column-gap: 25px;">
									<input type="hidden" name="id" value=<%= product.get().getId() %> />
									<input type="hidden" name="quantity" value=<%= elemento.getQuantita() %> />
									<button type="submit" name="action" value="delete" class="icon-button">
										<i class="fa-solid fa-trash"></i> 
									</button>	
								</form>
                </div>
           
                	
                
                 
            <% } %>
             
            <div class="total-price">
                    <h5>PREZZO TOTALE</h5>
                    <h3 class="prezzoTotale"><%= prezzoTotale %>$</h3>
                </div>
            </div>
            <div class="buttons">
            
            
            <form action="Carrello" method="GET">
					<input type="hidden" name="totale" value=<%=prezzoTotale%> />
					<button  type="submit" value="acquisto" name="action" class="big-button"><h6>CHECKOUT</h6></button>	
					</form>
                <a href="index.jsp"><button class="big-button"><h6>RITORNA ALLO SHOPPING</h6></button></a>
            </div>
        </div>
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