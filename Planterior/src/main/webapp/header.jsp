<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="asset/style/header-style.css" />
<link rel="stylesheet" href="asset/style/text-style.css" />
<link rel="stylesheet" href="https://use.typekit.net/omf2qxn.css">
</head>
<body>
	<div class="container" style="background-color: #65a15a; height: 5vh;">
		<div class="row"
			style="height: 100%; justify-content: center; align-content: center;">
			<div class="col-6">
				<b style="color: white;">Benvenuto in Planterior</b>
			</div>
			<div class="col-6" style="text-align: end;">
			<% if(session == null || session.getAttribute("user") == null) { 
				%>
		        <a href="authentication.jsp"> <b>Login</b> <b>|</b> <b>Register</b>
				</a>
			  
		        
		    <%
		        } else {
		    %>
		    	<a href="Logout"> <b>Logout</b> </a> 
				 
		    		
				<%
		        }
		    %>
			</div>
		</div>
	</div>

	<div class="container" style="margin: 10px 0;">
		<div class="row" style="align-items: center;">
			<div class="col-4 col-xs-3">
				<!-- Contenuto della prima colonna dell'header -->
				<img src="asset/icon/logo.png" width="120" height="100">
			</div>
			<div class="col-4 search-mobile-none">
				<!-- Contenuto della seconda colonna dell'header -->
				<div class="form-content">
					<div class="inner">
						<input type="text" class="input" name="s" value=""
							placeholder="Cerca prodotto">
					</div>
					<button class="btn-search big-button static-btn" type="submit">
					<i class="fa-sharp fa-solid fa-magnifying-glass fa-lg" style="color: #ffffff;"></i>
					</button>
				</div>
			</div>
			<div class="col-4 col-xs-3" style="display: flex; justify-content: center;">
				<!-- Contenuto della terza colonna dell'header -->
				<a href="Carrello.jsp"> 	
					<button class="icon-button nav-btn"><i class="fa-solid fa-cart-shopping fa-2xl"></i></button>
				</a>
				<a href="PaginaUtente.jsp">
					<button class="icon-button nav-btn"><i class="fa-solid fa-user fa-2xl"></i></button>
				</a>
			</div>
			<div class="col-xs-12 search-mobile-display">
				<!-- Contenuto della seconda colonna dell'header -->
				<div class="form-content">
					<div class="inner">
						<input type="text" class="input" name="s" value=""
							placeholder="Cerca prodotto">
					</div>
					<button class="btn-search big-button static-btn" type="submit">
					<i class="fa-sharp fa-solid fa-magnifying-glass fa-lg" style="color: #ffffff;"></i>
					</button>
				</div>
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
					<span>All categories
						<ul>
							<li><a href="">Link</a></li>
							<li><a href="">Link</a></li>
							<li><a href="">Link</a></li>
							<li><a href="">Link</a></li>
						</ul>
					</span>
				</div>
			</div>
			<ul>
				<li><a href="#">Home</a></li>
				<li><a href="#">Shop</a>
					<ul>
						<li><a href="#">Sotto-link 1</a></li>
						<li><a href="#">Sotto-link 2</a></li>
					</ul></li>
				<li><a href="#">Link 3</a></li>
				<li><a href="#">Link 4</a></li>
				<li><a href="#">Link 5</a></li>
			</ul>
		</nav>
	</div>
</body>
</html>