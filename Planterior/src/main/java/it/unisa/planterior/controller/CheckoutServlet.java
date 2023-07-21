package it.unisa.planterior.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.bean.Order;
import it.unisa.planterior.model.bean.OrderItem;
import it.unisa.planterior.model.bean.PaymentMethod;
import it.unisa.planterior.model.bean.Product;
import it.unisa.planterior.model.bean.ShippingAddress;
import it.unisa.planterior.model.dao.OrderDao;
import it.unisa.planterior.model.dao.PaymentMethodDao;
import it.unisa.planterior.model.dao.ProductDao;
import it.unisa.planterior.model.dao.ShippingAddressDao;

@WebServlet("/checkout")
@SuppressWarnings("unchecked")
public class CheckoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Order order = fetchOrder(request);
		if (order == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		
		long orderId = OrderDao.getInstance().saveAndReturnGeneratedId(order);
		
		
		Map<Long, Short> cart = (Map<Long, Short>) request.getSession().getAttribute("cart");
		cart.clear();
		
		response.sendRedirect("invoice.jsp?order-id=" + orderId + "&redirect-index=true");
	}
	
	private Order fetchOrder(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session == null || session.getAttribute("user") == null || session.getAttribute("cart") == null)
			return null;
		
		String addressIdStr = request.getParameter("address");
		if (addressIdStr == null) return null;
		
		String paymentMethodIdStr = request.getParameter("payment-method");
		if (paymentMethodIdStr == null) return null;
		 
		Customer customer = (Customer) session.getAttribute("user");
		
		long addressId = Long.parseLong(addressIdStr);
		ShippingAddress address = ShippingAddressDao.getInstance().getById(addressId).orElse(null);
		
		long paymentMethodId = Long.parseLong(paymentMethodIdStr);
		PaymentMethod paymentMethod = PaymentMethodDao.getInstance().getById(paymentMethodId).orElse(null);
		
		if (address == null || paymentMethod == null)
			return null;
		
		Set<OrderItem> items = new HashSet<>();
		Map<Long, Short> cart = (Map<Long, Short>) session.getAttribute("cart");
		cart.forEach((productId, amount) -> {
			Optional<Product> optProduct = ProductDao.getInstance().getById(productId);
			if (optProduct.isEmpty()) return;
			
			Product product = optProduct.get();
			OrderItem item = new OrderItem(productId, amount, product.getPrice());
			product.setAvailableAmount((short) (product.getAvailableAmount() - amount));
			ProductDao.getInstance().save(product);
			items.add(item);
		});
		
		return new Order(customer, paymentMethod, address, items);
	}
}
