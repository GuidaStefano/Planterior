<%@page import="it.unisa.planterior.model.bean.Product.Subcategory"%>
<%@page import="it.unisa.planterior.model.bean.Product.Category"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	if (session.getAttribute("user") == null) {
 		response.sendRedirect("authentication.jsp");
 		return;
	}

	String redirect = request.getParameter("redirectBy");
%>
  
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="asset/style/administrator-style.css">
		<link rel="stylesheet" href="asset/style/add-product-style.css">
		<link rel="stylesheet" href="asset/style/text-style.css">
		<link rel="stylesheet" href="asset/style/number-input-style.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script src="asset/script/address-validator.js"></script>   
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Aggiungi metodo di pagamento</title>
		<style>
			@media screen and (max-width: 992px) {
				form > .h-box {
					flex-direction: row;
				}
			}
			
			@media screen and (max-width: 768px) {
				form > .h-box {
					flex-direction: column;
					row-gap: 20px;
				}
				
				#radio-input {
					justify-content: start;
				}
			}
			
			@media screen and (max-width: 480px) {
				.text-input {
					width: 100% !important; 
				}
			}
</style>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<div class="wrapper">
			<a href="<%= redirect == null ? "addresses.jsp" : redirect %>">
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span id="back-label">Indietro</span>
				</button>
			</a>
			<div class="v-box" id="page-content">
				<h1>AGGIUNGI INDIRIZZO</h1>
				<form action="edit-addresses" method="POST" class="v-box row-gap" > 
					<div class="h-box column-gap">
						<div class="v-box">
							<label>Via</label>
							<input type="text" class="text-input" id="street" name="street" required style="width: 465px;" />
							<p class="error-log" hidden>Via non valida</p>
						</div>
					</div>
					<div class="h-box column-gap">
						<div class="v-box">
							<label>Civico</label>
							<input type="text" class="text-input" id="house-number" name="house-number" required style="width: 200px;" />
							<p class="error-log" hidden>Civico non valido</p>
						</div>
						<div class="v-box">
							<label>CAP</label>
							<input type="text" class="text-input" id="postal-code" name="postal-code" required style="width: 200px;" />
							<p class="error-log" hidden>CAP non valido</p>
						</div>
					</div>
					<% if (redirect != null) { %>
						<input hidden name="redirect" value="<%= redirect %>">
					<% } %>
					<button name="action" value="add" class="big-button static-btn" id="submit" style="width: 200px;">
						<h6>AGGIUNGI</h6>
					</button>	
				</form>
			</div>
		</div>
	</body>
</html>