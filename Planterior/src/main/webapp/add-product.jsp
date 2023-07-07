<%@page import="it.unisa.planterior.model.bean.Product.Subcategory"%>
<%@page import="it.unisa.planterior.model.bean.Product.Category"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	if (session.getAttribute("user") == null) {
 		response.sendRedirect("authentication.jsp");
	} else {
 		Customer customer = (Customer) session.getAttribute("user");
 		if (!customer.isAdministrator())
 			response.sendRedirect("index.jsp");
	}
%>
  


<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="asset/style/administrator-style.css">
		<link rel="stylesheet" href="asset/style/add-product-style.css">
		<link rel="stylesheet" href="asset/style/text-style.css">
		<link rel="stylesheet" href="asset/style/number-input-style.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Aggiungi prodotto</title>
		<script>
			function evalPrice() {
				var price = $("#price").val();
				var discount = $("#discount").val();
				var totalPrice = parseFloat(price - (price / 100 * discount)).toFixed(2);
				$("#total-price").html(totalPrice < 0 ? "ERRORE" : totalPrice + "€");
			}
			
			$(document).ready(function() {
				$("#price, #discount").bind('keyup input', function() {
					evalPrice();
				});
				
	
				$(".price-btn").on( "click", function() {
					evalPrice();
				});
			});
		</script>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<div class="wrapper">
			<div class="v-box" id="page-content">
				<h1>AGGIUNGI PRODOTTO</h1>
				<form action="edit-product" method="POST" enctype="multipart/form-data"> 
					<div class="h-box column-gap">
						<div class="v-box row-gap">
							<div class="v-box form-element">
	                        	<label for="name">Nome</label>
	                            <input class="text-input" type="text"  name="name" />
	                        </div>
	                        <div class="v-box form-element">
	                       		<label for="category">Categoria</label>
	                          	<select class="text-input" name="category">
	                          	<% for(Category category : Category.values()) { %>
	                          		<optgroup label="<%= category.toString() %>">
	                          			<% for (Subcategory subcategory : category.getSubcategories()) { %>
	                          				<option value=<%= subcategory.name() %>><%= subcategory.toString() %></option>
	                          			<% } %>
	                          		</optgroup>
	                          	<% } %>
	                          	</select>
							</div>
							<div class="v-box form-element">
	                        	<label for="minimal-description">Descrizione breve</label>
	                            <textarea class="text-input textarea" name="minimal-description" rows="2" cols="50"></textarea>
	                        </div>
	                        <div class="v-box form-element">
	                        	<label for="description">Descrizione completa</label>
	                            <textarea class="big-textarea text-input textarea" name="description" rows="5" cols="50"></textarea>
	                        </div>
						</div>
						<div class="v-box row-gap">
							<div class="h-box column-gap" id="second-column">
								<div class="v-box row-gap">
									<div class="v-box form-element">
			                       		<label for="height">Altezza (cm)</label>
			                    		<div class="number-input">
			                       			<button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
			                       			<input min="1" max="99" step="0.5" name="height" value="1" type="number">
			                       			<button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
			                    		</div>
			                       	</div>
			                       	<div class="v-box form-element">
		                       			<label for="base-price">Prezzo base (€)</label>
		                    			<div class="number-input">
		                       				<button class="price-btn" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()"></button>
		                       				<input id="price" min="1" max="9999" name="base-price" value="1" type="number">
		                       				<button class="price-btn plus" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()"></button>
		                    			</div>
			                       	</div>
								</div>
								<div class="v-box row-gap">
			                       	<div class="v-box form-element">
			                       		<label for="circumference">Circonferenza vaso (cm)</label>
			                    		<div class="number-input">
			                       			<button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()"></button>
			                       			<input min="1" max="99" step="0.5" name="circumference" value="1" type="number">
			                       			<button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
			                    		</div>
			                       </div>
			                       	<div class="v-box form-element">
		                       			<label for="discount">Sconto (%)</label>
		                       			<div class="h-box">
		                       				<div class="number-input">
		                       					<button class="price-btn" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()"></button>
		                       					<input id="discount" min="0" max="100" step="0.5" name="discount" value="0" type="number">
		                       					<button class="price-btn plus" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()"></button>
		                    				</div>
		                    				<label id="total-price" style="align-self: center;">0€</label>
		                       			</div>
			                       	</div>
								</div>
							</div>
							<div class="v-box form-element">
								<label for="main-image">Immagine di copertina</label>
								<input type="file" name="main-image" accept="image/png, image/jpeg">
							
							</div>
							<div class="v-box form-element">
								<label for="images">Altre immagini</label>
								<input type="file" name="images" multiple accept="image/png, image/jpeg">
							</div>
							<div class="h-box" id="last-row">
								<div class="v-box form-element">
		                       		<label for="amount">Quantità</label>
		                       		<div class="number-input">
		                       			<button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()"></button>
		                       			<input min="1" max="9999" step="1" name="amount" value="1" type="number">
		                       			<button class="plus" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()"></button>
		                    		</div>
			                     </div>
								<button name="action" value="add" class="big-button static-btn add-button">
									<h6>AGGIUNGI PRODOTTO</h6>
								</button>	
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>