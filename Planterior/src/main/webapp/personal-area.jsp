<%@page import="it.unisa.planterior.util.DateUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
 
<!DOCTYPE html>
<html lang="it">
	<head>
		<link rel="stylesheet" href="asset/style/administrator-style.css">
		<link rel="stylesheet" href="asset/style/add-product-style.css">
		<link rel="stylesheet" href="asset/style/text-style.css">
		<link rel="stylesheet" href="asset/style/number-input-style.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha384-NXgwF8Kv9SSAr+jemKKcbvQsz+teULH/a5UNJvZc6kP47hZgl62M1vGnw6gHQhb1" crossorigin="anonymous"></script>
        <script src="asset/script/PaginaUtente.js"></script>
		<title>Area personale</title>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<%
		
			if (session == null || session.getAttribute("user") == null) {
	            // Reindirizza alla pagina "authentication.jsp"
	            response.sendRedirect("authentication.jsp");
	            return;
			}
		
			Customer user = (Customer) session.getAttribute("user");
    	%>
		<div class="wrapper">
			<a href="index.jsp">
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span>Indietro</span>
				</button>
			</a>
        	<h1 style="margin-bottom: 8px;">AREA PERSONALE</h1>
        	<div class="buttons">
	         	<% if(user.isAdministrator()){ %>
	         		<a href="administrator.jsp"> <button class="big-button static-btn add-button"><h6>MODIFICA CATALOGO</h6></button> </a>
	         		<a href="user-dashboard.jsp"> <button class="big-button static-btn add-button"><h6>DASHBOARD UTENTI</h6></button> </a>
	         		<a href="order-dashboard.jsp"> <button class="big-button static-btn add-button"><h6>DASHBOARD ORDINI</h6></button> </a>
	         	<% } else { %>
	         		<a href="orders-history.jsp"> <button class="big-button static-btn add-button"><h6>STORICO ORDINI</h6></button> </a>
	         		<a href="payment-methods.jsp"> <button class="big-button static-btn add-button"><h6>METODI DI PAGAMENTO</h6></button> </a>
	         		<a href="addresses.jsp"> <button class="big-button static-btn add-button"><h6>INDIRIZZI</h6></button> </a>
	         	<%} %>
        	</div>
        	<br> <br>
			<div class="v-box" id="page-content">
				<h1>Modifica dati</h1>
				<form action="RegistrationServlet" method="POST" > 
					<div class="h-box column-gap">
						<div class="v-box row-gap">
							<div class="v-box form-element">
	                        	<label for="name">Nome</label>
	                            <input class="text-input" type="text" name="name" value=<%= user.getName() %>>
	                        </div>
	                        <div class="v-box form-element">
	                        	<label for="surname">Cognome</label>
	                            <input class="text-input" type="text" name="surname" value=<%= user.getSurname() %>>
	                        </div>
	                        <div class="v-box form-element">
	                        	<label  for="email">Email</label>
	                            <input id="email" class="text-input" type="text" name="email" value=<%= user.getEmail() %>>
	                            <p class="error-log" id="Error"></p>
	                        </div>
						</div>
						<div class="v-box row-gap">
							<div class="h-box column-gap" id="second-column">
								<div class="v-box row-gap">
										 <div class="v-box form-element">
					                       		<label for="Gender">Sesso</label>
					                          	<select class="text-input" name="gender">
													<option value="<%= user.getGender() %>"><%= user.getGender() %></option>
													<%
														switch(user.getGender()){
															case M:%>					                          		
					      										<option value="F">F</option>
					      									<% break;
				      										case F:%>
				      											<option value="M">M</option>
				      										<% break;
				      									} 
				      								%>	
					                          	</select>
											</div>
										 <div class="v-box form-element">
										    <label for="date">Data di nascita</label>
  											<input  class="text-input" type="date" name="birth-date" max="2006-12-31" value="<%=DateUtil.formatSystem(user.getBirthDate())%>">		
										</div>

			                        <div class="v-box form-element">
			                        	<label for="password">Password</label>
			                            <input class="text-input" type="password" name="password" value=<%= user.getPassword() %>>
	                        		</div>
			                	</div>
							</div>	 
							<div class="h-box" id="last-row">
			                    <input hidden name="action" value="edit">
								<button id="submit" name="action" value="edit" class="big-button static-btn add-button">
									<h6>CONFERMA MODIFICHE</h6>
								</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	




  <%@ include file="footer.jsp" %>
</body>
</html>