package it.unisa.planterior.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.planterior.model.bean.Product;
import it.unisa.planterior.model.dao.ProductDao;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private static final String MAX_AMOUNT_ATTR = "is-max-amount";

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action == null) return;
		
		boolean ajax = request.getParameter("ajax") != null;
		
		if (action.equalsIgnoreCase("add") || action.equalsIgnoreCase("remove")) {
			String productIdStr = request.getParameter("id");
			if (productIdStr == null) return;
			
			long productId = Long.parseLong(productIdStr);
			
			String amountStr = request.getParameter("amount");
			short amount = amountStr == null ? 1 : Short.parseShort(amountStr);
			
			Map<Long, Short> cart = getCart(request);

			if (action.equalsIgnoreCase("add")) {
				if (cart.containsKey(productId)) {
					short previousAmount = cart.get(productId);
					amount += previousAmount;
				}
				
				Product product = ProductDao.getInstance().getById(productId).get();
				if (amount > product.getAvailableAmount()) {
					amount = product.getAvailableAmount();
					request.getSession().setAttribute(MAX_AMOUNT_ATTR, true);
				}
				
				cart.put(productId, amount);
			} else { // action = "remove"
				if (!cart.containsKey(productId)) return;
					
				short previousAmount = cart.get(productId);
				amount = (short) Math.max(previousAmount - amount, 0);
				
				if (amount == 0) {
					cart.remove(productId);
				} else
					cart.put(productId, amount);
			}
			
			if (ajax) {
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				
				Product product = ProductDao.getInstance().getById(productId).get(); // sicuramente presente
				float productPrice = product.getPrice() * amount;
				float totalPrice = getCartTotalPrice(request);
				
				boolean isMaxAmount = false;
				if (request.getSession().getAttribute(MAX_AMOUNT_ATTR) != null) {
					request.getSession().removeAttribute(MAX_AMOUNT_ATTR);
					isMaxAmount = true;
					
				}
				
				String jsonResponse = String.format(Locale.US, "{\"amount\": %d, \"isMaxAmount\": %b, \"productPrice\": %f, \"totalPrice\": %f}",
						amount, isMaxAmount, productPrice, totalPrice);
				out.write(jsonResponse);
			} else {
				response.sendRedirect("cart.jsp");
			}
		} else if (action.equalsIgnoreCase("checkout")) {
			response.sendRedirect("checkout.jsp");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private float getCartTotalPrice(HttpServletRequest request) {
		Map<Long, Short> cart = getCart(request);
		
		float totalPrice = 0f;
		for (Entry<Long, Short> entry : cart.entrySet()) {
			long productId = entry.getKey();
			short amount = entry.getValue();
			
			Optional<Product> optProduct = ProductDao.getInstance().getById(productId);
			if (optProduct.isEmpty()) continue;
			
			Product product = optProduct.get();
			
			totalPrice += product.getPrice() * amount;
		}
		
		return totalPrice;
	}
	
	@SuppressWarnings("unchecked")
	private Map<Long, Short> getCart(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("cart") == null) 
			session.setAttribute("cart", new HashMap<Long, Short>());
		
		return (HashMap<Long, Short>) session.getAttribute("cart");
	}

}
