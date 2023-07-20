<%@page import="it.unisa.planterior.util.DateUtil"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.* "%>
<%@ page import="java.util.*,it.unisa.planterior.model.bean.* "%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<%
	if (session.getAttribute("user") == null || session==null) {
 		response.sendRedirect("authentication.jsp");
	} else {
 		Customer customer = (Customer) session.getAttribute("user");
 		if (!customer.isAdministrator())
 			response.sendRedirect("index.jsp");
	}

	if(request.getParameter("customer-id") == null ){	 
		response.sendRedirect("user-dashboard.jsp");
		return;
	}
	
	long id = Long.parseLong(request.getParameter("customer-id")); 
	Optional<Customer> opt = CustomerDao.getInstance().getById(id);
	
	if (opt.isEmpty()) {
		response.sendRedirect("user-dashboard.jsp");
		return;
	}
	
	Customer customer = opt.get();
%>
 
 
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css">
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
 		<title>Info utente - <%= id %></title>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<div class="wrapper">
			<a href="user-dashboard.jsp">
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span>Indietro</span>
				</button>
			</a>
			<div class="v-box page-content" style="margin-bottom: 40px;">
				<h1>INFORMAZIONI DEL CLIENTE</h1>
        		<div class="v-box table">
					<div class="h-box table-header">
						<div class="table-col h-box justify-center">
							<h3>ID</h3> 
						</div>
						<div class="table-col h-box justify-center mobile-col">
							<h3>NOME</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>COGNOME</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>EMAIL</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>GENERE</h3> 
						</div>
						<div class="table-col h-box justify-center">
							<h3>DATA DI NASCITA</h3> 
						</div>
							
					</div>
					<div class="h-box table-row">
						<h4 class="table-col"><%= customer.getId() %></h4>
						<h4 class="table-col"><%= customer.getName()%></h4>
						<h4 class="table-col"><%= customer.getSurname() %></h4>
						<h4 class="table-col"><%= customer.getEmail() %></h4>
						<h4 class="table-col"><%= customer.getGender() %></h4>
						<h4 class="table-col"><%= DateUtil.formatVisual(customer.getBirthDate()) %></h4>
					</div>
				</div>
			</div>
			<div class="v-box page-content">
				<h1>ORDINI EFFETTUATI</h1>
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
						<% List<Order> ordini = OrderDao.getInstance().getByCliente(id); 
							for (Order ordine : ordini) { %>
						<div class="h-box table-row">
								<h4 class="table-col"><%= ordine.getId() %></h4>
								<h4 class="table-col"><%= ordine.getState().toString() %></h4>
								<h4 class="table-col"><%= ordine.getShippingAddress().getStreet() %>, <%= ordine.getShippingAddress().getHouseNumber() %>, <%= ordine.getShippingAddress().getPostalCode() %></h4>
								<h4 class="table-col"><%= ordine.getTrackingCode().isEmpty() ? "-" : ordine.getTrackingCode().get() %></h4>
								<h4 class="table-col"><%= DateUtil.formatVisual(ordine.getOrderDate())%></h4>
								<form action="order-info.jsp"  method="get" class="table-col">
									<input hidden name="order-id" value="<%= ordine.getId() %>">
									<input hidden name="redirectBy" value="user-info.jsp?customer-id=<%= customer.getId() %>">
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