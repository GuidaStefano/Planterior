package it.unisa.planterior.controller;

import java.io.IOException;
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

import it.unisa.planterior.model.bean.ProductClass;
import it.unisa.planterior.model.dao.ProductDao;

/**
 * Servlet implementation class CarrelloServlet
 */
@WebServlet("/CarrelloServlet")
public class CatalogoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CatalogoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
			
			if(action.equalsIgnoreCase("insertCarrello")) {
			
			 
				
				 
			}
			 
			else if (action.equals("read")) {
				int id = Integer.parseInt(request.getParameter("id"));
				Optional<ProductClass> a = ProductDao.getInstance().getById(id);
	
				request.setAttribute("product", a);
			}
			
	
	 	}
		List<ProductClass> b = ProductDao.getInstance().getAll();
		
		request.setAttribute("products", b);
		
		
		RequestDispatcher rd=request.getRequestDispatcher("Catalogo.jsp");
		rd.forward(request, response);
		
	}
	}


