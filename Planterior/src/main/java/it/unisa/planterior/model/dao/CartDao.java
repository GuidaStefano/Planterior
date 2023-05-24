package it.unisa.planterior.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map.Entry;
import java.util.Optional;

import it.unisa.planterior.model.bean.Cart;
import it.unisa.planterior.model.bean.Product;
import it.unisa.planterior.model.dao.api.GenericDao;

public class CartDao extends GenericDao<Cart> {

	private static final String GET_BY_CUSTOMER_QUERY = "SELECT * FROM carrello WHERE cliente = ?";
	private static final String DELETE_QUERY = "DELETE FROM carrello WHERE cliente = ? AND prodotto = ?";
	private static final String UPDATE_AMOUNT_QUERY = "UPDATE carrello SET quantita = ? WHERE cliente = ? AND prodotto = ?";
	private static final String INSERT_QUERY = "INSERT INTO carrello(cliente, prodotto, quantita) VALUES (?, ?, ?)";
	
	private static CartDao instance;
	
	private CartDao() {
		
	}
	
	public synchronized static CartDao getInstance() {
		if (instance == null)
			instance = new CartDao();
		
		return instance;
	}
	
	@Override
	public Optional<Cart> getById(long id) {
		// verifica se il cliente esiste!
		if (CustomerDao.getInstance().getById(id).isEmpty())
			return Optional.empty(); 
		
		try(Connection connection = dataSource.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(GET_BY_CUSTOMER_QUERY);
			statement.setLong(1, id);
			
			Cart cart = new Cart();
			ProductDao productDao = ProductDao.getInstance();
			
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				long productId = result.getLong("prodotto");
				int amount = result.getInt("quantita");
				
				productDao.getById(productId).ifPresent(product -> cart.getProducts().put(product, amount));
			}
			
			return Optional.of(cart);
		} catch (SQLException e) {
			e.printStackTrace();
			return Optional.empty();
		}
	}
	
	@Override
	public boolean save(Cart cart) {
		long customerId = cart.getId();
		Optional<Cart> optionalStoredCart = getById(customerId); // si fa una copia del precedente carrello salvato sul databse
		
		try(Connection connection = dataSource.getConnection()) {
			boolean state = true; // stato dell'operazione dopo l'esecuzione delle varie query
			if (optionalStoredCart.isEmpty()) { // caso in cui non c'è un "vecchio carrello" associato al cliente
				for (Entry<Product, Integer> entry : cart.getProducts().entrySet()) { // in caso affermativo, registra semplicemente il carrello attuale
					Product product = entry.getKey();
					int amount = entry.getValue();
					
					PreparedStatement statement = connection.prepareStatement(INSERT_QUERY);
					statement.setLong(1, customerId);
					statement.setLong(2, product.getId());
					statement.setInt(3, amount);
					
					state = state && statement.executeUpdate() == 1; // aggiorna lo stato
				}
				
				return state;
			}
			
			Cart storedCart = optionalStoredCart.get(); // è presente già un carrello associato al cliente, lo prende
			for (Entry<Product, Integer> entry : cart.getProducts().entrySet()) { // itera tutti i prodotti del carrello attuale
				Product product = entry.getKey();
				int amount = entry.getValue();
				
				if (storedCart.getProducts().containsKey(product)) { // caso in cui il prodotto del carrello attuale sia già nel database
					if (amount != storedCart.getProducts().get(product)) { // se ne è stata modificata la quantità, la aggiorna anche sul database
						PreparedStatement statement = connection.prepareStatement(UPDATE_AMOUNT_QUERY);
						statement.setInt(1, amount);
						statement.setLong(2, customerId);
						statement.setLong(3, product.getId());
						
						state = state && statement.executeUpdate() == 1;
						storedCart.getProducts().remove(product);  
					}
				} else { // caso in cui il prodotto del carrello attuale NON sia nel database, quindi lo aggiunge 
					PreparedStatement statement = connection.prepareStatement(INSERT_QUERY);
					statement.setLong(1, customerId);
					statement.setLong(2, product.getId());
					statement.setInt(3, amount);
					
					state = state && statement.executeUpdate() == 1;
				}
			}
			
			for (Product product : storedCart.getProducts().keySet()) { // rimuove tutti i prodotti che erano presenti nel "vecchio carrello", ma non nel nuovo
				PreparedStatement statement = connection.prepareStatement(DELETE_QUERY);
				statement.setLong(1, customerId);
				statement.setLong(2, product.getId());
				
				state = state && statement.executeUpdate() == 1;
			}
			
			return state;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}
