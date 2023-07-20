<%@page import="it.unisa.planterior.util.PathUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@page import="it.unisa.planterior.model.bean.Product"%>
<%@page import="java.util.*"%>

<%
	if(request.getParameter("id") == null)
		response.sendRedirect("index.jsp");

	String idStr = request.getParameter("id");
	int id = -1;
	try {
    	id = Integer.parseInt(idStr);
	} catch (NumberFormatException e) {
		response.sendRedirect("index.jsp");
	}

	Optional<Product> opt = ProductDao.getInstance().getById(id);
	if(opt.isEmpty()) response.sendRedirect("index.jsp");
	
	Product product = opt.get();
%>
<!doctype html>
<html>
    <head>
        <title>Scheda prodotto</title>
        <link rel="stylesheet" href="asset/style/product-style.css" />
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
    </head>
    <body>
        <%@ include file="header.jsp" %>  
        <div class="product-card">
            <div class="product-image">
                <img id="main-image" height=400 src=<%= PathUtil.getMainImagePath(product.getId()) %> alt="Product Image">
                <div class="product-thumbs">
                	<% for (String path : PathUtil.getImagesPaths(product.getId())) { %>
						<div class="product-thumb">
                        	<img src=<%= path %> alt="Product Thumb" onclick="document.getElementById('main-image').src = this.src;">
                    	</div>
					<% } %>
                </div>
            </div>
            
            <div class="product-details">
                <h1 class="product-title"><%= product.getName() %></h1>
                <p class="product-price"><%= Math.round(product.getPrice() * 100.0f) / 100.0f%>€</p>
                <p class="product-description"><%= product.getDescription() %></p>
                <div class="number-input-wrapper">
	                <form class="form" action="cart" method="GET"> 
	                	<div class="v-box" style="row-gap: 3px;">
		                	<div class="h-box" style="column-gap: 15px;">
								<div class="number-input">
		                        	<button id="down" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
		                        	<input id="quant" min="1" name="amount" value="1" type="number">
		                        	<input type="hidden" name="id" value="<%= product.getId() %>">
		                        	<button id="up" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
		                      	</div>
		                    	<button type="submit" name="action" value="add" class="big-button static-btn"><h6 style="margin: 12px 30px;">AGGIUNGI AL CARRELLO</h6></button>
		                	</div>
	                		<span id="error-log" hidden>Quantità massima raggiunta</span>
	                	</div>
	                 </form>   
                </div>
            </div>
              
        </div>
        
        <script>
        	$(document).ready(function(){
          		var maxAmount = <%= product.getAvailableAmount() %>;
          	  	$("#up").click(function(){
          		  	var amount = $("#quant").val();
          		  	if(amount >= maxAmount){
          				$("#up").prop("disabled", true);
          				$("#error-log").show().css("color", "red");
          		  	}
          	  	});
          	  	
           	  	$("#down").click(function(){
           	  		var amount = $("#quant").val();
           	  		if (amount > maxAmount)
           	  			$("#quant").val(maxAmount);
           			$("#up").prop("disabled", false);
           			$("#error-log").hide();
           	  	});
           	  	
           	 	$("#quant").bind('keyup mouseup', function () {
          		  	var amount = $("#quant").val();
          		  	if(amount > maxAmount){
          		  		$("#quant").val(maxAmount);
          				$("#up").prop("disabled", true);
          				$("#error-log").show().css("color", "red");
          		  	}         
           		});
         	});
        	

        	
        	
        
        </script> 
        <%@ include file="footer.jsp" %>  
    </body>
</html>