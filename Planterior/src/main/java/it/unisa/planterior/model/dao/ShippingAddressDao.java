package it.unisa.planterior.model.dao;

import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Optional;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.bean.ShippingAddress;
import it.unisa.planterior.model.dao.api.Dao;

public class ShippingAddressDao extends Dao<ShippingAddress> {

	private static final String TABLE_NAME = "indirizzo_consegna";
	private static final String[] UPDATE_FIELDS = {"via", "civico", "cap", "cliente"};
	
	private static ShippingAddressDao instance;
	
	private ShippingAddressDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
		deleteQuery = "UPDATE " + TABLE_NAME + " SET cliente = NULL WHERE id = ?";
	}
	
	public static synchronized ShippingAddressDao getInstance() {
		if (instance == null)
			instance = new ShippingAddressDao();
		
		return instance;
	}
	
	public List<ShippingAddress> getByCustomer(Customer customer) {
		return getAllByField("cliente", customer.getId(), JDBCType.INTEGER);
	}

	@Override
	protected ShippingAddress parseObject(ResultSet result) throws SQLException {
		ShippingAddress shippingAddress = new ShippingAddress();
		
		shippingAddress.setId(result.getLong("id"));
		shippingAddress.setStreet(result.getString("via"));
		shippingAddress.setHouseNumber(result.getShort("civico"));
		shippingAddress.setPostalCode(result.getString("cap"));
		
		long customerId = result.getLong("cliente");
		Optional<Customer> customer;
		if (result.wasNull()) {
			customer = Optional.empty();
		} else {
			CustomerDao customerDao = CustomerDao.getInstance();
			customer = customerDao.getById(customerId);
		}
		shippingAddress.setCustomer(customer);
		
		return shippingAddress;
	}

	public List<ShippingAddress> getByShippingAddress(String via) {
		return getAllByField("via", via, JDBCType.VARCHAR);
	}

	
	@Override
	protected void serializeObject(ShippingAddress shippingAddress, PreparedStatement statement) throws SQLException {
		statement.setString(1, shippingAddress.getStreet());
		statement.setShort(2, shippingAddress.getHouseNumber());
		statement.setString(3, shippingAddress.getPostalCode());
		
		Optional<Customer> customer = shippingAddress.getCustomer();
		if (customer.isPresent())
			statement.setLong(4, customer.get().getId());
		else
			statement.setNull(4, Types.INTEGER);
	}
	
}
