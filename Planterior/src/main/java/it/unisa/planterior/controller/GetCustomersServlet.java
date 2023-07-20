package it.unisa.planterior.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.dao.CustomerDao;

@SuppressWarnings("serial")
@WebServlet("/get-customers")
public class GetCustomersServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String serachString = request.getParameter("search");
		List<Customer> customers = CustomerDao.getInstance().getAllByLikey("%" + serachString + "%");
	
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		StringBuilder jsonBuilder = new StringBuilder();
		jsonBuilder.append("{\"customers\": [");
		for (int i = 0; i < customers.size(); i++) {
			jsonBuilder.append(customers.get(i).getId());
			if (i < customers.size() - 1)
				jsonBuilder.append(", ");
		}
		
		jsonBuilder.append("]}");
		
		out.write(jsonBuilder.toString());
	}
}
