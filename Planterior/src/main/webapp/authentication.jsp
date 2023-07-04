<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Autenticazione</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="asset/style/authentication-style.css" />
        <link rel="stylesheet" href="asset/style/text-style.css" />
        
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script src="asset/script/checkEmail.js"></script>      
 
    </head>
    <body>
         <%@ include file="header.jsp" %>  
        <div class="v-row">
            <h1>AUTENTICAZIONE</h1>
            <div class="h-row">
                <div class="form-wrapper">
                    <h3>ACCEDI AL TUO ACCOUNT</h3>
                    <form class="form" action="LoginServlet" method="POST">
                        <div>
                            <label for="username">Email</label>
                            <input id="EmailLogin" class="text-input" type="text" name="email"/><!--   onchange="existEmail()"-->
                            <span id="ErrorLogin"></span>
                        </div>
                        <div>
                            <label for="password">Password</label>
                            <input class="text-input" type="password" name="password" />
                        </div>
                        <div class="password-recovery">
                            <div class="form-checkbox">
                                <input type="checkbox" name="save-session" />
                                <p>Ricordami</p>
                            </div>
                            <p><a href="">Password dimenticata?</a></p>
                        </div>
                        <input class="submit-btn" id="Accedi" type=submit value=Login />
                    </form>
                </div>
                <div class="form-wrapper">
                    <h3>REGISTRATI</h3>
                    <form class="form" action="RegistrationServlet" method="POST">
                        <div class="form-row">
                            <div>
                                <label for="name">Nome</label>
                                <input class="text-input"type="text" name="name" />
                            </div>
                            <div>
                                <label for="surname">Cognome</label>
                                <input class="text-input" type="text" name="surname" />
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="radio-input-w">
                                <label for="gender">Sesso</label>
                                <div class="radio-input">
                                    <div>
                                        <input type="radio" id="gender-m" name="gender" value="M" required />
                                        <label for="gender-m">M</label>
                                    </div>
                                    <div>
                                        <input type="radio" id="gender-f" name="gender" value="F" />
                                        <label for="gender-f">F</label>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <label for="birth-date">Data di nascita</label>
                                <input class="text-input" type="date" name="birth-date" />
                            </div>
                        </div>
                        <div>
                            <label for="username">Email</label>
                            <input id="EmailSignUp" class="text-input" type="email" name="email" />
                             <span id="ErrorSignup">Sei un coglione</span>
                        </div>
                        <div>
                            <label for="password">Password</label>
                            <input class="text-input" type="password" name="password" />
                        </div>
                        <div class="form-checkbox">
                            <input type="checkbox" name="save-session"/>
                            <p>Ho letto ed accetto <a id="terms-anchor">Termini e Condizioni</a></p>
                        </div>
                        <input class="submit-btn" type="submit" id="SignUp" value="REGISTRATI ORA" />
                    </form>
                </div>
            </div>
        </div>
 
        <%@ include file="footer.jsp" %> 
         
       
         
   
    </body>
</html>