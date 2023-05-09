<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.planterior.model.bean.ProductClass"%>

<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="InsertServlet" method="post">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="nome">Nome:</label><br> 
		<input name="nome" type="text" maxlength="20" required placeholder="Scrivi nome"><br> 
		
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
		
	 	
	 	
		
		<label for="Circonferenza">Circonferenza Vaso:</label><br> 
		<input name="Circonferenza" type="number" min="1" value="1" required><br>
		
		<label for="Altezza">Altezza (cm):</label><br> 
		<input name="Altezza" type="number" min="1" value="1" required><br>
	
	
		<label for="breve">Descrizione Breve:</label><br>
		<textarea name="breve" maxlength="100" rows="3" required placeholder="Scrivi breve"></textarea><br>
		
		<label for="Completa">Descrizione Completa:</label><br>
		<textarea name="Completa" maxlength="100" rows="3" required placeholder="Scrivi Completa"></textarea><br>
		
		<label for="Quantita">Quantità:</label><br> 
		<input name="Quantita" type="number" min="1" value="1" required><br>
		
		
		<label for="Base">Prezzo Base:</label><br> 
		<input name="Base" type="number" min="0" value="0" required><br>
		
		<label for="Sconto">Sconto:</label><br> 
		<input name="Sconto" type="number" min="0" value="0" required><br>
		
		
		

		<input type="submit" value="Add"><input type="reset" value="Reset">

	</form>
</body>
</html>