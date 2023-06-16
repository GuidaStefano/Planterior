package it.unisa.planterior.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.planterior.model.dao.ProductDao;

@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String productIdString = request.getParameter("id");
		
		if (action == null || productIdString == null)
			return;
		
		long productId = Long.parseLong(productIdString);
		
		switch (action.toLowerCase()) {
			case "delete":
				ProductDao.getInstance().delete(productId);
				response.sendRedirect("administrator.jsp");
				break;
			case "edit":
				break;
		}
	}
}
