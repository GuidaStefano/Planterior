package it.unisa.planterior.model.dao;

import java.sql.Connection;
import java.sql.JDBCType;
import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;

import it.unisa.planterior.model.bean.OrderItem;
import it.unisa.planterior.model.dao.api.Dao;
import it.unisa.planterior.util.SecurityUtil;

public class CompositionDao extends Dao<OrderItem> {

	private static final String TABLE_NAME = "composizione";
	private static final String[] UPDATE_FIELDS = {"id", "prodotto", "quantita", "prezzo_unitario"};
	
	private static CompositionDao instance;
	
	private CompositionDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
	}
	
	public synchronized static CompositionDao getInstance() {
		if (instance == null)
			instance = new CompositionDao();
		
		return instance;
	}
	
	public List<OrderItem> getByOrder(long order) {
		return getAllByField("id", order, JDBCType.VARCHAR);
	}
	
	@Override
	protected OrderItem parseObject(ResultSet result) throws SQLException {
		OrderItem item = new OrderItem();
		
		item.setId(result.getLong("id"));
		item.setProductId(result.getLong("prodotto"));
		item.setAmount(result.getShort("quantita"));
		item.setUnitPrice(result.getFloat("prezzo_unitario"));
	
		return item;
	}

	@Override
	protected void serializeObject(OrderItem item, PreparedStatement statement) throws SQLException {
		statement.setLong(1, item.getId());
		statement.setLong(2, item.getProductId());
		statement.setShort(3, item.getAmount());
		statement.setFloat(4, item.getUnitPrice());
	}
	
    @Override
    public boolean save(OrderItem obj) {
		try (Connection connection = dataSource.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(insertQuery);
			serializeObject(obj, statement);

			return statement.executeUpdate() == 1;
		} catch (SQLException e) {
			SecurityUtil.LOGGER.log(Level.SEVERE, e.getMessage());
			return false;
		}
    }
    
    @Override
    public long saveAndReturnGeneratedId(OrderItem obj) {
    	throw new IllegalArgumentException("not supported");
    }

}
