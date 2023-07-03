package it.unisa.planterior.model.dao;

import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Optional;

import it.unisa.planterior.model.bean.Carrello;
import it.unisa.planterior.model.dao.api.Dao;

public class ComposizioneDao extends Dao<Carrello> {

	private static final String TABLE_NAME = "composizione";
	private static final String[] UPDATE_FIELDS = {"ordine", "prodotto", "quantita"};
	
	private static ComposizioneDao instance;
	
	private ComposizioneDao() {
		super(TABLE_NAME, UPDATE_FIELDS);
	}
	
	public synchronized static ComposizioneDao getInstance() {
		if (instance == null)
			instance = new ComposizioneDao();
		
		return instance;
	}
	
	
	
	@Override
	protected Carrello parseObject(ResultSet result) throws SQLException {
		Carrello carrello = new Carrello();
	//	long carrelloId = result.getLong("id");
		
	//	carrello.setId(carrelloId);
		carrello.setProdotto(result.getInt("prodotto"));
		carrello.setOrdine(result.getInt("ordine"));
		carrello.setQuantita(result.getInt("quantita"));
		
		
		return carrello;
	}

	protected void serializeObject(Carrello carrello, PreparedStatement statement) throws SQLException {
		statement.setInt(1, carrello.getOrdine());
		statement.setInt(2, carrello.getProdotto());
		statement.setInt(3, carrello.getQuantita());
		
		
	}

	
}
