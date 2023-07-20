<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.* "%>
<%@ page import="java.util.*,it.unisa.planterior.model.bean.* "%>

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
<%
	Set<Customer> customers = CustomerDao.getInstance().getAll();
	Map<Long, Integer> ordersAmount = new HashMap<>();
	for (Customer customer : customers) {
		ordersAmount.put(customer.getId(), OrderDao.getInstance().getByCliente(customer.getId()).size());
	}
	
	String sortParam = request.getParameter("sortBy");
	if (sortParam != null) {
		customers = customers.stream().sorted((x, y) -> {
			switch (sortParam.toLowerCase()) {
				case "id":
					return Long.compare(x.getId(), y.getId());
				case "email":
					return x.getEmail().toLowerCase().compareTo(y.getEmail().toLowerCase());
				case "orders-amount":
					return Integer.compare(ordersAmount.get(x.getId()), ordersAmount.get(y.getId()));
				default:
					return 0;
			}
		}).collect(Collectors.toCollection(LinkedHashSet::new));
	}
	
	String sortOrder = request.getParameter("sortOrder");
	if (sortOrder != null) {
		if (sortOrder.equalsIgnoreCase("desc")) {
			List<Customer> list = new ArrayList<>(customers);
			Collections.reverse(list);
			customers = new LinkedHashSet<>(list);
		}
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha384-NXgwF8Kv9SSAr+jemKKcbvQsz+teULH/a5UNJvZc6kP47hZgl62M1vGnw6gHQhb1" crossorigin="anonymous"></script>
         
 		<title>Dashboard utenti</title>
 		<script>
 			$(document).ready(function() {
 				var searchDiv = $("#search-div");
 				var searchInput = $("#search-input");
 				$("#show-input-btn").on("click", function() {
 					if (searchDiv.css("display") == "none") {
 						searchDiv.css("display", "flex");
 					} else {
 						searchDiv.css("display", "none");
 					}
 				});
 				
 				searchInput.on('input', function() {
 					var params = {
 						search: $(this).val()
 					};
 					ajaxCall(params);
 				});
 			});
 			
 			function ajaxCall(params) {
 				$.ajax({
 					url: 'get-customers',
 					method: 'GET',
 					data: params,
 					success: function(response) {
 						$(".table-row").hide();
 						var customers = response.customers;
 						for (var i = 0; i < customers.length; i++) {
 							$("#" + customers[i]).show();
 						}
 					},
 					error: function(xhr, status, error) {
 						console.log(error);
 					}	
 				});
 			} 
 		</script>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<div id="ordini_clienti" class="wrapper">
			<a href="personal-area.jsp">
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span>Indietro</span>
				</button>
			</a>
			<div class="v-box" id="page-content">
			<div class="h-box" style="justify-content: start; column-gap: 15px;">
				<h1>DASHBOARD UTENTI</h1>
				<% if(!customers.isEmpty()) { %>
					<button id="show-input-btn" class="icon-button"><i class="fa-solid fa-magnifying-glass fa-lg"></i></button>
				<% } %>
			</div>
		<% if(!customers.isEmpty()) { %>
			<div class="v-box" id="search-div" style="display: none;" >
				<label>Ricerca per email</label>
				<input id="search-input" style="width: 350px;" type="text" class="text-input" />
			</div>
	  		<div class="v-box" id="table">
						<div class="h-box" id="table-header">
							<div class="table-col h-box justify-center">
								<h3>id</h3> 
								<form action="user-dashboard.jsp" class="v-box">
									<input type="hidden" name="sortBy" value="id" />
									<button name="sortOrder" value="asc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-up"></i>
									</button>
									<button name="sortOrder" value="desc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-down"></i>
									</button>
								</form>
							</div>
							<div class="table-col h-box justify-center">
								<h3>email</h3> 
								<form action="user-dashboard.jsp" class="v-box">
									<input type="hidden" name="sortBy" value="email" />
									<button name="sortOrder" value="asc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-up"></i>
									</button>
									<button name="sortOrder" value="desc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-down"></i>
									</button>
								</form>
							</div>
							<div class="table-col h-box justify-center">
								<h3>numero ordini</h3> 
								<form action="user-dashboard.jsp" class="v-box">
									<input type="hidden" name="sortBy" value="orders-amount" />
									<button name="sortOrder" value="asc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-up"></i>
									</button>
									<button name="sortOrder" value="desc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-down"></i>
									</button>
								</form>
							</div>
							<div class="table-col justify-center">
								<h3>opzioni</h3> 
							</div>
						</div>
						<%  for (Customer customer : customers) { %>
							<div class="h-box table-row" id="<%= customer.getId() %>">
								<h4 class="table-col"><%= customer.getId() %></h4>
								<h4 class="table-col"><%= customer.getEmail() %></h4>
								<h4 class="table-col"><%= ordersAmount.get(customer.getId()) %></h4>
								<!--value="ordini"-->
								<form action="user-info.jsp" method="get" class="h-box table-col justify-center"> 
									<input hidden name="customer-id" value="<%= customer.getId() %>">
									<button  type="submit" class="icon-button no-padding">
										<i class="fa-solid fa-circle-info"></i>
									</button>
									
								</form>
								
							</div>
						<% } %>
					</div>
				
				<% } else { %>
					 
						<h2>Non ci sono utenti registrati.</h2>
						 
				<% } %>
					</div>
		</div>	
				 
        <%@ include file="footer.jsp" %>  
	</body>
</html>