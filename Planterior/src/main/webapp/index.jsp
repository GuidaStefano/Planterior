<%@page import="java.io.IOException"%>
<%@page import="it.unisa.planterior.model.bean.Product"%>
<%@page import="it.unisa.planterior.model.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8"%>
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
                                <div class="text-box" style="line-height: 1;">
                                    <h5>Sovrattitolo</h5>
                                    <h2>Titolo</h2>
                                    <h4>Prezzo</h4>
                                    <button>Acquista Ora</button>
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
                                    <h5>Sovrattitolo</h5>
                                    <h2>Titolo</h2>
                                    <h4>Prezzo</h4>
                                    <button>Acquista Ora</button>
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
                                    <h5>Sovrattitolo</h5>
                                    <h2>Titolo</h2>
                                    <h4>Prezzo</h4>
                                    <button>Acquista Ora</button>
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
                <div class="card">
                    <img src="asset/images/slider-thumb6.jpg" alt="">
                    <div class="text-box">
                        <h3>Titolo</h3>
                        <h6>Price</h6>
                    </div>
                </div>
                <div class="card">
                    <img src="asset/images/slider-thumb6.jpg" alt="">
                    <div class="text-box">
                        <h3>Titolo</h3>
                        <h6>Price</h6>
                    </div>
                </div>
                <div class="card">
                    <img src="asset/images/slider-thumb6.jpg" alt="">
                    <div class="text-box">
                        <h3>Titolo</h3>
                        <h6>Price</h6>
                    </div>
                </div>
                <div class="card">
                    <img src="asset/images/slider-thumb6.jpg" alt="">
                    <div class="text-box">
                        <h3>Titolo</h3>
                        <h6>Price</h6>
                    </div>
                </div>
                <div class="card">
                    <img src="asset/images/slider-thumb6.jpg" alt="">
                    <div class="text-box">
                        <h3>Titolo</h3>
                        <h6>Price</h6>
                    </div>
                </div>
                <div class="card">
                    <img src="asset/images/slider-thumb6.jpg" alt="">
                    <div class="text-box">
                        <h3>Titolo</h3>
                        <h6>Price</h6>
                    </div>
                </div>
            </div>
        </div>
		<%@ include file="footer.jsp" %>  
    </body>
</html>