package it.unisa.planterior.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.dao.CustomerDao;
import it.unisa.planterior.util.SecurityUtil;

@SuppressWarnings("serial")
@WebServlet(name = "RegistrationServlet", urlPatterns = { "/RegistrationServlet" })
public class RegistrationServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String action =null;
		action=request.getParameter("action");
		System.out.println("sto qui");
		String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Customer.Gender gender = Customer.Gender.valueOf(request.getParameter("gender"));
		
		Date birthDate = parseDate(request.getParameter("birth-date"));
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	 	 String formattedDate = dateFormat.format(birthDate);
	 	 System.out.println("la data è "+birthDate);
	 	 
		String hashedPassword = SecurityUtil.sha256(password); 
		Customer customer = new Customer(name, surname, email, hashedPassword, gender, birthDate);
		System.out.println(customer);
		CustomerDao customerDao = CustomerDao.getInstance();
		if(action!=null) {
			if(action.equals("edit")) {
				//modificare prodotto
				System.out.println(action);
				 
				 Customer user=(Customer)request.getSession().getAttribute("user");
				customer.setId(user.getId());
				if(user.getPassword().equals(password)) {
					customer.setPassword(password);
				}
				System.out.println("id inserito è "+user.getId());
			}
		}else {
			//registrare prodotto
					if (customerDao.getByEmail(email).isPresent()) {
						response.getWriter().println("ALREADY REGISTRED");
						return;
					}
		}
				
					boolean performed = customerDao.save(customer);
					
					if (performed && action!=null) {
						request.getSession().setAttribute("user",customer);
						response.sendRedirect( "index.jsp ");
					} else if (performed) {
						response.getWriter().println("REGISTRATO");
					} else {
						response.getWriter().println("ERRORE");
					}
					
					
	}
	
	private Date parseDate(String string) {
		try {
			Date birthDate = new SimpleDateFormat("yyyy-MM-dd").parse(string);
			return birthDate;
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
}
