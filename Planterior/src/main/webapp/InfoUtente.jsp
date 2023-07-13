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
Set<Order> lista_ordine = OrderDao.getInstance().getAll(); 
Map<Long, Integer> conteggioPerCliente = new HashMap<>();

for (Order order : lista_ordine) {
    long cliente = order.getCustomer().getId();
    
    // Incrementa il conteggio per il cliente corrente
    conteggioPerCliente.put(cliente, conteggioPerCliente.getOrDefault(cliente, 0) + 1);
}
long id_cliente=0;
if(request.getParameter("id_utente")==null ){
			 
	response.sendRedirect("Ordini_Complessivi.jsp");
}else{
	 
	id_cliente = Long.parseLong(request.getParameter("id_utente")); 
	System.out.println("id_utente="+id_cliente);

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
 		<title>Info Utente</title>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<br><br>
				<!-- SEZIONI ORDINI PER CLIENTE -->
	 
	<h1 class="cart-title">INFORMAZIONI DEL CLIENTE</h1>
        <br>
        <div    class="v-box">
						<div class="h-box" id="table-header">
							
							<div class="table-col h-box justify-center">
								<h3>ID CLIENTE</h3> 
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
								<h3>DATA DI COMPLEANNO</h3> 
							</div>
							
						</div>
						<%   
						 Optional<Customer> customer=(Optional<Customer>)CustomerDao.getInstance().getById(id_cliente);
							
						%>
						<div class="h-box table-row">
								<h4 class="table-col"><%= customer.get().getId() %></h4>
								<h4 class="table-col"><%= customer.get().getName()%></h4>
								<h4 class="table-col"><%= customer.get().getSurname() %></h4>
								<h4 class="table-col"><%= customer.get().getEmail() %></h4>
								<h4 class="table-col"><%= customer.get().getGender() %></h4>
								<h4 class="table-col"><%= customer.get().getBirthDate() %></h4>
								
							</div>
					 
							  
						
					
						
						
					</div>
					<%if(!(request.getParameter("id_ordine")==null)) {
					int id_ordine=Integer.parseInt(request.getParameter("id_ordine"));
					
					%>
				
					<div   id="ordine">
						<h1 class="cart-title"> ORDINE <%= id_ordine %></h1>
        
				        <div    class="v-box">
										<div class="h-box" id="table-header">
											
											<div class="table-col h-box justify-center">
												<h3>ID PRODOTTO</h3> 
											</div>
											<div class="table-col h-box justify-center mobile-col">
												<h3>NOME PRODOTTO</h3> 
											</div>
											<div class="table-col h-box justify-center">
												<h3>QUANTITA'</h3> 
											</div>
											<div class="table-col h-box justify-center">
												<h3>PREZZO</h3> 
											</div>
											
											
						</div>
						<% List<Carrello> ordine=ComposizioneDao.getInstance().getAllByOrder(id_ordine); 
						float prezzoTotale = 0;
						float prezzoProdotto=0;
						
						//if(!ordini.isEmpty()){
						for (Carrello carrello : ordine) { 
						  Optional<Product> product=ProductDao.getInstance().getById(carrello.getProdotto());
						    prezzoProdotto=carrello.getQuantita()*product.get().getPrice();
							prezzoTotale = prezzoTotale +prezzoProdotto;
							prezzoTotale= Math.round(prezzoTotale * 100.0f) / 100.0f;
							
						%>
						<div class="h-box table-row">
								<h4 class="table-col"><%= product.get().getId() %></h4>
								<h4 class="table-col"><%= product.get().getName() %></h4>
								<h4 class="table-col"><%= carrello.getQuantita()%></h4>
								<h4 class="table-col"><%= (Math.round(carrello.getQuantita()*product.get().getPrice()* 100.0f) / 100.0f) %></h4>
								
								
								
							</div>
					 
							  
						<%//} 
					} 
					%>	
					<div class="total-price">
	                    <h5>PREZZO TOTALE</h5>
	                    <h3 class="prezzoTotale"><%= prezzoTotale %>$</h3>
                </div>
					</div>
					
						
						
					</div>
					<div class="buttons">
					   <form action="InfoUtente.jsp"  method="get">
									<input hidden name="id_utente" value="<%= id_cliente %>">
										<button class="big-button"><h6>ORDINI CLIENTE</h6></button>
								</form>					 
		                <a href="Ordini_Complessivi.jsp"><button class="big-button"><h6>ORDINI COMPLESSIVI</h6></button></a>
		            </div>
				<% }else{
					%>
		<div id="ordini">
		<h1 class="cart-title">ORDINI EFFETTUATI DAL CLIENTE</h1>
        <br>
        <div    class="v-box">
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
								<h3>CODICE TRACKING</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>DATA ORDINE</h3> 
							</div>
							 
							<div class="table-col justify-center">
								<h3>OPZIONI</h3> 
							</div>
							
						</div>
						<% List<Order> ordini=OrderDao.getInstance().getByCliente(id_cliente); 
						System.out.println(id_cliente);
						System.out.println(ordini.isEmpty()+"la lunghezza è:"+ordini.size());
						//if(!ordini.isEmpty()){
						for (Order ordine : ordini) { 
						    System.out.println(ordine.getId());
						    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			        	 	 String formattedDate = dateFormat.format(ordine.getOrderDate());
						%>
						<div class="h-box table-row">
								<h4 class="table-col"><%= ordine.getId() %></h4>
								<h4 class="table-col"><%= ordine.getState() %></h4>
								<h4 class="table-col"><%= ordine.getShippingAddress().getStreet() %>,<%= ordine.getShippingAddress().getHouseNumber() %></h4>
								<h4 class="table-col"><%= ordine.getShippingAddress().getPostalCode() %></h4>
								<h4 class="table-col"><%= ordine.getTrackingCode() %></h4>
								<h4 class="table-col"><%=formattedDate%></h4>
								<form action="InfoUtente.jsp"  method="get">
									<input hidden name="id_utente" value="<%= id_cliente %>">
									<input hidden name="id_ordine" value="<%= ordine.getId() %>">
										<button type="submit" class="icon-button table-col ">-
											<i class="fa-solid fa-circle-info"></i>
										</button>
								</form>
								
							</div>
					 
							  
						<%//} 
					} 
					%>
				</div>
				</div>
				<div class="buttons">
                			<a href="administrator.jsp"><button class="big-button"><h6>RITORNA AI PRODOTTI</h6></button></a>
                			<a href="Ordini_Complessivi.jsp"><button class="big-button"><h6>ORDINI COMPLESSIVI</h6></button></a>
            		</div>	
				<% }
					%> 
 

	
	<br><br>
        <%@ include file="footer.jsp" %>  
	</body>
</html>