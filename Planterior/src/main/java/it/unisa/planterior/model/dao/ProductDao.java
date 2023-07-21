package it.unisa.planterior.model.dao;

import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import it.unisa.planterior.model.bean.Product;
import it.unisa.planterior.model.bean.Product.Subcategory;
import it.unisa.planterior.model.dao.api.Dao;

public class ProductDao extends Dao<Product> {

	private static final String TABLE_NAME = "prodotto";
	private static final String[] UPDATE_FIELDS = {"nome", "categoria", "descrizione_breve", "descrizione_completa", "altezza",
			"circonferenza_vaso", "prezzo_base", "sconto_percentuale", "quantita", "listed"};
	
	private static ProductDao instance;
	
	private ProductDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
		deleteQuery = "UPDATE " + TABLE_NAME + " SET listed = false WHERE id = ?";
	}
	
	public static synchronized ProductDao getInstance() {
		if (instance == null)
			instance = new ProductDao();
		
		return instance;
	}
	
	public List<Product> getAllByLikey(String search) {
		return getAllByFieldLike("nome", search, JDBCType.VARCHAR);
	}
	
	public List<Product> getAllByCategory(String  category) {
		return getAllByField("categoria", category, JDBCType.VARCHAR);
	}
	public List<Product> getAllByName(String  name) {
		return getAllByField("nome", name, JDBCType.VARCHAR);
	}

	@Override
	protected Product parseObject(ResultSet result) throws SQLException {
		Product product = new Product();
		
		product.setId(result.getLong("id"));
		product.setName(result.getString("nome"));
		product.setCategory(Subcategory.valueOf(result.getString("categoria")));
		product.setMinimalDescription(result.getString("descrizione_breve"));
		product.setDescription(result.getString("descrizione_completa"));
		product.setHeight(result.getFloat("altezza"));
		product.setFlowerpotCircumference(result.getFloat("circonferenza_vaso"));
		product.setBasePrice(result.getFloat("prezzo_base"));
		product.setDiscountRate(result.getFloat("sconto_percentuale"));
		product.setAvailableAmount(result.getShort("quantita"));
		product.setListed(result.getBoolean("listed"));
		
		return product;
	}

	@Override
	protected void serializeObject(Product product, PreparedStatement statement) throws SQLException {
		statement.setString(1, product.getName());
		statement.setString(2, product.getCategory().name());
		statement.setString(3, product.getMinimalDescription());
		statement.setString(4, product.getDescription());
		statement.setFloat(5, product.getHeight());
		statement.setFloat(6, product.getFlowerpotCircumference());
		statement.setFloat(7, product.getBasePrice());
		statement.setFloat(8, product.getDiscountRate());
		statement.setShort(9, product.getAvailableAmount());
		statement.setBoolean(10, product.isListed());
	}
	
}
