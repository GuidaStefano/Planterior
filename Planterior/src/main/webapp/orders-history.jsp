<%@page import="it.unisa.planterior.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.*"%>
<%@page import="it.unisa.planterior.model.dao.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	if (session.getAttribute("user") == null) {
		response.sendRedirect("authentication.jsp");
		return;
	}
	
	Customer customer = (Customer) session.getAttribute("user");
	List<Order> orders = OrderDao.getInstance().getByCliente(customer.getId());
%>

<%@page import=" java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css">
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Ordini Effettuati</title>
    </head>
    <body>
    <%@ include file="header.jsp" %>
	<div class="wrapper">
		<a href="personal-area.jsp">
		<button class="icon-button no-padding" style="margin-bottom: 20px;">
			<i class="fa-solid fa-arrow-left fa-l"></i>
			<span>Indietro</span>
		</button>
		</a>
		<div class="v-box page-content">
				<h1>STORICO ORDINI</h1>
        		<div class="v-box table">
					<div class="h-box table-header">
						<div class="table-col h-box justify-center">
							<h3>ID</h3> 
						</div>
						<div class="table-col h-box justify-center mobile-col">
							<h3>STATO</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>INDIRIZZO</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>CODICE TRACKING</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>DATA ORDINE</h3> 
						</div>
						 
						<div class="table-col justify-center">
							<h3>OPZIONI</h3> 
						</div>
					</div>
						<% for (Order ordine : orders) { %>
						<div class="h-box table-row">
								<h4 class="table-col"><%= ordine.getId() %></h4>
								<h4 class="table-col"><%= ordine.getState().toString() %></h4>
								<h4 class="table-col"><%= ordine.getShippingAddress().getStreet() %>, <%= ordine.getShippingAddress().getHouseNumber() %>, <%= ordine.getShippingAddress().getPostalCode() %></h4>
								<h4 class="table-col"><%= ordine.getTrackingCode().isEmpty() ? "-" : ordine.getTrackingCode().get() %></h4>
								<h4 class="table-col"><%= DateUtil.formatVisual(ordine.getOrderDate())%></h4>
								<form action="order-info.jsp"  method="get" class="table-col">
									<input hidden name="order-id" value="<%= ordine.getId() %>">
									<input hidden name="redirectBy" value="orders-history.jsp">
										<button type="submit" class="icon-button ">
											<i class="fa-solid fa-circle-info"></i>
										</button>
								</form>
							</div>	  
						<% } %>
				</div>
			</div>
	</div>
    <%@ include file="footer.jsp" %>  
    </body>
</html>