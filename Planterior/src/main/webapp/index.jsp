<%@page import="java.io.IOException"%>
<%@page import="it.unisa.planterior.model.bean.Product"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@page import="java.util.*"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="java.util.stream.Collectors"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8"%>
<%
	Set<Product> products = ProductDao.getInstance().getAll(); %>
<!DOCTYPE html>
<html>
    <head>  
	<meta name="viewport" content="width=device-width">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=yes">
        <link rel="stylesheet" href="asset/style/index-style.css" />
        <title>Planterior</title>
    </head>
    <body>
        <%@ include file="header.jsp" %>  

        <div class="container">
            <div class="row" style="height: 90vh;">
                <div class="col-8 col-xs-12" style="padding: 50px 0;">
                    <div class="box-slider"
                        style="background-image:url(asset/images/slider-thumb6.jpg);background-position: center;background-repeat: no-repeat;background-size: cover;">
                        <div class="row" style="height: 100%;">
                            <div class="col-6 col-xs-12" style="display: flex;align-items: center;justify-content: center;">
                            <%
                            	Optional<Product> prodotto1 = ProductDao.getInstance().getById(38);
                           	 	Optional<Product> prodotto2 = ProductDao.getInstance().getById(39);
                            	Optional<Product> prodotto3 = ProductDao.getInstance().getById(40);
                            
                            
                            %>
                                <div class="text-box" style="line-height: 1;">
                                    <h5><%= prodotto1.get().getCategory() %></h5>
                                    <h4><%= prodotto1.get().getName() %></h4>
                                    <h4><%=Math.round(prodotto1.get().getPrice() * 100.0f) / 100.0f%>$</h4>
                                     <a  href="product.jsp?id=<%= prodotto1.get().getId() %>"> <button>Acquista Ora</button></a>
                                </div>
                            </div>
                            <div class="col-6">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4 col-xs-12" style="padding: 50px 0;">
                    <div class="row" style="height: 50%; padding: 0px 10px 10px 10px;">
                        <div class="hero-square"
                            style="width: 100%;height: 100%;background-image:url(asset/images/banner-home-5.jpg);background-position: center;background-repeat: no-repeat;background-size: cover;">
                            <div class="col-8"
                                style="height:100%;display: flex;align-items: center;justify-content: center;">
                                <div class="text-box" style="line-height: 1;">
                                     <h5><%= prodotto2.get().getCategory() %></h5>
                                    <h4><%= prodotto2.get().getName() %></h4>
                                    <h4><%= Math.round(prodotto2.get().getPrice() * 100.0f) / 100.0f%>$</h4>
                                    <a  href="product.jsp?id=<%= prodotto2.get().getId() %>"> <button>Acquista Ora</button></a>
                                </div>
                            </div>
                            <div class="col-4"></div>
                        </div>
                    </div>
                    <div class="row" style="height: 50%;padding: 10px 10px 0px 10px;">
                        <div class="hero-square"
                            style="width: 100%;height:100%;background-image:url(asset/images/banner-home-6.jpg);background-position: center;background-repeat: no-repeat;background-size: cover;">
                            <div class="col-8"
                                style="height:100%;display: flex;align-items: center;justify-content: center;">
                                <div class="text-box" style="line-height: 1;">
                                     <h5><%= prodotto3.get().getCategory() %></h5>
                                    <h4><%= prodotto3.get().getName() %></h4>
                                    <h4><%=Math.round(prodotto3.get().getPrice() * 100.0f) / 100.0f %>$</h4>
                                    <a  href="product.jsp?id=<%= prodotto3.get().getId() %>"> <button>Acquista Ora</button></a>
                                </div>
                            </div>
                            <div class="col-4"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
        <div class="container" style="height: 100vh;">
            <div class="row" style="flex-direction: column;justify-content: center;align-items: center;">
                <h1><b>Nuovi Arrivi</b></h1>
                <div class="green-separator"></div>
            </div>
            <div class="row" style="margin-top:40px;flex-wrap:nowrap;  overflow-x: scroll;overflow-y: hidden;white-space: nowrap;">
            <% for (Product product : products) { %>
                 <div class="card">
                    <a href="product.jsp?id=<%= product.getId() %>"><img src="asset/images/<%= product.getId() %>.jpg" alt=""></a>
                    <div class="text-box">
                        <h5><%= product.getName() %></h5>
                        <h6><%= Math.round(product.getPrice() * 100.0f) / 100.0f%>$</h6>
                    </div>
                </div>
                <%} %>
            <!--    <div class="card">
                    <img src="asset/images/slider-thumb6.jpg" alt="">
                    <div class="text-box">
                        <h3>Titolo</h3>
                        <h6>Price</h6>
                    </div>
                s  -->  
            </div>
        </div>
		<%@ include file="footer.jsp" %>  
    </body>
</html>