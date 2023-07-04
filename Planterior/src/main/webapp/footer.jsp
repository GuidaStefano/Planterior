<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <link rel="stylesheet" href="asset/style/header-style.css" />
   <link rel="stylesheet" href="https://use.typekit.net/omf2qxn.css">
</head>
<body>
    <!--Footer-->

    <div class="container" style="background-color: #f3f3f3;">
        <div class="row" style="padding: 40px;">
            <div class="col-4 footer-col col-xs-12">
                <ul>
                    <li>
                        <h2>Menu</h2>
                    </li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="Catalogo.jsp?categoria=PIANTE_VERDI">PIANTE VERDI</a></li>
							<li><a href="Catalogo.jsp?categoria=PIANTE_GRASSE">PIANTE GRASSE</a></li>
							<li><a href="Catalogo.jsp?categoria=PIANTE_FIORITE">PIANTE FIORITE</a></li>
							<li><a href="Catalogo.jsp?categoria=ORCHIDEE">ORCHIDEE</a></li>
							
                </ul>
            </div>
            <div class="col-4 footer-col col-xs-12">
                <h1>Newsletter</h1>
                <p>Sign up for our free video course and urban garden inspiration</p>
                <form action="">
                    <input type="email" name="newsletter" id="newsletter" placeholder="Email">
                    <button type="submit">Iscriviti</button>
                </form>
                <div class="row">
                    <div class="icons">

                    </div>
                </div>
            </div>
            <div class="col-4 footer-col col-xs-12">
                <ul>
                    <li>
                        <h2>Infromation</h2>
                    </li>
                    <li><a href="#">INFORMAZIONI</a></li>
                    <li><a href="authentication.jsp">ACCEDI</a></li>
                    <li><a href="authentication.jsp">REGISTRATI</a></li>
                    <li><a href="cart.jsp">CARRELLO</a></li>
                </ul>
            </div>
        </div>
    </div>

</body>
</html>