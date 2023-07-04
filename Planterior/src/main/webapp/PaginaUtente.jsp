<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="javax.servlet.http.HttpServletResponse" %>
     
     

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.planterior.model.bean.Customer"%>
<head>
<meta charset="ISO-8859-1">
<title>Pagina Utente</title>
</head>
<body>
<%@ include file="header.jsp" %>
<%
 if (session == null || session.getAttribute("user") == null) {
            // Reindirizza alla pagina "authentication.jsp"
            String redirectURL = "authentication.jsp";
            response.sendRedirect(redirectURL);
        }
        else {
            // La sessione esiste e l'utente è autenticato, mostra il contenuto della pagina corrente
    %>
        <h1>Benvenuto nella tua area personale</h1>
        <a href="Logout"> <button>Logout</button> </a>
                <a href="Order.jsp"> <button>Ordini Effettuati</button> </a>
        
        
    <%
        }
    %>
	




  <%@ include file="footer.jsp" %>
</body>
</html>