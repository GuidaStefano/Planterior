 

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Collection<?> prodotti = (Collection<?>) request.getAttribute("products");
	if(prodotti == null) {
		response.sendRedirect("./CarrelloServlet");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.planterior.model.bean.Product"%>

<head>
<meta charset="UTF-8">
<title>Inserisci il tuo primo prodotto</title>
</head>
<body>


<h2>Products</h2>
	<a href="CarrelloServlet">List</a>
	<table border="1">
		<tr>
			<th>Code <a href="CarrelloServlet?sort=code">Sort</a></th>
			<th>Name <a href="CarrelloServlet?sort=name">Sort</a></th>
			<th>Description <a href="CarrelloServlet?sort=description">Sort</a></th>
			<th>Action</th>
		</tr>
		<%
		if (prodotti != null && prodotti.size() != 0) {
				Iterator<?> it = prodotti.iterator();
				while (it.hasNext()) {
					Product prodotto1 = (Product) it.next();
		%>
		<tr>
			<td><%=prodotto1.getId()%></td>
			<td><%=prodotto1.getName()%></td>
			<td><%=prodotto1.getMinimalDescription()%></td>
			<td><a href="CarrelloServlet?action=insertCarrello&id=<%=prodotto1.getId()%>">Aggiungi al Carrello</a><br>
				<a href="CarrelloServlet?action=read&id=<%=prodotto1.getId()%>">Details</a></td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">No products available</td>
		</tr>
		<%
			}
		%>
	</table>
	

	
</body>
</html>