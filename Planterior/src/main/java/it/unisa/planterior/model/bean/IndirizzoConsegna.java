package it.unisa.planterior.model.bean;

import java.util.Optional;

public class IndirizzoConsegna {
	
	private long id;
	private String via;
	private short civico;
	private String cap;
	private short interno;
	private Optional<Cliente> cliente;
	
	public IndirizzoConsegna() {
		
	}
	
	public IndirizzoConsegna(String via, short civico, String cap, short interno, Cliente cliente) {
		id = -1; // generato dal DBMS
		this.via = via;
		this.civico = civico;
		this.cap = cap;
		this.interno = interno;
		this.cliente = Optional.ofNullable(cliente);
	}
	
	public long getId() {
		return id;
	}
	
	public String getVia() {
		return via;
	}
	
	public void setVia(String via) {
		this.via = via;
	}
	
	public short getCivico() {
		return civico;
	}
	
	public void setCivico(short civico) {
		this.civico = civico;
	}
	
	public String getCap() {
		return cap;
	}
	
	public void setCap(String cap) {
		this.cap = cap;
	}
	
	public short getInterno() {
		return interno;
	}
	
	public void setInterno(short interno) {
		this.interno = interno;
	}
	
	public Optional<Cliente> getCliente() {
		return cliente;
	}
	
	public void setCliente(Cliente cliente) {
		this.cliente = Optional.ofNullable(cliente);
	}
}
