<%@page import="it.unisa.planterior.model.dao.PaymentMethodDao"%>
<%@page import="it.unisa.planterior.model.bean.PaymentMethod"%>
<%@page import="it.unisa.planterior.model.dao.ShippingAddressDao"%>
<%@page import="it.unisa.planterior.model.bean.ShippingAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@ page import="it.unisa.planterior.model.bean.Product"%>
<%@page import=" java.util.*"%>

<%
	if (session.getAttribute("user") == null || session.getAttribute("cart") == null) {
		response.sendRedirect("index.jsp");
		return;
	}

	Customer customer = (Customer) session.getAttribute("user");
	
	@SuppressWarnings("unchecked")
	Map<Long, Short> cart = (Map<Long, Short>) session.getAttribute("cart");
	
	if (cart.isEmpty()) {
		response.sendRedirect("index.jsp");
		return;
	}
	
	List<ShippingAddress> addresses = ShippingAddressDao.getInstance().getByCustomer(customer);
	List<PaymentMethod> paymentMethods = PaymentMethodDao.getInstance().getByCustomer(customer);
%>

<%!
	public String encodeCardNumber(String cardNumber) {
		return "**** **** **** " + cardNumber.substring(12, 16);
	}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="asset/style/authentication-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css" />
        <link rel="stylesheet" href="asset/style/text-style.css" />
        
 
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
		<title>Checkout</title>
    </head>
	<body>   
	<%@ include file="header.jsp" %>  
    	<form class="v-row" action="checkout" method="POST">
    		<a href="cart.jsp">
				<button type="button" class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span id="back-label">Indietro</span>
				</button>
			</a>
            <h1>CHECKOUT</h1>
            <div class="h-row">
                <div class="form-wrapper">
                    <h3>INDIRIZZO DI SPEDIZIONE</h3>
                    <div class="form" style="row-gap: 30px;">
                    	<input type="radio" name="address" required hidden>
                    	<% for(ShippingAddress address : addresses) { %>
                    		<div class="h-box" style="justify-content: start; column-gap: 12px;">
                    			<input type="radio" name="address" value="<%= address.getId() %>" required>
                    			<h4><%= address.getStreet() %>, <%=address.getHouseNumber() %>, <%= address.getPostalCode() %></h4>
                    		</div>
                    	<% } %>
                    	<a href="add-address.jsp?redirectBy=checkout.jsp">
                    		<button type="button" class="big-button static-btn"><h6>NUOVO INDIRIZZO</h6></button>
                    	</a>
                    </div>
                </div>
                <div class="form-wrapper">
                    <h3>METODO DI PAGAMENTO</h3>
                    <div class="form" style="row-gap: 30px;">
                   	 <input type="radio" name="payment-method" required hidden>
                    	<% for(PaymentMethod method : paymentMethods) { %>
                    		<div class="h-box" style="justify-content: start; column-gap: 12px;">
                    			<input type="radio" name="payment-method" value="<%= method.getId()%>">
                    			<h4><%= encodeCardNumber(method.getCardNumber()) %>, <%= method.getCardCircuit().toString().toUpperCase() %>, <%= method.getOwner() %></h4>
                    		</div>
                    	<% } %>
                    	<a href="add-payment-method.jsp?redirectBy=checkout.jsp">
                    		<button type="button" class="big-button static-btn"><h6>NUOVO METODO DI PAGAMENTO</h6></button>
                    	</a>
                    </div>
                </div>
            </div>
            <div class="h-box" style="margin-top: 30px; justify-content: center;">
            	<button type="submit" class="big-button"><h6 style="font-size: 13px;">CONFERMA ORDINE</h6></button>
            </div>
        </form>
	<%@ include file="footer.jsp" %> 
</body>
</html>