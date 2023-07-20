<%@page import="it.unisa.planterior.model.bean.Product.Subcategory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8"%>
    <%@page import="java.io.IOException"%>
<%@page import="it.unisa.planterior.model.bean.*"%>
<%@page import="it.unisa.planterior.model.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="java.util.stream.Collectors"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=yes">
    <link rel="stylesheet" href="asset/style/catalogo-style.css" />
    <link rel="stylesheet" href="asset/style/header-style.css" />
     <title> Catalogo</title>

</head>
<body>
<%
	if(request.getParameter("categoria") == null) {
		response.sendRedirect("index.jsp");
		return;
	}

	String categoryStr = request.getParameter("categoria");
	
	Subcategory category;
	try {
		category = Subcategory.valueOf(categoryStr);
	} catch (IllegalArgumentException e) {
		category = null;
	}
	
	if (category == null) {
		response.sendRedirect("index.jsp");
		return;
	}
%>
   <%
	List<Product> products = ProductDao.getInstance().getAllByCategory(category.name()); 
	Set<Product> lista_prodotti= new HashSet<>(products);
	String sortParam = request.getParameter("sortBy");
	if (sortParam != null) {
		lista_prodotti = lista_prodotti.stream().sorted((x, y) -> {
			switch (sortParam.toLowerCase()) {
				case "PRICEDESC":
					return Float.compare(x.getPrice(), y.getPrice());
					
				case "PRICEASC":
					return Float.compare(x.getPrice(), y.getPrice());
					 
				case "HEIGHTDESC":
					return Float.compare(x.getHeight(), y.getHeight());
					 
				case "HEIGHTASC":
					return Float.compare(x.getHeight(), y.getHeight());
					 
				case "NOME":
					return x.getName().toLowerCase().compareTo(y.getName().toLowerCase());
				case "DISPONIBILITA":
					return Short.compare(x.getAvailableAmount(), y.getAvailableAmount());
				case "CIRCONFERENZA":
					return Float.compare(x.getFlowerpotCircumference(), y.getFlowerpotCircumference());
					
				default:
					return 0;
					 
				
			}
		}).collect(Collectors.toCollection(LinkedHashSet::new));
		if (sortParam.equalsIgnoreCase("PRICEDESC")||sortParam.equalsIgnoreCase("HEIGHTDESC")) {
			List<Product> list = new ArrayList<>(lista_prodotti);
			Collections.reverse(list);
			lista_prodotti = new LinkedHashSet<>(list);
		}
	}
	 
	

%>

                                 <%@ include file="header.jsp" %>
                                    <div class="container">
                                        <div class="row">
                                            <h3><%= category.toString() %></h3>
                                        </div>
                                        <div class="row">
                                            <div class="filter-section"
                                                style="width: 100%;height: 80px;background-color: #e6e6e6;">
                                                <div class="sort">
                                                <label for="sort">Filtra:</label>
                                                <form action="Catalogo.jsp" method="GET"> 
                                                <select name="sortBy">
                                                    <option value="PRICEDESC">Dal più costoso</option>
                                                    <option value="PRICEASC">Dal più economico</option>
                                                    <option value="HEIGHTDESC">Dal più alto</option>
                                                    <option value="HEIGHTASC">Dal più basso</option>
                                                </select></form>
                                                </div>
                                                
                                                <div class="sortby">
                                                <label for="sortby">Filtra per:</label>
                                                <select name="sortby" id="sortby">
                                                    <option value="NOME">NOME</option>
                                                    <option value="DISPONIBILITA">DISPONIBILITA'</option>
                                                    <option value="CIRCONFERENZA">CIRCONFERENZA VASO</option>
                                                   
                                                </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="product-container">
                                             <% 
                                           
                                             
                                         //    List<Product> lista_prodotti = ProductDao.getInstance().getAllByCategory(category); 
                                             if(lista_prodotti.isEmpty()){%>
                                             		<h3>Non abbiamo disponibilità di questa categoria</h3>
                                             
                                             <% 
                                             }
                                             else
                                             	for (Product product : lista_prodotti) { 
                                             
                                             %>
                                                <div class="card">
                                                    <a href="product.jsp?id=<%= product.getId() %>"><img src="asset/images/<%= product.getId() %>.jpg" alt=""></a>
                                                    <div class="text-box">
                                                        <h3><%= product.getName() %></h3>
                                                        <h6><%= Math.round(product.getPrice() * 100.0f) / 100.0f%>$</h6>
                                                    </div>
                                                </div>
                                                <%} %>
                                                
                                            <!--     <div class="card">
                                                    <img src="asset/images/slider-thumb6.jpg" alt="">
                                                    <div class="text-box">
                                                        <h3>Titolo</h3>
                                                        <h6>Price</h6>
                                                    </div>
                                                </div>  --->
                                                
                                            </div>
                                        </div>
                                    </div>


								<%@ include file="footer.jsp" %> 
                                </body>
</html>