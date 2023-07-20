<%@page import="java.time.ZonedDateTime"%>
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
	} else {
 		Customer customer = (Customer) session.getAttribute("user");
 		if (!customer.isAdministrator())
 			response.sendRedirect("index.jsp");
	}

	Set<Order> allOrders = OrderDao.getInstance().getAll();
	Set<Order> orders = new HashSet<>();
	
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	
	for (Order order : allOrders) {
		boolean keep = true;
		if (start != null) {
			ZonedDateTime startDate = DateUtil.parse(start).minusDays(1);
			keep = order.getOrderDate().isAfter(startDate);
		}
			
		if (end != null) {
			ZonedDateTime endDate = DateUtil.parse(end);
			keep = keep && order.getOrderDate().isBefore(endDate);
		}
			
		if (keep)
			orders.add(order);
	}
		
%>
 
 
<!DOCTYPE html>
<html lang="it">
	<head>
		<link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css">
        <link rel="stylesheet" href="asset/style/authentication-style.css">
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
 		<title>Dashboard ordini</title>
 		<script>
			$(document).ready(function() {
 				var searchDiv = $("#search-div");
 				$("#show-input-btn").on("click", function() {
 					if (searchDiv.css("display") == "none") {
 						searchDiv.css("display", "flex");
 					} else {
 						searchDiv.css("display", "none");
 					}
 				});
 			});
			</script>
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
				<div class="h-box" style="justify-content: start; column-gap: 15px;">
					<h1>ORDINI COMPLESSIVI</h1>
					<button id="show-input-btn" class="icon-button"><i class="fa-solid fa-filter fa-lg"></i></button>
				</div>
				<form class="h-box" action="order-dashboard.jsp" id="search-div" style="display: none; justify-content: start; align-items: end; column-gap: 20px;">
					<div class="v-box">
						<label>Da</label>
						<input name="start" style="width: 250px;" type="date" class="text-input" />
					</div>
					<div class="v-box">
						<label>A</label>
						<input name="end" style="width: 250px;" type="date" class="text-input" />
					</div>
					<button class="big-button static-btn" style="height: 42px;"><h6>CERCA</h6></button>
				</form>
				<% if(!orders.isEmpty()) { %>
					<div class="v-box table">
						<div class="h-box table-header">
							<div class="table-col h-box justify-center">
								<h3>ID</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3>ESEGUITO DA</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>STATO</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>DATA ORDINE</h3> 
							</div>
							 
							<div class="table-col justify-center">
								<h3>OPZIONI</h3> 
							</div>
						</div>
							<% for (Order order : orders) { %>
							<div class="h-box table-row">
									<h4 class="table-col"><%= order.getId() %></h4>
									<h4 class="table-col"><%= order.getCustomer().getEmail() %></h4>
	
									<h4 class="table-col"><%= order.getState().toString() %></h4>
									<h4 class="table-col"><%= DateUtil.formatVisual(order.getOrderDate())%></h4>
									<form action="order-info.jsp"  method="get" class="table-col">
										<input hidden name="order-id" value="<%= order.getId() %>">
										<input hidden name="redirectBy" value="order-dashboard.jsp">
											<button type="submit" class="icon-button ">
												<i class="fa-solid fa-circle-info"></i>
											</button>
									</form>
								</div>	  
							<% } %>
					</div>
				<% } else { %>
					<h2>Nessun ordine trovato</h2>
				<% } %>
			</div>
		</div>
        <%@ include file="footer.jsp" %>  
	</body>
</html>