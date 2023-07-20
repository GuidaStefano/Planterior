<%@page import="it.unisa.planterior.util.DateUtil"%>
<%@page import="it.unisa.planterior.model.bean.PaymentMethod"%>
<%@page import="java.util.List"%>
<%@page import="it.unisa.planterior.model.dao.PaymentMethodDao"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	if (session.getAttribute("user") == null) {
 		response.sendRedirect("authentication.jsp");
 		return;
	} 

	Customer customer = (Customer) session.getAttribute("user");
	List<PaymentMethod> paymentMethods = PaymentMethodDao.getInstance().getByCustomer(customer);
	
%>

<%!
	public String encodeCardNumber(String cardNumber) {
		return "**** **** **** " + cardNumber.substring(12, 16);
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="asset/style/administrator-style.css">
		<link rel="stylesheet" href="asset/style/text-style.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Metodi di pagamento</title>
	</head>
	<body>
		<%@ include file="header.jsp"%>
		<div class="wrapper">
			<a href="personal-area.jsp">
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span id="back-label">Indietro</span>
				</button>
			</a>
			<div class="v-box" id="page-content">
				<h1>METODI DI PAGAMENTO</h1>
				<% if(!paymentMethods.isEmpty()) { %>
					<div class="v-box table">
						<div class="h-box table-header">
							<div class="table-col h-box justify-center">
								<h3>ID</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3>CIRCUITO</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>INTESTATARIO</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>NUMERO CARTA</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>DATA SCADENZA</h3> 
							</div>
							<div class="table-col justify-center">
								<h3>OPZIONI</h3> 
							</div>
						</div>
						<% for (PaymentMethod method : paymentMethods) { %>
								<div class="h-box table-row">
									<h4 class="table-col"><%= method.getId() %></h4>
									<h4 class="table-col mobile-col-3"><%= method.getCardCircuit().toString() %></h4>
									<h4 class="table-col mobile-col-1"><%= method.getOwner() %></h4>
									<h4 class="table-col"><%= encodeCardNumber(method.getCardNumber()) %></h4>
									<h4 class="table-col mobile-col-2"><%= DateUtil.format(method.getExpirationDate(), "MM-yyyy") %></h4>
									<form action="edit-payment-method" method="POST" class="table-col justify-center">
										<input type="hidden" name="id" value=<%= method.getId() %> />
										<button type="submit" name="action" value="delete" class="icon-button no-padding">
											<i class="fa-solid fa-trash"></i> 
										</button>
									</form>
								</div>
						<% } %>
					</div>
					<a href="add-payment-method.jsp">
						<button type="submit" name="action" value="insert" class="big-button static-btn" id="fixed-btn">
							<i class="fa-sharp fa-light fa-plus fa-xxl" style="color: white; margin-top: 3px; font-size: 1.6em;"></i>
						</button>
					</a>
				<% } else { %>
					<form action="add-payment-method.jsp" id="no-products-box" class="v-box">
						<h2>Nessun metodo di pagamento salvato.</h2>
						<button type="submit" class="big-button static-btn"><h6>Inserisci il primo</h6></button>
					</form>
				<% } %>
			</div>
		</div>
		<%@ include file="footer.jsp"%>
	</body>
</html>