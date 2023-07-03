<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@ page import="it.unisa.planterior.model.bean.Product"%>
<%@page import=" it.unisa.planterior.model.bean.Carrello"%>
<%@page import=" java.util.*"%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.planterior.model.bean.Customer"%>
 
<link rel="stylesheet" href="asset/style/text-style.css" />
<link rel="stylesheet" href="asset/style/product-style.css" />
<link rel="stylesheet" href="asset/style/number-input-style.css" />

<link rel="stylesheet" href="asset/style/authentication-style.css" />


<link rel="stylesheet" href="asset/style/administrator-style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
<meta charset="ISO-8859-1">
<title>Conferma Pagamento</title>
</head>
<body>

 
<%
Customer customer=null;
HttpSession sessione = request.getSession();
if(sessione.getAttribute("user")!=null){
	 customer = (Customer)sessione.getAttribute("user");
}
else {
	System.out.println("dioc ane");
}
Set<Carrello> carrello= null;
			float Totale = (float)sessione.getAttribute("prezzoTotale");
        	Object listaObj = sessione.getAttribute("carrello");
        	if (listaObj instanceof HashSet<?>) {
        		carrello = (HashSet<Carrello>) listaObj;
            } else {
            	carrello = new HashSet<>();
            }
     // 	sessione.removeAttribute("carrello");
        	
        		
        	%>	
     
       <div class="v-box" id="table">
						<div class="h-box" id="table-header">
							
							<div class="table-col h-box justify-center">
								<h3>NOME</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3>ID</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>quantità</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>prezzo</h3> 
							</div>
							
						</div>
						<% for (Carrello elemento : carrello) { 
							int prodotto= elemento.getProdotto();
							Optional<Product> product = ProductDao.getInstance().getById(prodotto);
							
							 
						%>
						<div class="h-box table-row">
								<h4 class="table-col"><%= product.get().getName() %></h4>
								<h4 class="table-col"><%= product.get().getId() %></h4>
		                       <h4 class="table-col"><%= elemento.getQuantita() %></h4>
		                       <h4 class="table-col"><%= Math.round(product.get().getPrice() * 100.0f) / 100.0f %>$</h4>
									
								</div>
							
							  
						<% } %>
						
						<div class="table-col h-box justify-center">
								<h3>TOTALE SPESO</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3><%= Totale %>$</h3> 
							</div>
					</div>
					


</body>
</html>