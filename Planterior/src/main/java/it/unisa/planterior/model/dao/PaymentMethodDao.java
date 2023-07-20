package it.unisa.planterior.model.dao;

import java.sql.Date;
import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.bean.PaymentMethod;
import it.unisa.planterior.model.bean.PaymentMethod.CardCircuit;
import it.unisa.planterior.model.dao.api.Dao;
import it.unisa.planterior.util.DateUtil;

public class PaymentMethodDao extends Dao<PaymentMethod> {

	private static final String TABLE_NAME = "metodo_pagamento";
	private static final String[] UPDATE_FIELDS = {"circuito", "intestatario", "numero_carta", "cvv", "data_scadenza", "cliente"};

	private static PaymentMethodDao instance;
	
	private PaymentMethodDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
		deleteQuery = "UPDATE " + TABLE_NAME + " SET cliente = NULL WHERE id = ?";
	}
	
	public synchronized static PaymentMethodDao getInstance() {
		if (instance == null)
			instance = new PaymentMethodDao();
		
		return instance;
	}
	
	public List<PaymentMethod> getByCustomer(Customer customer) {
		return getAllByField("cliente", customer.getId(), JDBCType.INTEGER);
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
		
		Date sqlDate = result.getDate("data_scadenza");
		ZonedDateTime expirationDate = DateUtil.fromSQLDate(sqlDate);
		paymentMethod.setExpirationDate(expirationDate);
		
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

	@Override
	protected void serializeObject(PaymentMethod paymentMethod, PreparedStatement statement) throws SQLException {
		statement.setString(1, paymentMethod.getCardCircuit().name());
		statement.setString(2, paymentMethod.getOwner());
		statement.setString(3, paymentMethod.getCardNumber());
		statement.setString(4, paymentMethod.getCvv());

		Date sqlDate = DateUtil.toSQLDate(paymentMethod.getExpirationDate());
		statement.setDate(5, sqlDate);
		
		Optional<Customer> customer = paymentMethod.getCustomer();
		if (customer.isPresent()) 
			statement.setLong(6, customer.get().getId());
		else
			statement.setNull(6, Types.INTEGER);
	}
	
}
