package it.unisa.planterior.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

import it.unisa.planterior.model.bean.Favourites;
import it.unisa.planterior.model.bean.Product;
import it.unisa.planterior.model.dao.api.GenericDao;

public class FavouritesDao extends GenericDao<Favourites> {
	
	private static final String GET_BY_CUSTOMER_QUERY = "SELECT * FROM preferiti WHERE cliente = ?";
	private static final String DELETE_QUERY = "DELETE FROM preferiti WHERE cliente = ? AND prodotto = ?";
	private static final String INSERT_QUERY = "INSERT INTO preferiti(cliente, prodotto) VALUES (?, ?)";
	
	private static FavouritesDao instance;
	
	private FavouritesDao() {
		
	}
	
	public synchronized static FavouritesDao getInstance() {
		if (instance == null)
			instance = new FavouritesDao();
		
		return instance;
	}

	@Override
	public Optional<Favourites> getById(long id) {
		// verifica se il cliente esiste!
		if (CustomerDao.getInstance().getById(id).isEmpty())
			return Optional.empty(); 
		
		try(Connection connection = dataSource.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(GET_BY_CUSTOMER_QUERY);
			statement.setLong(1, id);
			
			Favourites favourites = new Favourites();
			ProductDao productDao = ProductDao.getInstance();
			
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				long productId = result.getLong("prodotto");
				
				productDao.getById(productId).ifPresent(favourites.getProducts()::add);
			}
			
			return Optional.of(favourites);
		} catch (SQLException e) {
			e.printStackTrace();
			return Optional.empty();
		}
	}

	@Override
	public boolean save(Favourites favourites) {
		long customerId = favourites.getId();
		Optional<Favourites> optionalStoredFavourites = getById(customerId); // si fa una copia della precedente lista preferiti salvata sul databse
		
		try(Connection connection = dataSource.getConnection()) {
			boolean state = true; // stato dell'operazione dopo l'esecuzione delle varie query
			if (optionalStoredFavourites.isEmpty()) { // caso in cui non c'è una "vecchia lista preferiti" associata al cliente
				for (Product product : favourites.getProducts()) { // in caso affermativo, registra semplicemente la lista preferiti attuale
					PreparedStatement statement = connection.prepareStatement(INSERT_QUERY);
					statement.setLong(1, customerId);
					statement.setLong(2, product.getId());
					
					state = state && statement.executeUpdate() == 1; // aggiorna lo stato
				}
				
				return state;
			}
			
			Favourites storedFavourites = optionalStoredFavourites.get(); // è presente già una lista preferiti associata al cliente, la prende
			for (Product product : favourites.getProducts()) { // itera tutti i prodotti della lista preferiti attuale

				if (storedFavourites.getProducts().contains(product)) { // caso in cui il prodotto della lista preferiti attuale sia già nel database
					storedFavourites.getProducts().remove(product);  
				} else { // caso in cui il prodotto della lista preferiti attuale NON sia nel database, quindi lo aggiunge 
					PreparedStatement statement = connection.prepareStatement(INSERT_QUERY);
					statement.setLong(1, customerId);
					statement.setLong(2, product.getId());
					
					state = state && statement.executeUpdate() == 1;
				}
			}
			
			for (Product product : storedFavourites.getProducts()) { // rimuove tutti i prodotti che erano presenti nel "vecchia lista preferiti", ma non nella nuova
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
