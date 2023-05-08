package it.unisa.planterior.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.dao.CustomerDao;
import it.unisa.planterior.util.SecurityUtil;

@SuppressWarnings("serial")
@WebServlet(name = "LoginServlet", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		String email = request.getParameter("email");
		String password = SecurityUtil.sha256(request.getParameter("password"));
		 
		CustomerDao customerDao = CustomerDao.getInstance();
		Optional<Customer> optionalCustomer = customerDao.getByEmail(email);
		
		if (optionalCustomer.isPresent()) {
			Customer customer = optionalCustomer.get();
			if (customer.getPassword().equals(password)) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
				dispatcher.forward(request, response);
			} else {
				out.println("<font color=red size18>Login Failed<br>");
				out.println("<a href=login.jsp>Try Again</a>");
			}
		} else {
			out.println("nessun cliente trovato!");
		}
		
	}
}
	


