package it.unisa.planterior.model.dao.api;

import java.sql.ResultSet;
import java.util.Optional;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.planterior.model.bean.Bean;

public abstract class AbstractDao<T extends Bean> {
	
	protected DataSource dataSource;
	
	protected AbstractDao() {
		try {
			Context initialContext = new InitialContext();
			Context environmentContext = (Context) initialContext.lookup("java:comp/env");

			dataSource = (DataSource) environmentContext.lookup("jdbc/planterior-database");
		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
	}

	public abstract Optional<T> getById(long id);
	
	public abstract boolean save(T obj);
	
	public abstract long saveAndReturnGeneratedId(T obj);
	
}
