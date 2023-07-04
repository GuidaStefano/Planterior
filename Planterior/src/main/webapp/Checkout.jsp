<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@ page import="it.unisa.planterior.model.bean.Product"%>
<%@page import=" it.unisa.planterior.model.bean.Carrello"%>
<%@page import=" java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Checkout</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="asset/style/Checkout.css" />
        <link rel="stylesheet" href="asset/style/text-style.css" />
        
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script src="asset/script/CheckoutCheck.js"></script>
      
 
    </head>
<body>
<%
float prezzoTotale = 0;
HttpSession sessione = request.getSession();
Set<Carrello> carrello= null;

 if (sessione.getAttribute("user")==null   ) {
	
		 request.getRequestDispatcher("authentication.jsp").forward(request, response);
	
     
 	
 } else 
	 if (sessione.getAttribute("carrello")==null   ) {
			
		 request.getRequestDispatcher("index.jsp").forward(request, response);
 } else  {
        	%>
        
	<%@ include file="header.jsp" %>  
        <div class="v-row">
            <h1>INFORMAZIONI PER IL PAGAMENTO</h1>
            <div class="h-row">
             <form  action="CheckoutServlet" method="POST">
                <div class="form-wrapper">
                    <h3>INDIRIZZO DI CONSEGNA</h3>
                    <div class="form">
                    	<div>
                            <label for="username">Email di Fatturazione</label>
                            <input id="EmailLogin" class="text-input" type="text" name="email"/>
                            <span id="ErrorLogin"></span>
                        </div>
                        <div class="form-row">
                         <div>
                                <label for="Via">Via</label>
                                <input class="text-input"type="text" name="via" />
                            </div>
                            <div>
                                <label for="civico">Civico</label>
                                <input id="civico" class="text-input" type="number" name="civico" maxlength="4" />
                                <span hidden id="ErrorCivico">Civico non Valido</span>
                                 
                            </div>
                        </div>
                        
                         <div class="form-row">
                         <div>
                                <label for="cap">Cap</label>
								<input id="cap" class="text-input" type="text" name="cap" maxlength="5" />
								<span hidden id="ErrorCap">Cap non Valido</span>                            </div>
                            <div>
                                <label for="interni">Interno</label>
                                <input  class="text-input" type="number" name="Interno" />
                                 
                            </div>
                        </div>
                   
                     
                    </div>
                </div>
                <div class="form-wrapper">
                    <h3>METODO DI PAGAMENTO</h3><!-- Informazioni della carta -->
                    <div class="form"> 
                    	<div class="radio-input-w">
                                <label for="circuito">Circuito</label>
                                <div class="radio-input">
                                    <div>
                                        <input type="radio" id="VISA" name="circruito" value="VISA" required />
                                        <label for="VISA"><i class="fa-brands fa-cc-visa"></i> </label>
                                    </div>
                                    <div>
                                        <input type="radio" id="MASTERCARD" name="circruito" value="MASTERCARD" />
                                        <label for="MASTERCARD"><i class="fa-brands fa-cc-mastercard"></i></label>
                                    </div>
                                     <div>
                                        <input type="radio" id="AMERICAN_EXPRESS" name="circruito" value="AMERICAN_EXPRESS" />
                                        <label for="AMERICAN_EXPRESS"><i class="fa-brands fa-cc-amex"></i></label>
                                    </div>
                                </div>
                            </div>
                        <div class="form-row">
                            <div>
                                <label for="name">Nome Carta</label>
                                <input class="text-input"type="text" name="nameCard" />
                            </div>
                            <div>
                                <label for="numero">Numero Carta</label> <!-- 1234123412341234 -->
                                <input id="numeroCard" class="text-input" type="text" name="numeroCard"  maxlength="19" />
                                 <span hidden id="ErrorCard">Numero Carta non Valido</span>
                            </div>
                        </div>
                        <div class="form-row">
                            <div>
                                <label for="cvv">CVV</label>
                                <input id="cvv" class="text-input"type="text" name="cvv" />
                                <span hidden id="ErrorCvv">CVV non Valido</span>
                            </div>
                            <div>
                                <label for="numero">Data Di Scadenza</label>
                         	      <input id="Scadenza" class="text-input" type="month" name="birth-month" />
								  

                            </div>
                        </div>
                        <div class="form-checkbox">
                            <input type="checkbox" name="save-session"/>
                            <p>Ho letto ed accetto <a id="terms-anchor">Termini e Condizioni</a></p>
                        </div>
                        <input id="submit" class="submit-btn" name="action" type="submit" id="registrati" value="CONFERMA_PAGAMENTO" />
                  		</div> 
                   	</div>
                    </form>
                </div>
            </div>
			<% } %>
 
        <%@ include file="footer.jsp" %> 

       
         
</body>
</html>