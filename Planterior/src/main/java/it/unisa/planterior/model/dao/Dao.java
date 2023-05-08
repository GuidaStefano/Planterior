package it.unisa.planterior.model.dao;

import java.sql.Connection;
import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.planterior.model.bean.Bean;

public abstract class Dao<T extends Bean> {
	
	protected DataSource dataSource;
	protected String tableName;
	protected String[] updateFields;
	
	private String getByIdQuery;
	private String getByFieldBaseQuery;
	private String getAllQuery;
	private String updateQuery;
	private String insertQuery;
	
	protected Dao(String tableName, String... updateFields) {
		try {
			Context initialContext = new InitialContext();
			Context environmentContext = (Context) initialContext.lookup("java:comp/env");

			dataSource = (DataSource) environmentContext.lookup("jdbc/planterior-database");
		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		this.tableName = Objects.requireNonNull(tableName);
		this.updateFields = updateFields;
		buildQueries();
	}
	
	private void buildQueries() {
		getByIdQuery = "SELECT * FROM " + tableName + " WHERE id = ?";
		getAllQuery = "SELECT * FROM " + tableName;
		getByFieldBaseQuery = "SELECT * FROM " + tableName + " WHERE ";
		
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
    
    public Optional<T> getById(long id) {
		try (Connection connection = dataSource.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(getByIdQuery);
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
		try (Connection connection = dataSource.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(getByFieldQuery);
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
    
    public List<T> getAll() {
		List<T> all = new ArrayList<>();
		try (Connection connection = dataSource.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(getAllQuery);
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
    public boolean save(T obj) {
		try (Connection connection = dataSource.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(obj.getId() == -1 ? insertQuery : updateQuery);
			serializeObject(obj, statement);
			
			if (obj.getId() != -1)
				statement.setLong(8, obj.getId());
			
			return statement.executeUpdate() == 1;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
    }
    
    protected abstract T parseObject(ResultSet result) throws SQLException;
    
    protected abstract void serializeObject(T obj, PreparedStatement statement) throws SQLException;
    
}
