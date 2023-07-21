<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@ page import="java.util.*,it.unisa.planterior.model.bean.Product"%>

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
	Set<Product> products = ProductDao.getInstance().getAll(); 
	
	String sortParam = request.getParameter("sortBy");
	if (sortParam != null) {
		products = products.stream().sorted((x, y) -> {
			switch (sortParam.toLowerCase()) {
				case "id":
					return Long.compare(x.getId(), y.getId());
				case "name":
					return x.getName().toLowerCase().compareTo(y.getName().toLowerCase());
				case "description":
					return x.getMinimalDescription().compareTo(y.getMinimalDescription());
				case "amount":
					return Short.compare(x.getAvailableAmount(), y.getAvailableAmount());
				case "price":
					return Float.compare(x.getPrice(), y.getPrice());
				default:
					return 0;
			}
		}).collect(Collectors.toCollection(LinkedHashSet::new));
	}
	
	String sortOrder = request.getParameter("sortOrder");
	if (sortOrder != null) {
		if (sortOrder.equalsIgnoreCase("desc")) {
			List<Product> list = new ArrayList<>(products);
			Collections.reverse(list);
			products = new LinkedHashSet<>(list);
		}
	}
%>

<!DOCTYPE html>
<html lang="it">
	<head>
		<link rel="stylesheet" href="asset/style/administrator-style.css">
		<link rel="stylesheet" href="asset/style/text-style.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha384-NXgwF8Kv9SSAr+jemKKcbvQsz+teULH/a5UNJvZc6kP47hZgl62M1vGnw6gHQhb1" crossorigin="anonymous"></script>
		<title>Modifica catalogo</title>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<div class="wrapper">
			<a href="personal-area.jsp">
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span id="back-label">Indietro</span>
				</button>
			</a>
			<div class="v-box" id="page-content">
				<h1>MODIFICA CATALOGO</h1>
				<% if(!products.isEmpty()) { %>
					<div class="v-box" id="table">
						<div class="h-box" id="table-header">
							<div class="table-col h-box justify-center">
								<h3>id</h3> 
								<form action="administrator.jsp" class="v-box">
									<input type="hidden" name="sortBy" value="id" />
									<button name="sortOrder" value="asc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-up"></i>
									</button>
									<button name="sortOrder" value="desc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-down"></i>
									</button>
								</form>
							</div>
							<div class="table-col h-box justify-center mobile-col-3">
								<h3>nome</h3> 
								<form action="administrator.jsp" class="v-box">
									<input type="hidden" name="sortBy" value="name" />
									<button name="sortOrder" value="asc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-up"></i>
									</button>
									<button name="sortOrder" value="desc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-down"></i>
									</button>
								</form>
							</div>
							<div class="table-col h-box justify-center mobile-col-1">
								<h3>descrizione</h3> 
								<form action="administrator.jsp" class="v-box">
									<input type="hidden" name="sortBy" value="description" />
									<button name="sortOrder" value="asc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-up"></i>
									</button>
									<button name="sortOrder" value="desc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-down"></i>
									</button>
								</form>
							</div>
							<div class="table-col h-box justify-center">
								<h3>quantità</h3> 
								<form action="administrator.jsp" class="v-box">
									<input type="hidden" name="sortBy" value="amount" />
									<button name="sortOrder" value="asc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-up"></i>
									</button>
									<button name="sortOrder" value="desc" class="icon-button caret-btn no-padding">
										<i class="fa-sharp fa-solid fa-caret-down"></i>
									</button>
								</form>
							</div>
							<div class="table-col h-box justify-center mobile-col-2">
								<h3>prezzo</h3> 
								<form action="administrator.jsp" class="v-box">
									<input type="hidden" name="sortBy" value="price" />
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
						<% for (Product product : products) { %>
							<div class="h-box table-row">
								<h4 class="table-col"><%= product.getId() %></h4>
								<h4 class="table-col mobile-col-3"><%= product.getName() %></h4>
								<h4 class="table-col mobile-col-1"><%= product.getMinimalDescription() %></h4>
								<h4 class="table-col"><%= product.getAvailableAmount() %></h4>
								<h4 class="table-col mobile-col-2"><%= product.getPrice() %></h4>
								<form action="edit-catalog" method="POST" class="h-box table-col justify-center" style="column-gap: 25px;">
									<input type="hidden" name="id" value=<%= product.getId() %> />
									<button type="submit" name="action" value="delete" class="icon-button no-padding">
										<i class="fa-solid fa-trash"></i> 
									</button>
									<button formaction="edit-product.jsp" formmethod="GET" type="submit" class="icon-button no-padding">
										<i class="fa-solid fa-pen-to-square"></i>
									</button>
								</form>
							</div>
						<% } %>
					</div>
					
					<a href="add-product.jsp">
						<button type="submit" name="action" value="insert" class="big-button static-btn" id="fixed-btn">
						<i class="fa-sharp fa-light fa-plus fa-xxl" style="color: white; margin-top: 3px; font-size: 1.6em;"></i>
					</button></a>
				<% } else { %>
					<form action="add-product.jsp" id="no-products-box" class="v-box">
						<h2>Non sono presenti prodotti.</h2>
						<button type="submit" class="big-button static-btn"><h6>Inserisci il primo prodotto</h6></button>
					</form>
				<% } %>
			</div>
		</div>
	
        <%@ include file="footer.jsp" %> 
	</body>
</html>