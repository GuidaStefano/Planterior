package it.unisa.planterior.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.ZonedDateTime;
import java.util.Date;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.dao.CustomerDao;
import it.unisa.planterior.util.DateUtil;
import it.unisa.planterior.util.SecurityUtil;

@SuppressWarnings("serial")
@WebServlet(name = "registrati", urlPatterns = { "/RegistrationServlet" })
public class RegistrationServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String action = request.getParameter("action");

		String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Customer.Gender gender = Customer.Gender.valueOf(request.getParameter("gender"));
		
		ZonedDateTime birthDate = DateUtil.parse(request.getParameter("birth-date"));
	 	 
		String hashedPassword = SecurityUtil.sha256(password); 
		Customer customer = new Customer(name, surname, email, hashedPassword, gender, birthDate);
		
		CustomerDao customerDao = CustomerDao.getInstance();
		if(action != null) {
			if(action.equals("edit")) {
				 
				 Customer user=(Customer)request.getSession().getAttribute("user");
				customer.setId(user.getId());
				if(user.getPassword().equals(password)) {
					customer.setPassword(password);
				}
			}
		}else {
			//registrare prodotto
					if (customerDao.getByEmail(email).isPresent()) {
						request.getSession(true).setAttribute("error-message-r", "Utente già registrato");
						response.sendRedirect("authentication.jsp");
						return;
					}
		}
				
					long customerId = customerDao.saveAndReturnGeneratedId(customer);
					
					if (customerId != -1) {
						customer.setId(customerId);
				 		HttpSession session = request.getSession(true);
				 		session.setAttribute("user", customer);
			 	
				 		response.sendRedirect("index.jsp");
					} else {
						request.getSession(true).setAttribute("error-message-r", "Si è verificato un errore");
						response.sendRedirect("authentication.jsp");
					}
				
	}
	
}
