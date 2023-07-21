<%@page import="it.unisa.planterior.util.PathUtil"%>
<%@page import="it.unisa.planterior.model.bean.Product.Category"%>
<%@page import="it.unisa.planterior.model.bean.Product.Subcategory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8"%>
    <%@page import="java.io.IOException"%>
<%@page import="it.unisa.planterior.model.bean.*"%>
<%@page import="it.unisa.planterior.model.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="java.util.stream.Collectors"%>

<%
	List<Product> products = new ArrayList<>();
	String label = "CATALOGO";
	
	if (request.getParameter("search") != null) {
		String search = request.getParameter("search");
		label = "Risultati ricerca per \'" + search + "\'";
		products = ProductDao.getInstance().getAllByLikey("%" + search + "%");
	} else {
		if(request.getParameter("category") == null && request.getParameter("main-category") == null) {
			products = new ArrayList<>(ProductDao.getInstance().getAll());
		} else {
			String subcategoryStr = request.getParameter("category");
			if (subcategoryStr != null) {
				products = ProductDao.getInstance().getAllByCategory(subcategoryStr);
				label = subcategoryStr.replace("_", " ").toUpperCase();
			} else if (request.getParameter("main-category") != null) {
				String categoryStr = request.getParameter("main-category");
				Category category = Category.valueOf(categoryStr);
				label = categoryStr.replace("_", " ").toUpperCase();
				
				for (Subcategory subcategory : category.getSubcategories()) 
					products.addAll(ProductDao.getInstance().getAllByCategory(subcategory.name()));
			}
		}
	}
	
	products = products.stream().filter(Product::isListed).collect(Collectors.toList());
%>

<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=yes">
    <link rel="stylesheet" href="asset/style/catalogo-style.css" />
    <link rel="stylesheet" href="asset/style/header-style.css" />
    <title>Catalogo</title>

</head>
<body>
      <%@ include file="header.jsp" %>
         <div class="container">
             <div class="row">
                 <h3><%= label %></h3>
             </div>
             <div class="row">
                 <div class="product-container">
                  <% if(products.isEmpty()) { %>
                  		<h3>Non abbiamo disponibilità di questa categoria</h3>
                  <% } else {
					for (Product product : products) { %>
						<a href="product.jsp?id=<%= product.getId() %>">
							 <div class="card">
                         		<img height="180" src="<%= PathUtil.getMainImagePath(product.getId()) %>" alt="">
                         		<div class="text-box">
                             		<h3><%= product.getName() %></h3>
                             		<h6><%= Math.round(product.getPrice() * 100.0f) / 100.0f%>$</h6>
                         		</div>
                     		</div>
                        </a>
                     <%} 
					}%>
                 </div>
             </div>
         </div>
		<%@include file="footer.jsp" %> 
     </body>
</html>