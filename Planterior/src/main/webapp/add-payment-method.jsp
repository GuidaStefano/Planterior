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
		<script src="asset/script/credit-card-validator.js"></script>   
		
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
			<a href="<%= redirect == null ? "payment-methods.jsp" : redirect %>">
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span id="back-label">Indietro</span>
				</button>
			</a>
			<div class="v-box" id="page-content">
				<h1>AGGIUNGI METODO DI PAGAMENTO</h1>
				<form action="edit-payment-method" method="POST" class="v-box row-gap" > 
					<div class="h-box">
						<div class="v-box" style="row-gap: 10px;">
							<label>Circuito</label>
							<div id="radio-input" class="h-box" style="column-gap: 15px;">
								<div>
                                	<input type="radio" id="VISA" name="circuit" value="VISA" required />
                                    <label for="VISA"><i class="fa-brands fa-cc-visa"></i> </label>
                                </div>
                                <div>
                                	<input type="radio" id="MASTERCARD" name="circuit" value="MASTERCARD" />
                                	<label for="MASTERCARD"><i class="fa-brands fa-cc-mastercard"></i></label>
                                </div>
                                <div>
                                	<input type="radio" id="AMERICAN_EXPRESS" name="circuit" value="AMERICAN_EXPRESS" />
                                	<label for="AMERICAN_EXPRESS"><i class="fa-brands fa-cc-amex"></i></label>
                            	</div>
							</div>
						</div>
					</div>
					<div class="h-box column-gap">
						<div class="v-box">
							<label>Numero carta</label>
							<input type="text" class="text-input" id="card-number" name="card-number" maxlength="19" required style="width: 300px;" />
							<p class="error-log" hidden>Numero della carta non valido</p>
						</div>
						<div class="v-box">
							<label>CVV</label>
							<input type="text" class="text-input" id="cvv" name="cvv" required style="width: 200px;" />
							<p class="error-log" hidden>CVV non valido</p>
						</div>
					</div>
					<div class="h-box column-gap">
						<div class="v-box">
							<label>Intestatario</label>
							<input type="text" class="text-input" id="card-owner" name="card-owner" required style="width: 300px;" />
							<p class="error-log" hidden>Intestatario non valido</p>
						</div>
						<div class="v-box">
							<label>Data di scadenza</label>
							<input type="month" class="text-input" min="2023-07" name="expiration-date" required style="width: 200px;" />
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

                