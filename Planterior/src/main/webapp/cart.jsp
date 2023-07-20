<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="it.unisa.planterior.util.PathUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.*"%>
<%@page import="it.unisa.planterior.model.dao.*"%>
<%@ page import="it.unisa.planterior.model.bean.Product"%>
<%@page import=" java.util.*"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/cart-style.css" />
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="asset/script/edit-amount.js"></script>
        <title>Carrello</title>
    </head>
    <body>
    <%@ include file="header.jsp" %>  
    <%
    	Object cartObj = session.getAttribute("cart");
    	if (cartObj == null) { // carrello non presente nella sessione
    		session.setAttribute("cart", new HashMap<Long, Short>());
    	}
    	
    	@SuppressWarnings("unchecked") 
    	Map<Long, Short> cart = (HashMap<Long, Short>) session.getAttribute("cart"); // <id prodotto, quantità>
    	
    	float totalPrice = 0f;
    	DecimalFormat decimalFormat = new DecimalFormat("0.00");
    	decimalFormat.setDecimalFormatSymbols(DecimalFormatSymbols.getInstance(Locale.US));
 	%>	
	<div class="cart-wrapper">
		<a href="index.jsp">
			<button class="icon-button no-padding" style="margin-bottom: 20px;">
				<i class="fa-solid fa-arrow-left fa-l"></i>
				<span>Indietro</span>
			</button>
		</a>
    	<h1 class="cart-title">CARRELLO</h1>
    	<% if (cart.isEmpty()) { %>
    		<h2>Il tuo carrello è vuoto.</h2>
    	<% } else { %>
	    	<div class="cart">
	    	<%
	    		for (Entry<Long, Short> entry : cart.entrySet()) {
	    			long productId = entry.getKey();
	    			short amount = entry.getValue();
	    			
					Optional<Product> optProduct = ProductDao.getInstance().getById(productId);
					if (optProduct.isEmpty()) continue;
					
					Product product = optProduct.get();
					
					float price = product.getPrice() * amount;
					totalPrice += price;
	    	%>
	        	<div class="cart-product" id="product-<%= productId %>">
	            	<div class="product-info">
	                	<a href="product.jsp?id=<%= productId %>"><img alt="Immagine prodotto" src=<%= PathUtil.getMainImagePath(productId) %> /></a>
	                	<div class="product-details">
	                    	<h4><a href="product.jsp?id=<%= productId %>"><%= product.getName() %></a></h4>
	                    	<p><a href=""><%= product.getCategory() %></a></p>
	                	</div>
	            	</div>
	            	<div class="v-box">
		            	<div class="number-input">
		            		<button value="meno" name="<%= productId %>" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
			         		<input name="quant" readonly id="<%= productId %>" min="1" max="<%= product.getAvailableAmount() %>" value="<%= amount %>" type="number">
			         		<button value="add" name="<%= productId %>" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
		            	</div>
		            	<%
		            		String displayErrorBox = "none";
		            		if (session.getAttribute("is-max-amount") != null) {
		            			session.removeAttribute("is-max-amount");
		            			displayErrorBox = "block";
		            		} 
		            	%>
		            	<p class="error-log" id="error-<%= productId %>" style="display: <%= displayErrorBox %>">Quantità massima</p>
	            	</div>
	            	<h4 id="price-<%= productId %>" ><%= decimalFormat.format(price) %>€</h4>
	            	<form action="cart" style="column-gap: 25px;">
						<input type="hidden" name="id" value=<%= productId %> />
						<input type="hidden" name="amount" value=<%= amount %> />
						<button type="submit" name="action" value="remove" class="icon-button delete-btn">
							<i class="fa-solid fa-trash"></i> 
						</button>	
					</form>
	        	</div>     
	        <% 
				} 
	        %>
	        
	       		<div class="total-price-w">
	        		<h5>PREZZO TOTALE</h5>
	            	<h3 id="total-price"><%= decimalFormat.format(totalPrice) %>€</h3>
	       		</div>
	        </div>
    	<% } %>
        <div class="buttons">
        	<% if (!cart.isEmpty()) { %>
        		<a href="checkout.jsp"><button class="big-button"><h6>CHECKOUT</h6></button></a>
        	<% } %>
            <a href="index.jsp"><button class="big-button"><h6>RITORNA ALLO SHOPPING</h6></button></a>
        </div>
   		</div>
    	<%@ include file="footer.jsp" %>  
    </body>
</html>