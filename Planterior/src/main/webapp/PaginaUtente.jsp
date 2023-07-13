<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="javax.servlet.http.HttpServletResponse" %>
     
     

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.text.SimpleDateFormat,java.util.*,it.unisa.planterior.model.bean.Customer"%>
<head>
	<link rel="stylesheet" href="asset/style/administrator-style.css">
		<link rel="stylesheet" href="asset/style/add-product-style.css">
		<link rel="stylesheet" href="asset/style/text-style.css">
		<link rel="stylesheet" href="asset/style/number-input-style.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
        <script src="asset/script/PaginaUtente.js"></script>
		
		
<meta charset="ISO-8859-1">
<title>Pagina Utente</title>
</head>
<body>
<%@ include file="header.jsp" %>
<%
String formattedDate=null;
Customer customer=null;
 if (session == null || session.getAttribute("user") == null) {
            // Reindirizza alla pagina "authentication.jsp"
            String redirectURL = "authentication.jsp";
            response.sendRedirect(redirectURL);
        }
        else {
        	 customer = (Customer)session.getAttribute("user");
        	 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        	 	  formattedDate = dateFormat.format(customer.getBirthDate());

        	    // Stampare la data formattata
        	    System.out.println(formattedDate);
            // La sessione esiste e l'utente è autenticato, mostra il contenuto della pagina corrente
        }
 	 
    %>
    <br><br>
        <h1>Benvenuto nella tua area personale</h1>
        <br><br>
        <div class="buttons">
	        <a href="Logout"> <button class="big-button static-btn add-button"><h6>LOGOUT</h6></button> </a>
	         <%if(customer==null){%>
	          
	        	   
	        <%  }
	         		
	         if(customer.isAdministrator()){ %>
	         		 <a href="administrator.jsp"> <button class="big-button static-btn add-button"><h6>PRODOTTI NEGOZIO</h6></button> </a>
	         		 <a href="Ordini_Complessivi.jsp"> <button class="big-button static-btn add-button"><h6>ORDINI COMPLESSIVI</h6></button> </a>
	         <%}else{ %>
	         <a href="Order.jsp"> <button class="big-button static-btn add-button"><h6>ORDINI EFFETTUATI</h6></button> </a>
	         <%} %>
        </div>
        
    
    
		<div class="wrapper">
			<div class="v-box" id="page-content">
				<h1>AREA UTENTE</h1>
				<form action="RegistrationServlet" method="POST" > 
					<div class="h-box column-gap">
						<div class="v-box row-gap">
							<div class="v-box form-element">
	                        	<label for="name">Nome</label>
	                            <input class="text-input" type="text" name="name" value=<%= customer.getName() %>>
	                        </div>
	                        <div class="v-box form-element">
	                        	<label for="surname">Surname</label>
	                            <input class="text-input" type="text" name="surname" value=<%= customer.getSurname() %>>
	                        </div>
	                        <div class="v-box form-element">
	                        	<label  for="email">email</label>
	                            <input id="email" class="text-input" type="text" name="email" value=<%= customer.getEmail() %>>
	                            <span id="Error"></span>
	                        </div>
	                        
							 
						</div>
						<div class="v-box row-gap">
							<div class="h-box column-gap" id="second-column">
								<div class="v-box row-gap">
										 <div class="v-box form-element">
					                       		<label for="Gender">Sesso</label>
					                          	<select class="text-input" name="gender">
													<option value="<%= customer.getGender() %>"><%= customer.getGender() %></option>
													<%
														
														switch(customer.getGender()){
															case M:%>					                          		
					      										<option value="F">F</option>
					      									<% break;
				      										case F:%>
				      											<option value="M">M</option>
				      										<%break;
				      										} %>
				      								<option value="A volte">A volte</option>	
					                          	</select>
											</div>
										 <div class="v-box form-element">
										    <label for="date">Data</label>
  											<input  class="text-input" type="date" name="birth-date" value="<%=formattedDate%>">		
										</div>

			                        <div class="v-box form-element">
			                        	<label for="password">Password</label>
			                            <input class="text-input" type="password" name="password" value=<%= customer.getPassword() %>>
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