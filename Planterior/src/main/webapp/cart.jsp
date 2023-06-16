<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/cart-style.css" />
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@ include file="header.jsp" %>  
        <div class="cart-wrapper">
            <h1 class="cart-title">CARRELLO</h1>
            <div class="cart">
                <div class="cart-product">
                    <div class="product-info">
                        <a href=""><img src="asset/images/kenzia-basic.jpg" /></a>
                        <div class="product-details">
                            <h4><a href="">Mini swing dress</a></h4>
                            <p><a href="">bla bla bla</a></p>
                        </div>
                    </div>
                    <div class="number-input">
                        <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
                        <input min="1" name="quantity" value="1" type="number">
                        <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
                    </div>
                    <h4 class="price">45€</h4>
                    <button class="icon-button"><i class="fa fa-trash"></i></button>
                </div>
                <div class="cart-product">
                    <div class="product-info">
                        <a href=""><img src="asset/images/kenzia-basic.jpg" /></a>
                        <div class="product-details">
                            <h4><a href="">Mini swing dress</a></h4>
                            <p><a href="">bla bla bla</a></p>
                        </div>
                    </div>
                    <div class="number-input">
                        <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" ></button>
                        <input min="1" name="quantity" value="1" type="number">
                        <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
                    </div>
                    <h4 class="price">45€</h4>
                    <button class="icon-button"><i class="fa fa-trash"></i></button>
                </div>
                <div class="total-price">
                    <h5>PREZZO TOTALE</h5>
                    <h3>100€</h3>
                </div>
            </div>
            <div class="buttons">
                <button class="big-button"><h6>CHECKOUT</h6></button>
                <button class="big-button"><h6>RITORNA ALLO SHOPPING</h6></button>
            </div>
        </div>
        <%@ include file="footer.jsp" %>  
    </body>
</html>