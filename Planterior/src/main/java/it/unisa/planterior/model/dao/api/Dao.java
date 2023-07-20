package it.unisa.planterior.model.dao.api;

import java.sql.Connection;
import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;

import it.unisa.planterior.model.bean.Bean;

public abstract class Dao<T extends Bean> extends AbstractDao<T> {
	
	protected String tableName;
	protected String[] updateFields;
	
	protected String getByIdQuery;
	protected String getByFieldBaseQuery;
	protected String getAllQuery;
	protected String deleteQuery;
	protected String updateQuery;
	protected String insertQuery;
	
	
	protected Dao(String tableName, String... updateFields) {
		super();
		
		this.tableName = Objects.requireNonNull(tableName);
		this.updateFields = updateFields;
		buildQueries();
	}
	
	private void buildQueries() {
		getByIdQuery = "SELECT * FROM " + tableName + " WHERE id = ?";
		getAllQuery = "SELECT * FROM " + tableName;
		getByFieldBaseQuery = "SELECT * FROM " + tableName + " WHERE ";
		deleteQuery = "DELETE FROM " + tableName + " WHERE id = ?";
		
		// costruisce la query di aggiornamento
		StringBuilder updateQueryBuilder = new StringBuilder("UPDATE " + tableName + " SET ");
		for (int i = 0; i < updateFields.length; i++) {
			updateQueryBuilder.append(updateFields[i] + " = ?");
			if (i != updateFields.length - 1)
				updateQueryBuilder.append(", ");
		}
		updateQueryBuilder.append(" WHERE id = ?");
		
		updateQuery = updateQueryBuilder.toString();
		
		// costruisce la query di inserimento
		StringBuilder insertQueryBuilder = new StringBuilder("INSERT INTO " + tableName + " (");
		for (int i = 0; i < updateFields.length; i++) {
			insertQueryBuilder.append(updateFields[i]);
			if (i != updateFields.length - 1)
				insertQueryBuilder.append(", ");
		}
		insertQueryBuilder.append(") VALUES (");
		for (int i = 0; i < updateFields.length; i++) {
			insertQueryBuilder.append("?");
			if (i != updateFields.length - 1)
				insertQueryBuilder.append(", ");
		}
		insertQueryBuilder.append(")");
		
		insertQuery = insertQueryBuilder.toString();
	}
    
	@Override
    public Optional<T> getById(long id) {
		try (Connection connection = dataSource.getConnection(); 
				PreparedStatement statement = connection.prepareStatement(getByIdQuery);) {
			statement.setLong(1, id);
			
			ResultSet result = statement.executeQuery();
			if (result.next()) {
				T obj = parseObject(result);
				return Optional.ofNullable(obj);
			}
			return Optional.empty();
		} catch (SQLException e) {
			e.printStackTrace();
			return Optional.empty();
		}
    }
    
    protected List<T> getAllByField(String fieldName, Object key, JDBCType keyType) {
    	String getByFieldQuery = getByFieldBaseQuery + fieldName + " = ?";
    	
    	List<T> allMatched = new ArrayList<>();
		try (Connection connection = dataSource.getConnection();
				PreparedStatement statement = connection.prepareStatement(getByFieldQuery);) {
			statement.setObject(1, key, keyType);
			
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				T obj = parseObject(result);
				allMatched.add(obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return allMatched;
    }
    
    protected List<T> getAllByFieldLike(String fieldName, Object key, JDBCType keyType) {
    	String getByFieldQuery = getByFieldBaseQuery + fieldName + " LIKE ?";
    	
    	List<T> allMatched = new ArrayList<>();
		try (Connection connection = dataSource.getConnection();
				PreparedStatement statement = connection.prepareStatement(getByFieldQuery);) {
			statement.setObject(1, key, keyType);
 			
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				T obj = parseObject(result);
				allMatched.add(obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return allMatched;
    }
    
    protected Optional<T> getFirstByField(String fieldName, Object key, JDBCType keyType) {
    	List<T> allMatched = getAllByField(fieldName, key, keyType);
    	return allMatched.stream().findFirst();
    }
    
    public Set<T> getAll() {
		Set<T> all = new LinkedHashSet<>();
		try (Connection connection = dataSource.getConnection();
				PreparedStatement statement = connection.prepareStatement(getAllQuery);) {
			ResultSet result = statement.executeQuery();
			
			while (result.next()) {
				T obj = parseObject(result);
				all.add(obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return all;
    }
    
    // ritorna lo stato dell'operazione (true = operazione effettuata con successo, false = errore)
    public boolean delete(long id) {
		try (Connection connection = dataSource.getConnection();
				PreparedStatement statement = connection.prepareStatement(deleteQuery);) {
			statement.setLong(1, id);
			
			return statement.executeUpdate() == 1;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
    }
    
    // ritorna lo stato dell'operazione (true = operazione effettuata con successo, false = errore)
    @Override
    public boolean save(T obj) {
		try (Connection connection = dataSource.getConnection();
				PreparedStatement statement = connection.prepareStatement(obj.getId() == -1 ? insertQuery : updateQuery);) {
			serializeObject(obj, statement);
			
			if (obj.getId() != -1)
				statement.setLong(updateFields.length + 1, obj.getId());
			
			return statement.executeUpdate() == 1;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
    }
    
    @Override
    public long saveAndReturnGeneratedId(T obj) {
		try (Connection connection = dataSource.getConnection();
				PreparedStatement statement = connection.prepareStatement(obj.getId() == -1 ? insertQuery : updateQuery, 
						Statement.RETURN_GENERATED_KEYS);) {
			serializeObject(obj, statement);
			
			if (obj.getId() != -1)
				statement.setLong(updateFields.length + 1, obj.getId());
			
			if (statement.executeUpdate() != 1) return -1;
			
			ResultSet generatedKeys = statement.getGeneratedKeys();
			if (generatedKeys == null || !generatedKeys.next()) return -1;
			
			return generatedKeys.getLong(1);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
    }
  
    protected abstract T parseObject(ResultSet result) throws SQLException;
    
    protected abstract void serializeObject(T obj, PreparedStatement statement) throws SQLException;
    
}
