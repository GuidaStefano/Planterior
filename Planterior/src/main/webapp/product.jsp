<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <title>Scheda prodotto</title>
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/product-style.css" />
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
    </head>
    <body>
        <%@ include file="header.jsp" %>  
        <div class="product-card">
            <div class="product-image">
                <img id="main-image" src="asset/images/kenzia-basic.jpg" alt="Product Image">
                <div class="product-thumbs">
                    <div class="product-thumb">
                        <img src="asset/images/lezio20.jpg" alt="Product Thumb" onclick="document.getElementById('main-image').src = this.src;">
                    </div>
                    <div class="product-thumb">
                        <img src="asset/images/lezio21.jpg" alt="Product Thumb" onclick="document.getElementById('main-image').src = this.src;">
                    </div>
                    <div class="product-thumb">
                        <img src="asset/images/lezio20.jpg" alt="Product Thumb" onclick="document.getElementById('main-image').src = this.src;">
                    </div>
                </div>
            </div>
            <div class="product-details">
                <h1 class="product-title">Nome Prodotto</h1>
                <p class="product-price">$99.99</p>
                <p class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, enim a sagittis dapibus, lorem nulla rhoncus est, sit amet tempor metus lorem ac ipsum.</p>
                <div class="number-input-wrapper">
                      <div class="number-input">
                        <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
                        <input min="1" name="quantity" value="1" type="number">
                        <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
                      </div>
                    <button class="add-to-cart">Aggiungi al carrello</button>
                </div>
            </div>
        </div>
        <%@ include file="footer.jsp" %>  
    </body>
</html>