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
Set<Order> lista_ordine = OrderDao.getInstance().getAll(); 
Map<Long, Integer> conteggioPerCliente = new HashMap<>();

for (Order order : lista_ordine) {
    long cliente = order.getCustomer().getId();
    
    // Incrementa il conteggio per il cliente corrente
    conteggioPerCliente.put(cliente, conteggioPerCliente.getOrDefault(cliente, 0) + 1);
}
 
%>
 
 


<!DOCTYPE html>
<html>
	<head>
		  <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css">
        <link rel="stylesheet" href="asset/style/cart-style.css" />
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
         
 		<title>Ordini Complessivi</title>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<div id="ordini_clienti" class="wrapper">
			<div class="v-box" id="page-content">
			<h1>ORDINI COMPLESSIVI</h1>
		<% if(!conteggioPerCliente.isEmpty()) { %>
	  		<div class="v-box" id="table">
						<div class="h-box" id="table-header">
							<div class="table-col h-box justify-center">
								<h3>id</h3> 
								 
							</div>
							
							<div class="table-col h-box justify-center">
								<h3>Numero Ordini</h3> 
								 
							</div>
							
							<div class="table-col justify-center">
								<h3>opzioni</h3> 
							</div>
						</div>
						<%  
							// Stampa il conteggio per ciascun cliente
					for (Map.Entry<Long, Integer> entry : conteggioPerCliente.entrySet()) {
					    long cliente = entry.getKey();
					    int conteggio = entry.getValue();
					    
					    System.out.println("Cliente: " + cliente + ", Numero ordini: " + conteggio);
   						 %>
							<div class="h-box table-row">
								<h4 class="table-col"><%= cliente %></h4>
								<h4 class="table-col"><%= conteggio %></h4>
								<!--value="ordini"-->
								<form action="InfoUtente.jsp" method="get"> 
									<input hidden name="id_utente" value="<%= cliente %>">
									<button  type="submit" class="icon-button table-col">
										<i class="fa-solid fa-circle-info"></i>
									</button>
									
								</form>
								
							</div>
						<% } %>
					</div>
					<div class="buttons">
                			<a href="administrator.jsp"><button class="big-button"><h6>RITORNA AI PRODOTTI</h6></button></a>
            		</div>
				
				<% } else { %>
					 
						<h2>Non sono presenti ordini.</h2>
						 
				<% } %>
					</div>
		</div>	
				 
        <%@ include file="footer.jsp" %>  
	</body>
</html>