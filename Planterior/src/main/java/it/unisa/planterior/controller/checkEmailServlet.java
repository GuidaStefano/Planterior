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

/**
 * Servlet implementation class checkEmailServlet
 */
@WebServlet("/checkEmailServlet")
public class checkEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public checkEmailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		
		String email = (String)request.getParameter("email");
		 
		CustomerDao customerDao = CustomerDao.getInstance();
		System.out.println(email);
		Optional<Customer> optionalCustomer = customerDao.getByEmail(email);
		if(optionalCustomer.isEmpty()){
			//non è presente nel database
			System.out.println("non c'è nel db");
			out.println(0);
			
		}else { //  è presente nel database
			out.println(1);
		}
		
		   
		 
		
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
}
