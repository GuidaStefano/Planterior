<%@page import="org.owasp.encoder.Encode"%>
<%@page import="it.unisa.planterior.util.PathUtil"%>
<%@page import="it.unisa.planterior.util.DateUtil"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.* "%>
<%@ page import="java.util.*,it.unisa.planterior.model.bean.* "%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<%
	if (session.getAttribute("user") == null || session == null) {
 		response.sendRedirect("authentication.jsp");
 		return;
	}

	Customer customer = (Customer) session.getAttribute("user");
	
	String orderIdStr = request.getParameter("order-id");
	if (orderIdStr == null) {
		response.sendRedirect(customer.isAdministrator() ? "user-dashboard.jsp" : "personal-area.jsp");
		return;
	}
	
	long orderId = Long.parseLong(orderIdStr);
	Optional<Order> optOrder = OrderDao.getInstance().getById(orderId);
	
	if (optOrder.isEmpty()) {
		response.sendRedirect(customer.isAdministrator() ? "user-dashboard.jsp" : "personal-area.jsp");
		return;
	}
	
	Order order = optOrder.get();
	
	if (!customer.isAdministrator() && !order.getCustomer().equals(customer)) {
		response.sendRedirect("personal-area.jsp");
		return;
	}
	
	String redirect = request.getParameter("redirectBy");
%>
 
 
<!DOCTYPE html>
<html lang="it">
	<head>
		<link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css">
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha384-NXgwF8Kv9SSAr+jemKKcbvQsz+teULH/a5UNJvZc6kP47hZgl62M1vGnw6gHQhb1" crossorigin="anonymous"></script>
 		<title>Info ordine - <%= orderId %></title>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<div class="wrapper">
			<a href="<%= Encode.forHtml(redirect) %>">
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span>Indietro</span>
				</button>
			</a>
			<div class="v-box page-content" style="margin-bottom: 40px;">
				<h1>INFORMAZIONI ORDINE - #<%= orderId %></h1>
        		<div class="v-box table">
					<div class="h-box table-header">
						<div class="table-col h-box justify-center mobile-col-2">
							<h3>IMMAGINE</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>ID PRODOTTO</h3> 
						</div>
						<div class="table-col h-box justify-center mobile-col-1">
							<h3>NOME PRODOTTO</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>QUANTITA'</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>PREZZO</h3> 
						</div>
					</div>
						<%
							for (OrderItem item : order.getItems()) {
								Product product = ProductDao.getInstance().getById(item.getProductId()).get();
						%>
						<div class="h-box table-row">
								<div class="table-col mobile-col-2">
									<img alt="Immagine prodotto" width="60" height="60" src=<%= PathUtil.getMainImagePath(product.getId()) %> />
								</div>
								<div class="table-col">
									<h4 class="center-in-parent"><%= product.getId() %></h4>
								</div>
								<div class="table-col mobile-col-1">
									<h4 class="center-in-parent"><%= product.getName() %></h4>
								</div>
								<div class="table-col">
									<h4 class="center-in-parent"><%= item.getAmount() %></h4>
								</div>
								<div class="table-col">
									<h4 class="center-in-parent"><%= item.getUnitPrice() * item.getAmount() %>€</h4>
								</div>
							</div> 
						<% } %>	
				</div>
			</div>
			<div class="h-box" style="justify-content: end; column-gap: 20px;">
	     		<h5>PREZZO TOTALE</h5>
	        	<h3 class="prezzoTotale"><%= order.getTotalPrice() %>€</h3>
			</div>
			<div class="h-box" style="justify-content: end; margin-top: 20px;">
				<a href="invoice.jsp?order-id=<%= orderId %>">
					<button style="width: 200px; align-items: baseline;" class="big-button static-btn h-box">
						<h6>VISUALIZZA FATTURA</h6> 					
						<i class="fa-solid fa-file-invoice" style="color: white;"></i>
					</button>
				</a>
			</div>
		</div>
        <%@ include file="footer.jsp" %>  
	</body>
</html>