package it.unisa.planterior.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.bean.ShippingAddress;
import it.unisa.planterior.model.dao.ShippingAddressDao;

@WebServlet("/edit-addresses")
public class EditAddressesServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if (action == null)
			return;
		
		if (action.equalsIgnoreCase("add")) {
			ShippingAddress address = fetchAddress(request);
			ShippingAddressDao.getInstance().save(address);
		} else if (action.equalsIgnoreCase("delete")) {
			String addressIdStr = request.getParameter("id");
			if (addressIdStr == null)
				return;
			
			long addressId = Long.parseLong(addressIdStr);
			ShippingAddressDao.getInstance().delete(addressId);
		}
		
		String redirectPage = "addresses.jsp";
		if (request.getParameter("redirect") != null)
			redirectPage = request.getParameter("redirect");
		
		response.sendRedirect(redirectPage);
	}
	
	private ShippingAddress fetchAddress(HttpServletRequest request) {
		String street = request.getParameter("street");
		short houseNumber = Short.parseShort(request.getParameter("house-number"));
		String postalCode = request.getParameter("postal-code");
		
		HttpSession session = request.getSession();
		Customer customer = session == null || session.getAttribute("user") == null ? null : (Customer) session.getAttribute("user");
		
		return new ShippingAddress(street, houseNumber, postalCode, customer);
	}
}
