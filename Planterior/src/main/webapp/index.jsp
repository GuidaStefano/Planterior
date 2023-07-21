<%@page import="it.unisa.planterior.util.PathUtil"%>
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
<html lang="it">
    <head>  
	<meta name="viewport" content="width=device-width">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=yes">
        <link rel="stylesheet" href="asset/style/index-style.css" />
        <title>Planterior</title>
    </head>
    <body>
        <%@ include file="header.jsp" %>  

         <%
         	Product prodotto1 = ProductDao.getInstance().getById(1).get();
        	Product prodotto2 = ProductDao.getInstance().getById(2).get();
         	Product prodotto3 = ProductDao.getInstance().getById(3).get();
         
         %>
        <div class="container">
            <div class="row" style="height: 90vh;">
                <div class="col-8 col-xs-12" style="padding: 50px 0;">
                    <div class="box-slider"
                        style="background-image:url(<%= PathUtil.getMainImagePath(prodotto1.getId()) %>);background-position: center;background-repeat: no-repeat;background-size: cover;">
                        <div class="row" style="height: 100%;">
                            <div class="col-6 col-xs-12" style="display: flex;align-items: center;justify-content: center;">
                                <div class="text-box" style="line-height: 1;">
                                    <h5><%= prodotto1.getCategory() %></h5>
                                    <h4><%= prodotto1.getName() %></h4>
                                    <h4><%=Math.round(prodotto1.getPrice() * 100.0f) / 100.0f%>$</h4>
                                     <a  href="product.jsp?id=<%= prodotto1.getId() %>"> <button>Acquista Ora</button></a>
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
                            style="width: 100%;height: 100%;background-image:url(<%= PathUtil.getMainImagePath(prodotto2.getId()) %>);background-position: center;background-repeat: no-repeat;background-size: cover;">
                            <div class="col-8"
                                style="height:100%;display: flex;align-items: center;justify-content: center;">
                                <div class="text-box" style="line-height: 1;">
                                     <h5><%= prodotto2.getCategory() %></h5>
                                    <h4><%= prodotto2.getName() %></h4>
                                    <h4><%= Math.round(prodotto2.getPrice() * 100.0f) / 100.0f%>$</h4>
                                    <a  href="product.jsp?id=<%= prodotto2.getId() %>"> <button>Acquista Ora</button></a>
                                </div>
                            </div>
                            <div class="col-4"></div>
                        </div>
                    </div>
                    <div class="row" style="height: 50%;padding: 10px 10px 0px 10px;">
                        <div class="hero-square"
                            style="width: 100%;height:100%;background-image:url(<%= PathUtil.getMainImagePath(prodotto3.getId()) %>);background-position: center;background-repeat: no-repeat;background-size: cover;">
                            <div class="col-8"
                                style="height:100%;display: flex;align-items: center;justify-content: center;">
                                <div class="text-box" style="line-height: 1;">
                                     <h5><%= prodotto3.getCategory() %></h5>
                                    <h4><%= prodotto3.getName() %></h4>
                                    <h4><%=Math.round(prodotto3.getPrice() * 100.0f) / 100.0f %>$</h4>
                                    <a  href="product.jsp?id=<%= prodotto3.getId() %>"> <button>Acquista Ora</button></a>
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
            	<a href="product.jsp?id=<%= product.getId() %>">
                 	<div class="card">
                    	<img height="180" src="<%= PathUtil.getMainImagePath(product.getId()) %>" alt="">
                   	 	<div class="text-box">
                        	<h5><%= product.getName() %></h5>
                        	<h6><%= Math.round(product.getPrice() * 100.0f) / 100.0f%>$</h6>
                    	</div>
                	</div>
                </a>
                <%} %>
            </div>
        </div>
		<%@ include file="footer.jsp" %>  
    </body>
</html>