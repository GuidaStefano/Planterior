package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.apache.tomcat.jdbc.pool.PoolProperties;
import org.apache.tomcat.jdbc.pool.DataSource;

public class Connessione {
	//init db costant
		private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
		private static final String DB_URL = "jdbc:mysql://localhost:3306/planterior";
		private static final String USERNAME = "root";
		private static final String PASSWORD = "1315";
		private static final int MAX_POOL = 100;
		
		private static DataSource datasource;
		
		
		
		
		public static Connection getConnection() throws SQLException{
			if(datasource == null) {
				PoolProperties prop = new PoolProperties();
				prop.setUrl(DB_URL);
				prop.setDriverClassName(DB_DRIVER);;
				prop.setUsername(USERNAME);
				prop.setPassword(PASSWORD);
				prop.setMaxActive(MAX_POOL);
				prop.setInitialSize(10);
				prop.setMinIdle(10);
				prop.setRemoveAbandonedTimeout(600);
				prop.setRemoveAbandoned(true);
				datasource = new DataSource();
				datasource.setPoolProperties(prop);
			}
			return datasource.getConnection();
		}
}
