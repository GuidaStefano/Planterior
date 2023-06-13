<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <link rel="stylesheet" href="asset/style/header-style.css" />
   <link rel="stylesheet" href="https://use.typekit.net/omf2qxn.css">
</head>
<body>
    <div class="container" style="background-color: #65a15a;height: 5vh;">
        <div class="row" style="height: 100%;justify-content: center;align-content: center;">
            <div class="col-6">
                <b style="color: white;">Benvenuto in Planterior</b>
            </div>
            <div class="col-6" style="text-align: end;">
                <a href="#"><b>Login</b></a>
                <a href="#"><b>|</b></a>
                <a href="#"><b>Register</b></a>
            </div>
        </div>
    </div>

    <div class="container" style="margin: 5px 0;">
        <div class="row" style="align-items: center;">
            <div class="col-4">
                <!-- Contenuto della prima colonna dell'header -->
                <img src="asset/icon/logo.png" width="120" height="120">
            </div>
            <div class="col-4">
                <!-- Contenuto della seconda colonna dell'header -->
                <div class="form-content">
                    <div class="inner">
                        <input type="text" class="input" name="s" value="" placeholder="Cerca prodotto">
                    </div>
                    <button class="btn-search" type="submit">
                        <img src="asset/icon/search.png" width="25px" height="25px">
                    </button>
                </div>
            </div>
            <div class="col-4" style="display: flex;justify-content: center;">
                <!-- Contenuto della terza colonna dell'header -->
                <img src="asset/icon/bag.png" width="30" height="30" style="margin-right: 30px;">
                <img src="asset/icon/user.png" width="30" height="30">
            </div>
        </div>
    </div>
    <div class="container" style="background-color: #f3f3f3;">
        <nav class="row mini-nav">
            <div class="vertical-menu">
                <div class="block-iconmenu">
                    <img src="asset/icon/menu.png" style="color: white;">
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
                    </ul>
                </li>
                <li><a href="#">Link 3</a></li>
                <li><a href="#">Link 4</a></li>
                <li><a href="#">Link 5</a></li>
            </ul>
        </nav>
    </div>
</body>
</html>