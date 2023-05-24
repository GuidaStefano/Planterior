package it.unisa.planterior.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;
import java.util.Optional;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.bean.Order;
import it.unisa.planterior.model.bean.Order.State;
import it.unisa.planterior.model.dao.api.Dao;
import it.unisa.planterior.model.bean.PaymentMethod;
import it.unisa.planterior.model.bean.ShippingAddress;

public class OrderDao extends Dao<Order> {
	
	private static final String TABLE_NAME = "ordine";
	private static final String[] UPDATE_FIELDS = {"stato", "cliente", "metodo_pagamento", "indirizzo_consegna", "totale", 
			"codice_tracking", "data_consegna"};

	private static OrderDao instance;
	
	private OrderDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
	}
	
	public synchronized static OrderDao getInstance() {
		if (instance == null)
			instance = new OrderDao();
		
		return instance;
	}

	@Override
	protected Order parseObject(ResultSet result) throws SQLException {
		Order order = new Order();
		
		order.setId(result.getLong("id"));
		
		State state = State.valueOf(result.getString("stato"));
		order.setState(state);
		
		long customerId = result.getLong("cliente");
		Customer customer = CustomerDao.getInstance().getById(customerId)
				.orElseThrow(() -> new IllegalStateException("inconsistenza dei dari presenti nel database!"));
		order.setCustomer(customer);
		
		long paymentMethodId = result.getLong("metodo_pagamento");
		PaymentMethod paymentMethod = PaymentMethodDao.getInstance().getById(paymentMethodId)
				.orElseThrow(() -> new IllegalStateException("inconsistenza dei dari presenti nel database!"));
		order.setPaymentMethod(paymentMethod);
		
		long shippingAddressId = result.getLong("indirizzo_consegna");
		ShippingAddress shippingAddress = ShippingAddressDao.getInstance().getById(shippingAddressId)
				.orElseThrow(() -> new IllegalStateException("inconsistenza dei dari presenti nel database!"));
		order.setShippingAddress(shippingAddress);
		
		order.setTotalPrice(result.getFloat("totale"));
		
		String trackingCode = result.getString("codice_tracking");
		order.setTrackingCode(result.wasNull() ? null : trackingCode);
		
		java.sql.Date sqlDate = result.getDate("data_consegna");
		Date deliveryDate = result.wasNull() ? null : new Date(sqlDate.getTime());
		order.setDeliveryDate(deliveryDate);
		
		return order;
	}

	@Override
	protected void serializeObject(Order order, PreparedStatement statement) throws SQLException {
		statement.setString(1, order.getState().name());
		statement.setLong(2, order.getCustomer().getId());
		statement.setLong(3, order.getPaymentMethod().getId());
		statement.setLong(4, order.getShippingAddress().getId());
		statement.setFloat(5, order.getTotalPrice());
		
		Optional<String> trackingCode = order.getTrackingCode();
		if (trackingCode.isPresent())
			statement.setString(6, trackingCode.get());
		else
			statement.setNull(6, Types.VARCHAR);
		
		Optional<Date> deliveryDate = order.getDeliveryDate();
		if (deliveryDate.isPresent()) {
			java.sql.Date sqlDate = new java.sql.Date(deliveryDate.get().getTime());
			statement.setDate(7, sqlDate);
		} else {
			statement.setNull(7, Types.DATE);
		}
	}

}
