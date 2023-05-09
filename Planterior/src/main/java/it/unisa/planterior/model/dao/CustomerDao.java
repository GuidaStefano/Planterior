package it.unisa.planterior.model.dao;

import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Optional;

import it.unisa.planterior.model.bean.Customer;

public class CustomerDao extends Dao<Customer> {

	private static final String TABLE_NAME = "cliente";
	private static final String[] UPDATE_FIELDS = {"nome", "cognome", "email", "pass", "sesso", "data_nascita", "amministratore"};
	
	private static CustomerDao instance;
	
	private CustomerDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
	}
	
	public synchronized static CustomerDao getInstance() {
		if (instance == null)
			instance = new CustomerDao();
		
		return instance;
	}
	
	public Optional<Customer> getByEmail(String email) {
		return getFirstByField("email", email, JDBCType.VARCHAR);
	}
	
	@Override
	protected Customer parseObject(ResultSet result) throws SQLException {
		Customer customer = new Customer();
		
		customer.setId(result.getLong("id"));
		customer.setName(result.getString("nome"));
		customer.setSurname(result.getString("cognome"));
		customer.setEmail(result.getString("email"));
		customer.setPassword(result.getString("pass"));
		
		Customer.Gender gender = Customer.Gender.valueOf(result.getString("sesso"));
		customer.setGender(gender);
		
		java.sql.Date sqlDate = result.getDate("data_nascita");
		Date birthDate = new Date(sqlDate.getTime());
		customer.setBirthDate(birthDate);
		
		customer.setAdministrator(result.getBoolean("amministratore"));
		
		// TODO 
		customer.setFavourites(new HashSet<>());
		customer.setCart(new HashMap<>());
		
		return customer;
	}

	@Override
	protected void serializeObject(Customer customer, PreparedStatement statement) throws SQLException {
		statement.setString(1, customer.getName());
		statement.setString(2, customer.getSurname());
		statement.setString(3, customer.getEmail());
		statement.setString(4, customer.getPassword());
		statement.setString(5, customer.getGender().name());
		
		java.sql.Date sqlDate = new java.sql.Date(customer.getBirthDate().getTime());
		statement.setDate(6, sqlDate);
		
		statement.setBoolean(7, customer.isAdministrator());
	}
	
}
