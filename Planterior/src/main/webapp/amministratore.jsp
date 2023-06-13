 

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Collection<?> prodotti = (Collection<?>) request.getAttribute("products");
	if(prodotti == null) {
		response.sendRedirect("./InsertServlet");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.planterior.model.bean.Product"%>
 <%
			String  user=null;
			if(session.getAttribute("username")==null)
				response.sendRedirect("authentication.jsp");
			else
					user=(String)session.getAttribute("username");
			
				%>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
				<link rel="stylesheet" href="asset/style/amministratore.css">
				<link rel="stylesheet" href="asset/style/text-style.css">
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<head>
<meta charset="UTF-8">
<title>Inserisci il tuo primo prodotto</title>
</head>



<body>
<h3 id="titolo"> PRODOTTI SUL SITO</h3>

 	
 

 

	<div  > 
	<table border="1"  >
		<tr >
			<th> <h4>ID</h4></a></th>
			<th>  <h4>NOME</h4></a></th>
			<th> <h4>DESCRIZIONE BREVE</h4></a></th>
			<th> <h4>QUANTITA'</h4></a></th>
			<th> <h4>PREZZO</h4></a></th>
			
			<th><h4>OPZIONI</h4></th>
		</tr>
		<%
		if (prodotti != null && prodotti.size() != 0) {
				Iterator<?> it = prodotti.iterator();
				while (it.hasNext()) {
					Product prodotto1 = (Product) it.next();
		%>
		<tr>
			<td><%=prodotto1.getId()%></td>
			<td><%=prodotto1.getName()%></td>
			<td><%=prodotto1.getMinimalDescription()%></td>
			<td><%=prodotto1.getAvailableAmount()%></td>
			<td><%=prodotto1.getPrice()%>$</td>
			 
			<td>
				<div class="buttons"> 
					<a class="button" href="InsertServlet?action=delete&id=<%=prodotto1.getId()%>">
						<button><i class="fa-solid fa-trash"></i> </button>
					</a>
					<br>
				 
					
					<a class="button" href="ModificaServlet?action=modifica&id=<%=prodotto1.getId()%>">
						<button><i class="fa-solid fa-pen-to-square"></i></button>
					</a>
					
				</div>
			</td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">Non ci sono prodotti disponibili</td>
		</tr>
		<%
			}
		%>
	</table>
	</div>
 
<div class="buttons1"> 
 	<button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" ><i class="fa-solid fa-plus black"></i></button>
 </div>	


<div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title ciao" id="exampleModalLabel">INSERIMENTO</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      	<form action="InsertServlet?action=insert" method="post">
      		<div class="modal-body body">
       		 

			<div class="spacing">
			<label for="nome">Nome:</label><br> 
			<input name="nome" type="text" maxlength="20" required placeholder="Scrivi nome"><br> 
		</div >
		<div class="spacing"> 
	 		<fieldset>
				<legend>Categoria</legend>
					<label for="categoria">Scegli la categoria</label>
						<select name="categoria" id="categoria">
					
							<option value="PIANTE_VERDI">PIANTE VERDI</option>
							<option value="PIANTE_GRASSE">	PIANTE GRASSE</option>
							<option value="BONSAI">BONSAI</option>
							<option value="PIANTE_FIORITE">PIANTE FIORITE</option>
							<option value="ORCHIDEE">ORCHIDEE</option>
							<option value="TERRARIUM">TERRARIUM</option>
							<option value="VASI">VASI</option>
							<option value="ACCESSORI_PIANTE">ACCESSORI 
					
					
						</select>
			</fieldset>
		</div>
		
	 	
	 	
		<div class="spacing"> 
			<label for="Circonferenza">Circonferenza Vaso:</label><br> 
			<input name="Circonferenza" type="number" min="1" value="1" required><br>
		</div>
		
		<div class="spacing"> 
			<label for="Altezza">Altezza (cm):</label><br> 
			<input name="Altezza" type="number" min="1" value="1" required><br>
		</div>
		
		<div class="spacing"> 
			<label for="breve">Descrizione Breve:</label><br>
			<textarea name="breve" maxlength="100" rows="3" required placeholder="Scrivi breve"></textarea><br>
		</div>
		
		<div class="spacing"> 
			<label for="Completa">Descrizione Completa:</label><br>
			<textarea name="Completa" maxlength="100" rows="3" required placeholder="Scrivi Completa"></textarea><br>
		</div>
		
		<div class="spacing"> 
			<label for="Quantita">Quantità:</label><br> 
			<input name="Quantita" type="number" min="1" value="1" required><br>
		</div>
		
		
		<div class="spacing"> 
			<label for="Base">Prezzo Base:</label><br> 
			<input name="Base" type="number" min="0" value="0" required><br>
		</div>
		
		<div class="spacing"> 
			<label for="Sconto">Sconto:</label><br> 
			<input name="Sconto" type="number" min="0" value="0" required><br>
		</div>
		
		

			 <input type="reset" value="Reset">

		 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary "  data-dismiss="modal"><h6> ANNULLA</h6></button>
        <button type="submit" class="change btn" value="Add"><h6> INSERISCI</h6> </button>
      </div>
      </form>
    </div>
  </div>
</div>
 <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
 
</body>
</html>