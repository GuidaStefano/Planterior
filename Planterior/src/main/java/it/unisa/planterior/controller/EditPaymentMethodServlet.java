package it.unisa.planterior.controller;

import java.io.IOException;
import java.time.ZonedDateTime;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.bean.PaymentMethod;
import it.unisa.planterior.model.bean.PaymentMethod.CardCircuit;
import it.unisa.planterior.model.dao.PaymentMethodDao;
import it.unisa.planterior.util.DateUtil;

@WebServlet("/edit-payment-method")
public class EditPaymentMethodServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if (action == null)
			return;
		
		if (action.equalsIgnoreCase("add")) {
			PaymentMethod method = fetchPaymentMethod(request);
			PaymentMethodDao.getInstance().save(method);
		} else if (action.equalsIgnoreCase("delete")) {
			String methodIdStr = request.getParameter("id");
			if (methodIdStr == null)
				return;
			
			long methodId = Long.parseLong(methodIdStr);
			PaymentMethodDao.getInstance().delete(methodId);
		}
		
		String redirectPage = "payment-methods.jsp";
		if (request.getParameter("redirect") != null)
			redirectPage = request.getParameter("redirect");
		
		response.sendRedirect(redirectPage);
	}
	
	private PaymentMethod fetchPaymentMethod(HttpServletRequest request) {
		CardCircuit circuit = CardCircuit.valueOf(request.getParameter("circuit"));
		String cardOwner = request.getParameter("card-owner");
		String cardNumber = request.getParameter("card-number").replace(" ", "");
		String cvv = request.getParameter("cvv");
		ZonedDateTime expirationDate = adaptExpirationDate(request.getParameter("expiration-date"));
		
		HttpSession session = request.getSession();
		Customer customer = session == null || session.getAttribute("user") == null ? null : (Customer) session.getAttribute("user");

		return new PaymentMethod(circuit, cardOwner, cardNumber, cvv, expirationDate, customer);
	}
	
	private ZonedDateTime adaptExpirationDate(String expirationDate) {
		return DateUtil.parse(expirationDate + "-01"); 
	}
}
