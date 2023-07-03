package it.unisa.planterior.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.dao.CustomerDao;

@WebServlet("/check-email")
public class CheckEmailServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String email = (String) request.getParameter("email");
		 
		Optional<Customer> customer = CustomerDao.getInstance().getByEmail(email);
		out.println(customer.isPresent() ? 1 : 0);
	}
}
