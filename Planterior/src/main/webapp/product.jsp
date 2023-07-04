<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@page import="it.unisa.planterior.model.bean.Product"%>
<%@page import="java.util.*"%>

<%
if(request.getParameter("id")==null)
	 request.getRequestDispatcher("index.jsp").forward(request, response);

String valoreParametro = request.getParameter("id");
int id = 0;
try {
    id = Integer.parseInt(valoreParametro);
} catch (NumberFormatException e) {
    // Gestione dell'eccezione nel caso in cui il parametro non sia un intero valido
}

Optional<Product> prodotto = ProductDao.getInstance().getById(id);
if(prodotto.isEmpty()){
	response.sendRedirect("index.jsp");
}
%>
<!doctype html>
<html>
    <head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
        <title>Scheda prodotto</title>
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/product-style.css" />
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  

    </head>
    <body>
        <%@ include file="header.jsp" %>  
        <div class="product-card">
            <div class="product-image">
                <img id="main-image" src="asset/images/<%= prodotto.get().getId() %>.jpg" alt="Product Image">
                <div class="product-thumbs">
                    <div class="product-thumb">
                        <img src="asset/images/lezio20.jpg" alt="Product Thumb" onclick="document.getElementById('main-image').src = this.src;">
                    </div>
                    <div class="product-thumb">
                        <img src="asset/images/lezio21.jpg" alt="Product Thumb" onclick="document.getElementById('main-image').src = this.src;">
                    </div>
                    <div class="product-thumb">
                        <img src="asset/images/lezio20.jpg" alt="Product Thumb" onclick="document.getElementById('main-image').src = this.src;">
                    </div>
                </div>
            </div>
            
            <div class="product-details">
                <h1 class="product-title"><%= prodotto.get().getName() %></h1>
                <p class="product-price"><%= Math.round(prodotto.get().getPrice() * 100.0f) / 100.0f%>$</p>
                <p class="product-description"><%= prodotto.get().getDescription() %></p>
                <div class="number-input-wrapper">
	                <form class="form" action="Carrello " method="GET"> 
	                      <div class="number-input">
	                       
	                        <button id="go" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
	                        <input id="quant" min="1" name="quantity" value="1" type="number">
	                        <input type="hidden" name="id" value="<%= prodotto.get().getId() %>">
	                        <button id="check" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
	                      </div>
	                      <span id="ErrorQuantity" hidden>Quantità Massima Raggiunta</span>
	                      
	                    <a href="Carrello"> <button id="carrello" type="submit" class="add-to-cart">Aggiungi al carrello</button></a>
	                 </form>   
                </div>
            </div>
              
        </div>
        
        <script>
        	$(document).ready(function(){
          	   var quantity = <%= prodotto.isPresent() ? prodotto.get().getAvailableAmount() : 0 %>;
          	  $("#check").click(function(){
          		  if(quantity <= $("#quant").val() ){
          			$("#check").prop("disabled", true);
          			$("#ErrorQuantity").show().css("color","red");
          		  }
          	  });
         	});
        	
        	$(document).ready(function(){
             	  $("#go").click(function(){
             		 $("#check").prop("disabled", false);
             		$("#ErrorQuantity").hide();
             	  });
            	});
        	
        	
        
        </script> 
        <%@ include file="footer.jsp" %>  
    </body>
</html>