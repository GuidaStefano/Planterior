<%@page import="it.unisa.planterior.util.PathUtil"%>
<%@page import="it.unisa.planterior.util.DateUtil"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="it.unisa.planterior.model.bean.Customer"%>
<%@page import="it.unisa.planterior.model.dao.* "%>
<%@ page import="java.util.*,it.unisa.planterior.model.bean.* "%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<%
	if (session.getAttribute("user") == null || session == null) {
 		response.sendRedirect("authentication.jsp");
 		return;
	}

	Customer customer = (Customer) session.getAttribute("user");
	
	String orderIdStr = request.getParameter("order-id");
	if (orderIdStr == null) {
		response.sendRedirect(customer.isAdministrator() ? "user-dashboard.jsp" : "personal-area.jsp");
		return;
	}
	
	long orderId = Long.parseLong(orderIdStr);
	Optional<Order> optOrder = OrderDao.getInstance().getById(orderId);
	
	if (optOrder.isEmpty()) {
		response.sendRedirect(customer.isAdministrator() ? "user-dashboard.jsp" : "personal-area.jsp");
		return;
	}
	
	Order order = optOrder.get();
	
	if (!customer.isAdministrator() && !order.getCustomer().equals(customer)) {
		response.sendRedirect("personal-area.jsp");
		return;
	}
	
	boolean redirectIndex = request.getParameter("redirect-index") != null;
%>
 
<%!
	public String encodeCardNumber(String cardNumber) {
		return "**** **** **** " + cardNumber.substring(12, 16);
	}
%>
 
<!DOCTYPE html>
<html lang="it">
	<head>
		<link rel="stylesheet" href="asset/style/text-style.css" />
        <link rel="stylesheet" href="asset/style/administrator-style.css">
        <link rel="stylesheet" href="asset/style/number-input-style.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>
 		<title>Fattura ordine - <%= orderId %></title>
	</head>
	<body>
		<%@ include file="header.jsp" %>
		<div class="wrapper">
			<a href=<%= redirectIndex ? "index.jsp" : "order-info.jsp?order-id=" + orderId%>>
				<button class="icon-button no-padding" style="margin-bottom: 20px;">
					<i class="fa-solid fa-arrow-left fa-l"></i>
					<span>Indietro</span>
				</button>
			</a>
			<div id="pdf-container">
				<div class="h-box" style="justify-content: end;">
					<div class="v-box">
						<p>Planterior S.R.L.</p>
						<p>Via Rubino Nicodemi 55, 84084, Fisciano (SA)</p>
						<p>C.F. 00 0000 0000 00</p>
						<p>P.IVA 00 0000 0000 00</p>
					</div>
				</div>
				<div class="v-box page-content" style="margin-bottom: 40px;">
					<h1>FATTURA ORDINE - #<%= orderId %></h1>
					<div class="v-box" style="row-gap: 15px;">
						<div class="v-box">
							<h3>Indirizzo di spedizione</h3>
							<h4><%= order.getShippingAddress().getStreet() %>, <%= order.getShippingAddress().getHouseNumber() %></h4>
							<h4><%= order.getShippingAddress().getPostalCode() %></h4>
						</div>
						<div class="v-box">
							<h3>Metodo di pagamento</h3>
							<h4><%= order.getPaymentMethod().getOwner() %></h4>
							<h4><%= encodeCardNumber(order.getPaymentMethod().getCardNumber()) %></h4>
							<h4><%= order.getPaymentMethod().getCardCircuit().toString() %></h4>
						</div>
					</div>
	        		<div class="v-box table">
						<div class="h-box table-header">
							<div class="table-col h-box justify-center">
								<h3>IMMAGINE</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>ID PRODOTTO</h3> 
							</div>
							<div class="table-col h-box justify-center mobile-col">
								<h3>NOME PRODOTTO</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>QUANTITA'</h3> 
							</div>
							<div class="table-col h-box justify-center">
								<h3>PREZZO</h3> 
							</div>
						</div>
							<%
								for (OrderItem item : order.getItems()) {
									Product product = ProductDao.getInstance().getById(item.getProductId()).get();
							%>
							<div class="h-box table-row">
									<div class="table-col">
										<img alt="Immagine prodotto" width="60" height="60" src=<%= PathUtil.getMainImagePath(product.getId()) %> />
									</div>
									<div class="table-col">
										<h4 class="center-in-parent"><%= product.getId() %></h4>
									</div>
									<div class="table-col">
										<h4 class="center-in-parent"><%= product.getName() %></h4>
									</div>
									<div class="table-col">
										<h4 class="center-in-parent"><%= item.getAmount() %></h4>
									</div>
									<div class="table-col">
										<h4 class="center-in-parent"><%= item.getUnitPrice() * item.getAmount() %>€</h4>
									</div>
								</div> 
							<% } %>	
					</div>
				</div>
				<div class="h-box" style="justify-content: end; column-gap: 20px;">
		     		<h5>PREZZO TOTALE</h5>
		        	<h3 class="prezzoTotale"><%= order.getTotalPrice() %>€</h3>
				</div>
			</div>
			<div class="h-box" style="justify-content: end; margin-top: 20px;">
				<button id="generate-btn" style="width: 160px; align-items: baseline;" class="big-button static-btn h-box">
					<h6>SCARICA PDF</h6> 					
					<i class="fa-solid fa-download" style="color: white;"></i>
				</button>
			</div>
		</div>
		<script type="text/javascript">
			window.html2canvas = html2canvas;

			window.jsPDF = window.jspdf.jsPDF;

			function generatePDF() {
				// Ottieni il contenitore HTML che vuoi convertire in PDF
				var container = document.getElementById('pdf-container');

				// Crea un oggetto jsPDF
				var doc = new jsPDF();

				// Converti il contenitore HTML in un'immagine canvas utilizzando html2canvas
				html2canvas(container).then(function(canvas) {
					// Ottieni l'URL dell'immagine canvas
					var imgData = canvas.toDataURL('image/png');

					// Aggiungi l'immagine al PDF
					doc.addImage(imgData, 'PNG', 10, 10, 190, 0);

					// Salva il PDF con il nome "output.pdf"
					doc.save('Fattura ordine #<%= order.getId() %>.pdf');
				});
			}

			// Eseguire la funzione quando si fa clic su un pulsante "Genera PDF"
			document.getElementById('generate-btn').addEventListener('click',
				generatePDF);
	 
		</script>
        <%@ include file="footer.jsp" %>  
	</body>
</html>