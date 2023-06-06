<%@page import="java.io.IOException"%>
<%@page import="it.unisa.planterior.model.bean.Product"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
		<head>
			<title>Planterior</title>
		</head>
		<body>
			<%@ include file="header.jsp" %>  
			<%!
			public String generateProductCard(Product product) {
				StringBuilder builder = new StringBuilder();
				builder.append("<div>");
				builder.append(product.getName());
				builder.append(product.getBasePrice());
				builder.append("</div>");
				return builder.toString();
			}
			%>
			<% 
			for (Product product : ProductDao.getInstance().getAll()) {
				try {
					out.append(generateProductCard(product));
				} catch(IOException ignored) {	}
			}; 
			%>
		</body>
</html>