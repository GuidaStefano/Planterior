package it.unisa.planterior.model.dao;

import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Optional;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.bean.PaymentMethod;
import it.unisa.planterior.model.bean.PaymentMethod.CardCircuit;
import it.unisa.planterior.model.dao.api.Dao;

public class PaymentMethodDao extends Dao<PaymentMethod> {

	private static final String TABLE_NAME = "metodo_pagamento";
	private static final String[] UPDATE_FIELDS = {"circuito", "intestatario", "numero_carta", "cvv", "cliente"};

	private static PaymentMethodDao instance;
	
	private PaymentMethodDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
	}
	
	public synchronized static PaymentMethodDao getInstance() {
		if (instance == null)
			instance = new PaymentMethodDao();
		
		return instance;
	}

	@Override
	protected PaymentMethod parseObject(ResultSet result) throws SQLException {
		PaymentMethod paymentMethod = new PaymentMethod();
		
		paymentMethod.setId(result.getLong("id"));
		
		CardCircuit cardCircuit = CardCircuit.valueOf(result.getString("circuito"));
		paymentMethod.setCardCircuit(cardCircuit);
		
		paymentMethod.setOwner(result.getString("intestatario"));
		paymentMethod.setCardNumber(result.getString("numero_carta"));
		paymentMethod.setCvv(result.getString("cvv"));
		
		long customerId = result.getLong("cliente");
		Optional<Customer> customer;
		if (result.wasNull()) {
			customer = Optional.empty();
		} else {
			CustomerDao customerDao = CustomerDao.getInstance();
			customer = customerDao.getById(customerId);
		}
		paymentMethod.setCustomer(customer);
		
		return paymentMethod;
	}
	
	public Optional<PaymentMethod> getByCarta(String numero_carta) {
		return getFirstByField("numero_carta", numero_carta, JDBCType.VARCHAR);
	}

	@Override
	protected void serializeObject(PaymentMethod paymentMethod, PreparedStatement statement) throws SQLException {
		statement.setString(1, paymentMethod.getCardCircuit().name());
		statement.setString(2, paymentMethod.getOwner());
		statement.setString(3, paymentMethod.getCardNumber());
		statement.setString(4, paymentMethod.getCvv());
		
		Optional<Customer> customer = paymentMethod.getCustomer();
		if (customer.isPresent()) 
			statement.setLong(5, customer.get().getId());
		else
			statement.setNull(5, Types.INTEGER);
	}
	
}
