package it.unisa.planterior.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;

import it.unisa.planterior.model.bean.Customer;
import it.unisa.planterior.model.bean.Order;
import it.unisa.planterior.model.bean.Order.State;
import it.unisa.planterior.model.bean.OrderItem;
import it.unisa.planterior.model.dao.api.Dao;
import it.unisa.planterior.util.DateUtil;
import it.unisa.planterior.model.bean.PaymentMethod;
import it.unisa.planterior.model.bean.ShippingAddress;

public class OrderDao extends Dao<Order> {
	
	private static final String TABLE_NAME = "ordine";
	private static final String[] UPDATE_FIELDS = {"stato", "cliente", "metodo_pagamento", "indirizzo_consegna", "totale", 
			"data_ordine", "codice_tracking"};

	private static OrderDao instance;
	
	private OrderDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
	}
	
	public synchronized static OrderDao getInstance() {
		if (instance == null)
			instance = new OrderDao();
		
		return instance;
	}
	
	public List<Order> getByCliente(long  cliente) {
		return getAllByField("cliente", cliente, JDBCType.VARCHAR);
	}

	@Override
	protected Order parseObject(ResultSet result) throws SQLException {
		Order order = new Order();
		
		long orderId = result.getLong("id");
		order.setId(orderId);
		
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
		
		Date sqlDate = result.getDate("data_ordine");
		ZonedDateTime orderDate = DateUtil.fromSQLDate(sqlDate);
		order.setOrderDate(orderDate);
		
		String trackingCode = result.getString("codice_tracking");
		order.setTrackingCode(result.wasNull() ? null : trackingCode);
		
		order.setItems(new HashSet<>());
		
		List<OrderItem> items = CompositionDao.getInstance().getByOrder(orderId);
		items.forEach(order.getItems()::add);
		
		return order;
	}

	@Override
	protected void serializeObject(Order order, PreparedStatement statement) throws SQLException {
		statement.setString(1, order.getState().name());
		statement.setLong(2, order.getCustomer().getId());
		statement.setLong(3, order.getPaymentMethod().getId());
		statement.setLong(4, order.getShippingAddress().getId());
		statement.setFloat(5, order.getTotalPrice());
		
		Date sqlDate = DateUtil.toSQLDate(order.getOrderDate());
		statement.setDate(6, sqlDate);
		
		Optional<String> optTrackingCode = order.getTrackingCode();
		if (optTrackingCode.isPresent()) 
			statement.setString(7, optTrackingCode.get());
		else
			statement.setNull(7, Types.VARCHAR);
	}
	
    @Override
    public boolean save(Order order) {
    	return saveAndReturnGeneratedId(order) != -1;
    }
    
    @Override
    public long saveAndReturnGeneratedId(Order order) {
		try (Connection connection = dataSource.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(order.getId() == -1 ? insertQuery : updateQuery, 
					Statement.RETURN_GENERATED_KEYS);
			serializeObject(order, statement);
			
			if (order.getId() != -1)
				statement.setLong(updateFields.length + 1, order.getId());
			
			if (statement.executeUpdate() != 1) return -1;
			
			ResultSet generatedKeys = statement.getGeneratedKeys();
			if (generatedKeys == null || !generatedKeys.next()) return -1;
			
			long orderId = generatedKeys.getLong(1);
			
			for (OrderItem item : order.getItems()) {
				item.setId(orderId);
				CompositionDao.getInstance().save(item);
			}
			
			return orderId;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
    }

}
