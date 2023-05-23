package it.unisa.planterior.controller;

import java.io.IOException;
 
import it.unisa.planterior.model.bean.*;
import it.unisa.planterior.model.dao.*;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class InsertServlet
 */
@WebServlet("/InsertServlet")
public class InsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doPost(request,response);
    }
    

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		
		
		if (action!=null) {
			
			if(action.equalsIgnoreCase("insert")) {
			
			
				String Nome=request.getParameter("nome");		
				String categoria=request.getParameter("categoria");	
				String breve=request.getParameter("breve");	
				String Completa=request.getParameter("Completa");	
				float Circonferenza = (float)Integer.parseInt(request.getParameter("Circonferenza"));
				float Altezza = (float)Integer.parseInt(request.getParameter("Altezza"));
				float Base = (float)Integer.parseInt(request.getParameter("Base"));
				float Sconto = (float)Integer.parseInt(request.getParameter("Sconto"));
				short Quantita = Short.parseShort(request.getParameter("Quantita"));
				
				Product prodotto= new Product(Nome ,  categoria,  breve,  Completa,   Circonferenza, Altezza  ,  Base ,  Sconto ,  Quantita);
				ProductDao.getInstance().save(prodotto);
				
				
				 
			}
			else if(action.equalsIgnoreCase("delete")) {
				int id = Integer.parseInt(request.getParameter("id"));
				ProductDao.getInstance().delete(id);
		
			}
			else if (action.equals("read")) {
				int id = Integer.parseInt(request.getParameter("id"));
				Optional<Product> a = ProductDao.getInstance().getById(id);
	
				request.setAttribute("product", a);
			}
			
	
	 	}
		List<Product> b = ProductDao.getInstance().getAll();
		
		request.setAttribute("products", b);
		
		
		RequestDispatcher rds=request.getRequestDispatcher("amministratore.jsp");
		rds.forward(request, response);
		
	}
}
