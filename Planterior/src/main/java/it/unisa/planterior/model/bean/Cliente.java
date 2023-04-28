package it.unisa.planterior.model.bean;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class Cliente {
	
	private long id;
	private String nome;
	private String cognome;
	private String email;
	private String password;
	private Sesso sesso;
	private Date dataNascita;
	private boolean amministratore;
	
	private Set<Prodotto> preferiti;
	private Map<Prodotto, Integer> carrello;
	
	public Cliente() {
		
	}
 
	public Cliente(String nome, String cognome, String email, String password, Sesso sesso, Date dataNascita) {
		id = -1; // generato dal DBMS
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.password = password;
		this.sesso = sesso;
		this.dataNascita = dataNascita;
		amministratore = false;
		
		preferiti = new HashSet<>();
		carrello = new HashMap<>();
	}
	
	public long getId() {
		return id;
	}
	
	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getCognome() {
		return cognome;
	}
	
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public Sesso getSesso() {
		return sesso;
	}
	
	public void setSesso(Sesso sesso) {
		this.sesso = sesso;
	}
	
	public Date getDataNascita() {
		return dataNascita;
	}
	
	public void setDataNascita(Date dataNascita) {
		this.dataNascita = dataNascita;
	}
	
	public boolean isAmministratore() {
		return amministratore;
	}
	
	public void setAmministratore(boolean amministratore) {
		this.amministratore = amministratore;
	}
	
	public Set<Prodotto> getPreferiti() {
		return preferiti;
	}
	
	public void setPreferiti(Set<Prodotto> preferiti) {
		this.preferiti = preferiti;
	}
	
	public Map<Prodotto, Integer> getCarrello() {
		return carrello;
	}
	
	public void setCarrello(Map<Prodotto, Integer> carrello) {
		this.carrello = carrello;
	}
	
	enum Sesso {
		M, F;
	}
	
}
