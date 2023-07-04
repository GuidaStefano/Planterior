<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8"%>
    <%@page import="java.io.IOException"%>
<%@page import="it.unisa.planterior.model.bean.*"%>
<%@page import="it.unisa.planterior.model.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="java.util.stream.Collectors"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width">
                                    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=yes">
                                    <link rel="stylesheet" href="asset/style/catalogo-style.css" />
                                    <link rel="stylesheet" href="asset/style/header-style.css" />
                                    <title> Catalogo</title>

</head>
<body>
<%
if(request.getParameter("categoria")==null)
	 request.getRequestDispatcher("index.jsp").forward(request, response);


%>

                                 <%@ include file="header.jsp" %>
                                    <div class="container">
                                        <div class="row">
                                            <h3>CATALOGO</h3>
                                        </div>
                                        <div class="row">
                                            <div class="filter-section"
                                                style="width: 100%;height: 80px;background-color: #e6e6e6;">
                                                <div class="sort">
                                                <label for="sort">Filtra:</label>
                                                <select name="sort" id="sort">
                                                    <option value="volvo">Oppt</option>
                                                    <option value="saab">opt</option>
                                                    <option value="mercedes">opt</option>
                                                    <option value="audi">opt</option>
                                                </select>
                                                </div>
                                                
                                                <div class="sortby">
                                                <label for="sortby">Filtra per:</label>
                                                <select name="sortby" id="sortby">
                                                    <option value="volvo">Dal più costoso</option>
                                                    <option value="saab">Dal più economico</option>
                                                    <option value="mercedes">opt</option>
                                                    <option value="audi">opt</option>
                                                </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="product-container">
                                             <% 
                                             String category= (String)request.getParameter("categoria");
                                             System.out.print(category);
                                             List<Product> lista_prodotti = ProductDao.getInstance().getAllByCategory(category);
                                             if(lista_prodotti.size()==0){%>
                                             		<h3>Non abbiamo disponibilità di questa categoria</h3>
                                             
                                             <% 
                                             }
                                             else
                                             	for (Product product : lista_prodotti) { 
                                             
                                             %>
                                                <div class="card">
                                                    <img src="asset/images/<%= product.getId() %>.jpg" alt="">
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