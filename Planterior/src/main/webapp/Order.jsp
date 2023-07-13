<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.*"%>
<%@page import="it.unisa.planterior.model.dao.*"%>
<%@page import="java.text.SimpleDateFormat"%>



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
    <%@ include file="header.jsp" %>
    <br>
    <br>
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
								<h4 class="table-col"><%= (Math.round(carrello.getQuantita()*product.get().getPrice()* 100.0f) / 100.0f)%>€ </h4>
								
								
								
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
					   <form action="Order.jsp"  method="get">
									
										<button class="big-button"><h6>ORDINI EFFETTUATI</h6></button>
								</form>					 
		                <a href="PaginaUtente.jsp"><button class="big-button"><h6>INFORMAZIONI PERSONALI</h6></button></a>
		            </div>
				<% }else{
					%>
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
								<h3>CODICE TRACKING</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>DATA ORDINE</h3> 
							</div>
							 
							<div class="table-col justify-center">
								<h3>OPZIONI</h3> 
							</div>
							
							
						</div>
						<% for (Order ordine : lista_ordini) { 
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
								<form action="Order.jsp"  method="get">
									
									<input hidden name="id_ordine" value="<%= ordine.getId() %>">
										<button type="submit" class="icon-button table-col ">-
											<i class="fa-solid fa-circle-info"></i>
										</button>
								</form>
								
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
				}
    %>
    	<br><br>
        <%@ include file="footer.jsp" %>  
    </body>
</html>