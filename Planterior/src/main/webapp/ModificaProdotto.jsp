<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%
     
    Optional<?> a = ((Optional<?>)request.getSession().getAttribute("product"));
    if(a.get()== null){
    	response.sendRedirect("./amministratore.jsp");
    }
    Product prodotto1=(Product)a.get();
    System.out.println(prodotto1.getId());
     
     %>
     
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.planterior.model.bean.Product"%>
<head>
<script type="text/javascript" src="asset/script/ModificaProdotto.js"></script>
<meta charset="ISO-8859-1">
<style>
 .nascondi{
 	display:none;
 	
 }
  </style>
  <script>
  function chiudiElemento (bottone){
		 return function chiudi() {
			 bottone.classList.add("nascondi");
		 }
		}
		function apriElemento (bottone ){
			return function apri() {
				 bottone.classList.remove("nascondi");
			 } 
			 
		}
  </script>
 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="asset/style/text-style.css">
<link rel="stylesheet" href="asset/style/ModificaProdotto.css">
 
 
<title>Modifica Prodotto</title>
</head>
<body>
 <h3> <%=prodotto1.getName()%>  </h3>
    <form action=ModificaServlet method=get>
	 <div class="struttura" >
	 	<div class="sinistra">
	 	<!-- Campo nome -->
	 		<div class="spacing">
				<label for="nome">Nome:</label><br> 
				<div class="modifica">
					<h5><%=prodotto1.getName()%></h5>
					<button type="button" id="openNome"><i class="fa-solid fa-pen-to-square"></i></button>
				</div>
				<div id="bloccoNome" class="nascondi">
							<input name="nome" type="text" maxlength="20" placeholder="Scrivi nome"><br>
							<button type="button" value="<%=prodotto1.getName()%>" id="closeNome"><i class="fa-solid fa-xmark"></i></button>
				</div>
			<!--   	<input name="nome" type="text" maxlength="20" required placeholder="Scrivi nome"><br> -->
			</div >
			
			<!-- Campo Circonferenza Vaso -->
			<div class="spacing"> 
				<label for="Circonferenza">Circonferenza Vaso:</label><br>
				<div class="modifica">
					<h5><%=prodotto1.getFlowerpotCircumference()%></h5>
					<button type="button" id="openCirconferenza"><i class="fa-solid fa-pen-to-square"></i></button>
				
				</div> 
				<div id="bloccoCirconferenza" class="nascondi">
							<input name="Circonferenza" type="number" min="0" value="0"  ><br>
							<button type="button" id="closeCirconferenza" ><i class="fa-solid fa-xmark"></i></button>
				</div>
			<!--   	<input name="Circonferenza" type="number" min="1" value="1" required><br>-->
			</div>
			
			<!-- Campo Altezza -->
			<div class="spacing"> 
				<label for="Altezza">Altezza (cm):</label><br> 
				<div class="modifica">
					<h5><%=prodotto1.getHeight()%>cm</h5>
					<button type="button" id="openAltezza"><i class="fa-solid fa-pen-to-square"></i></button>
				</div>
				<div id="bloccoAltezza" class="nascondi">
							<input name="Altezza" type="number" min="0" value="0"  ><br>
							<button type="button" id="closeAltezza"><i class="fa-solid fa-xmark"></i> </button>
					 
				</div>
			<!--   	<input name="Altezza" type="number" min="1" value="1" required><br>-->
			</div>
			
			
			<!-- Campo Descrizione breve -->
			<div class="spacing"> 
				<label for="breve">Descrizione Breve:</label><br>
				<div class="modifica">
					<h5><%=prodotto1.getMinimalDescription()%></h5>
					<button type="button" id="openBreve"><i class="fa-solid fa-pen-to-square"></i></button>
				</div>
				<div id="bloccoBreve" class="nascondi">
							<textarea name="breve"   maxlength="100" rows="3" placeholder="Scrivi breve"></textarea><br>
							<button type="button"   id="closeBreve"><i class="fa-solid fa-xmark"> </i></button>
					 
				</div>
		<!--   		<textarea name="breve" maxlength="100" rows="3" required placeholder="Scrivi breve"></textarea><br> -->
			</div>
			<!-- Campo Descrizione -->
			<div class="spacing"> 
				<label for="Completa">Descrizione Completa:</label><br>
				<div class="modifica">
					<h5><%=prodotto1.getDescription()%></h5>
					<button type="button" id="openDescrizione"><i class="fa-solid fa-pen-to-square"></i></button>
					
				</div>
				<div id="bloccoDescrizione" class="nascondi">
							<textarea name="Completa" maxlength="100" rows="3" placeholder="Scrivi Completa"></textarea><br>
							<button type="button" id="closeDescrizione"><i class="fa-solid fa-xmark"> </i></button>
					 
				</div>
		<!--   		<textarea name="Completa" maxlength="100" rows="3" required placeholder="Scrivi Completa"></textarea><br> -->
			</div>
			
			 
	 	</div>
	 	<div class="destra">
	 	
	 		<!-- Campo Quantità -->
	 		<div class="spacing"> 
				<label for="Quantita">Quantità:</label><br> 
				<div class="modifica">
					<h5><%=prodotto1.getAvailableAmount()%></h5>
					<button id="openQuantita" type="button"><i class="fa-solid fa-pen-to-square"></i></button>
				</div>
				<div id="bloccoQuantita" class="nascondi">
							<input name="Quantita" type="number" min="-1" value="-1" required><br>
							<button type="button" id="closeQuantita"><i class="fa-solid fa-xmark"></i></i></button>
					 
				</div>
				<!--<input name="Quantita" type="number" min="1" value="1" required><br> -->
			</div>
			
			<!-- Modifica prezzo base -->
			<div class="spacing"> 
				<label for="Base">Prezzo Base:</label><br> 
				<div class="modifica">
					<h5><%=prodotto1.getBasePrice()%>$</h5>
					<button id="openPrezzo" type="button"><i class="fa-solid fa-pen-to-square"></i></button>		 			
				</div>
				<div id="bloccoPrezzo" class="nascondi">
							<input name="Prezzo" type="number" min="0" value="0" ><br>
							<button type="button"id="closePrezzo"><i class="fa-solid fa-xmark"></i> </button>
					 
				</div>
			</div>
		<!-- Modifica sconto  -->
			<div class="spacing"> 
				<label for="Sconto">Sconto:</label><br> 
				<div class="modifica">
					<h5><%=prodotto1.getDiscountRate()%>$</h5>
					<button id="openSconto" type="button"><i class="fa-solid fa-pen-to-square"></i></button>
						
				</div>
				<div id="bloccoSconto" class="nascondi">
							<input name="Sconto" type="number" min="0" value="0"  ><br>
							<button type="button" id="closeSconto"><i class="fa-solid fa-xmark"></i> </button>
				</div>
			<!--   	<input name="Sconto" type="number" min="0" value="0" required><br> -->
			</div>
	 	</div>
	 <!-- Pulsanti finali -->
	 </div>
	 <div class="buttons">
	 				<a href="amministratore.jsp"> 
						<button><i class="fa-solid fa-trash"></i> </button>
					</a>
						<br>
						<button type="submit"><i class="fa-solid fa-check"></i></button>				
	 </div>
</form>
<script>

	 const openSconto=document.getElementById("openSconto");
	 const closeSconto=document.getElementById("closeSconto");
	 const bottoneSconto= document.getElementById("bloccoSconto");
	 openSconto.addEventListener("click",apriElemento(bottoneSconto));
	 closeSconto.addEventListener("click",chiudiElemento(bottoneSconto));
	 
	 const openPrezzo=document.getElementById("openPrezzo");
	 const closePrezzo=document.getElementById("closePrezzo");
	 const bottonePrezzo= document.getElementById("bloccoPrezzo");
	 openPrezzo.addEventListener("click",apriElemento(bottonePrezzo));
	 closePrezzo.addEventListener("click",chiudiElemento(bottonePrezzo));
	 
	 const openQuantita=document.getElementById("openQuantita");
	 const closeQuantita=document.getElementById("closeQuantita");
	 const bottoneQuantita= document.getElementById("bloccoQuantita");
	 openQuantita.addEventListener("click",apriElemento(bottoneQuantita));
	 closeQuantita.addEventListener("click",chiudiElemento(bottoneQuantita));
	 
	 const openDescrizione=document.getElementById("openDescrizione");
	 const closeDescrizione=document.getElementById("closeDescrizione");
	 const bottoneDescrizione= document.getElementById("bloccoDescrizione");
	 openDescrizione.addEventListener("click",apriElemento(bottoneDescrizione));
	 closeDescrizione.addEventListener("click",chiudiElemento(bottoneDescrizione));
	 
	 const openBreve=document.getElementById("openBreve");
	 const closeBreve=document.getElementById("closeBreve");
	 const bottoneBreve= document.getElementById("bloccoBreve");
	 openBreve.addEventListener("click",apriElemento(bottoneBreve));
	 closeBreve.addEventListener("click",chiudiElemento(bottoneBreve));
	 
	 const openCirconferenza=document.getElementById("openCirconferenza");
	 const closeCirconferenza=document.getElementById("closeCirconferenza");
	 const bottoneCirconferenza= document.getElementById("bloccoCirconferenza");
	 openCirconferenza.addEventListener("click",apriElemento(bottoneCirconferenza));
	 closeCirconferenza.addEventListener("click",chiudiElemento(bottoneCirconferenza));
	 
	 
	 const openAltezza=document.getElementById("openAltezza");
	 const closeAltezza=document.getElementById("closeAltezza");
	 const bottoneAltezza= document.getElementById("bloccoAltezza");
	 openAltezza.addEventListener("click",apriElemento(bottoneAltezza));
	 closeAltezza.addEventListener("click",chiudiElemento(bottoneAltezza));
	 
	 const openNome=document.getElementById("openNome");
	 const closeNome=document.getElementById("closeNome");
	 const bottoneNome= document.getElementById("bloccoNome");
	 openNome.addEventListener("click",apriElemento(bottoneNome));
	 closeNome.addEventListener("click",chiudiElemento(bottoneNome));
	  
 
 
 </script>
	 
</body>
</html>