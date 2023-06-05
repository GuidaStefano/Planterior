<%@page import="java.io.IOException"%>
<%@page import="it.unisa.planterior.model.bean.Product"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>  

        <link rel="stylesheet" href="asset/style/index-style.css" />
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
                } catch (IOException ignored) {
                }
            };
        %>

        <div id="new-arrivals" class="container">
            <h3>NUOVI ARRIVI</h3>
            <div class="product-list-horizontal">
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>
                <div class="card">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>

            </div>
        </div>

        <div id="catalogues" class="container">
            <h3>CATALOGHI</h3>
            <div class="catalogue-home">
                <div class="catalogue">
                    <!--<img src="src" alt="alt"/>--><div class="img-ex"></div>
                    <h2 class="product-name">Pianta Ex</h2>
                    <h3 class="product-price">25</h3>
                </div>

            </div>
        </div>


    </body>
</html>