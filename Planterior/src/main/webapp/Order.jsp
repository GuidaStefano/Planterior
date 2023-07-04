<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.*"%>
<%@page import="it.unisa.planterior.model.dao.*"%>

<%@page import=" java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css">
        <link rel="stylesheet" href="asset/style/cart-style.css" />
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Ordini Effettuati</title>
    </head>
    <body>
    
    <br><br>
    <%
float prezzoTotale = 0;
HttpSession sessione = request.getSession();
Set<Carrello> carrello= null;

 if (sessione.getAttribute("user")==null ) {
	 request.getRequestDispatcher("authentication.jsp").forward(request, response);
 }
	
 else {
 	Customer customer= (Customer)sessione.getAttribute("user");
 	List<Order> lista_ordini= OrderDao.getInstance().getByCliente(customer.getId());
     
 	if(!lista_ordini.isEmpty()) {
 		
 	%>	
        <%@ include file="header.jsp" %>  
        <br><br>
        <h1 class="cart-title">ORDINI EFFETTUATI</h1>
        <br>
        <div class="v-box" id="table">
						<div class="h-box" id="table-header">
							
							<div class="table-col h-box justify-center">
								<h3>ID</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3>STATE</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>INDIRIZZO DI CONSEGNA</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>CAP</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>DATA DI CONSEGNA</h3> 
							</div>
							
						</div>
						<% for (Order ordine : lista_ordini) { 
							
						%>
						<div class="h-box table-row">
								<h4 class="table-col"><%= ordine.getId() %></h4>
								<h4 class="table-col"><%= ordine.getState() %></h4>
								<h4 class="table-col"><%= ordine.getShippingAddress().getStreet() %>,<%= ordine.getShippingAddress().getHouseNumber() %></h4>
								<h4 class="table-col"><%= ordine.getShippingAddress().getPostalCode() %></h4>
								<h4 class="table-col"><%= ordine.getState() %></h4>
								
							</div>
							  
						<% } %>
						
						
						
					</div>
					<br><br>
					
          
           <a href="index.jsp"><button class="big-button"><h6>RITORNA ALLO SHOPPING</h6></button></a>
           <a href="PaginaUtente.jsp"><button class="big-button"><h6>INFORMAZIONI PERSONALI</h6></button></a>
            
        <%
     }else{
    	 %>
    	      	<h2>Non hai effettuato ordini</h2>
    	 
    	 
    <%  }
        	
        }
    %>
    	<br><br>
        <%@ include file="footer.jsp" %>  
    </body>
</html>