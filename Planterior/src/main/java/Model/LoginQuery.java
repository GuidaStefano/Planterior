package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;

import Model.Connessione;
public class LoginQuery {
	
	public static int controllo(String nome, String pass) {
			 
			try {
				 
				Connection conn=null;
				conn = Connessione.getConnection();
				 
				 
				PreparedStatement ps= conn.prepareStatement("select nome from cliente where nome=? and pass=? and amministratore=1");
				ps.setString(1,nome);
				ps.setString(2,pass);
				
				ResultSet rs=ps.executeQuery();
				if(rs.next()) {
					return 1;
					
				}
				else {
					return 0;
				}
				
			
			}
			catch (Exception e){
				e.printStackTrace();
			 
				 
			}
			return 2;
}
}