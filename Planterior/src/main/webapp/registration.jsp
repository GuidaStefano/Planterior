<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<form action="RegistrationServlet" method="POST">
			<table>
				<tr>
					<td>
						<label for="name">Nome:</label>
					</td>
					<td>
						<input type="text" name="name" required />
					</td>
				</tr>
				<tr>
					<td>
						<label for="surname">Cognome:</label>
					</td>
					<td>
						<input type="text" name="surname" required />
					</td>
				</tr>
				<tr>
					<td>
						<label for="email">Email:</label>
					</td>
					<td>
						<input type="text" name="email" required />
					</td>
				</tr>
				<tr>
					<td>
						<label for="password">Password:</label>
					</td>
					<td>
						<input type="password" name="password" required />	
					</td>
				</tr>
				<tr>
					<td>
						<label for="gender">Sesso:</label>
					</td>
					<td>
						<input type="radio" id="gender-m" name="gender" value="M" required />
						<label for="gender-m">Uomo</label>
						<input type="radio" id="gender-f" name="gender" value="F" />
						<label for="gender-f">Donna</label>
					</td>
				</tr>
				<tr>
					<td>
						<label for="birth-date">Data di nascita:</label>
					</td>
					<td>
						<input type="date" name="birth-date" min="1900-01-01" max="2022-12-31" required />	
					</td>
				</tr>
				<tr>
					<td>
						<input type="reset" value="PULISCI CAMPI" />
					</td>
					<td>
						<input type="submit" value="REGISTRATI" />
					</td>
				</tr>
				
			</table>
		</form>
	</body>
</html>