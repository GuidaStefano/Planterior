<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="asset/style/header-style.css" />
	<link rel="stylesheet" href="asset/style/text-style.css" />
	<link rel="stylesheet" href="https://use.typekit.net/omf2qxn.css">
	<title>Planterior</title>
</head>
<body>
	<div class="container" style="background-color: #65a15a; height: 5vh;">
		<div class="row"
			style="height: 100%; justify-content: center; align-content: center;">
			<div class="col-6">
				<b style="color: white;">Benvenuto in Planterior</b>
			</div>
			<div class="col-6" style="text-align: end;">
			<% if(session == null || session.getAttribute("user") == null) { %>
		        <a href="authentication.jsp"> 
		        	<b>Login</b> 
		        	<b>|</b> 
		        	<b>Registrazione</b>
		        </a>
		    <% } else { %>
		    	<a href="Logout"> 
		    		<b>Logout</b> 
		    	</a> 
				<% } %>
			</div>
		</div>
	</div>

	<div class="container" style="margin: 10px 0;">
		<div class="row" style="align-items: center;">
			<div class="col-4 col-xs-3">
				<!-- Contenuto della prima colonna dell'header -->
				<a href="index.jsp"><img alt="Logo" src="asset/icon/logo.png" width="120" height="100"></a>
			</div>
			<div class="col-4 search-mobile-none">
				<!-- Contenuto della seconda colonna dell'header -->
				<form action="catalog.jsp" class="form-content">
					<div class="inner">
						<input type="text" class="input" name="search" value=""
							placeholder="Cerca prodotto">
					</div>
					<button class="btn-search big-button static-btn" type="submit">
					<i class="fa-sharp fa-solid fa-magnifying-glass fa-lg" style="color: #ffffff;"></i>
					</button>
				</form>
			</div>
			<div class="col-4 col-xs-3" style="display: flex; justify-content: end;">
				<!-- Contenuto della terza colonna dell'header -->
				<a href="cart.jsp"> 	
					<button class="icon-button nav-btn"><i class="fa-solid fa-cart-shopping fa-2xl"></i></button>
				</a>
				<a href="personal-area.jsp">
					<button class="icon-button nav-btn"><i class="fa-solid fa-user fa-2xl"></i></button>
				</a>
			</div>
			<div class="col-xs-12 search-mobile-display">
				<!-- Contenuto della seconda colonna dell'header -->
				<form action="catalog.jsp" class="form-content">
					<div class="inner">
						<input type="text" class="input" name="search" value=""
							placeholder="Cerca prodotto">
					</div>
					<button class="btn-search big-button static-btn" type="submit">
					<i class="fa-sharp fa-solid fa-magnifying-glass fa-lg" style="color: #ffffff;"></i>
					</button>
				</form>
			</div>
		</div>
	</div>
	<div class="container" style="background-color: #f3f3f3;">
		<nav class="row mini-nav">
			<div class="vertical-menu">
				<div class="block-iconmenu">
					<i class="fa fa-bars" aria-hidden="true" style="color: white;margin-right: 10px"></i>
				</div>
				<div class="block-title">
					<span>Tutte le categorie
						<ul class="ul-mobile">
							<li><a href="catalog.jsp?category=PIANTE_VERDI">PIANTE VERDI</a></li>
							<li><a href="catalog.jsp?category=PIANTE_GRASSE">PIANTE GRASSE</a></li>
							<li><a href="catalog.jsp?category=PIANTE_FIORITE">PIANTE FIORITE</a></li>
							<li><a href="catalog.jsp?category=ORCHIDEE">ORCHIDEE</a></li>
							<li><a href="catalog.jsp?category=TERRARIUM">TERRARIUM</a></li>
							<li><a href="catalog.jsp?category=VASI">VASI</a></li>
							<li><a href="catalog.jsp?category=ACCESSORI_PIANTE">ACCESSORI PIANTE</a></li>
						</ul>
					</span>
				</div>
			</div>
			<ul>
				<li>
					<a href="catalog.jsp?main-category=PIANTE_DA_INTERNO">PIANTE DA INTERNO</a>
				</li>
				<li><a href="catalog.jsp?main-category=TERRARIUM">TERRARIUM</a></li>
				<li>
					<a href="catalog.jsp?main-category=HOME_DECOR">HOME DECOR</a>
				</li>
			</ul>
		</nav>
	</div>
</body>
</html>