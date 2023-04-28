package it.unisa.planterior.model.bean;

import java.util.Optional;

public class MetodoPagamento {

	private long id;
	private Circuito circuito;
	private String intestatario;
	private String numeroCarta;
	private String cvv;
	private Optional<Cliente> cliente;
	
	public MetodoPagamento() {
		
	}
	
	public MetodoPagamento(Circuito circuito, String intestatario, String numeroCarta, String cvv, Cliente cliente) {
		id = -1; // generato dal DBMS
		this.circuito = circuito;
		this.intestatario = intestatario;
		this.numeroCarta = numeroCarta;
		this.cvv = cvv;
		this.cliente = Optional.ofNullable(cliente);
	}
	
	public long getId() {
		return id;
	}
	
	public Circuito getCircuito() {
		return circuito;
	}
	
	public void setCircuito(Circuito circuito) {
		this.circuito = circuito;
	}
	
	public String getIntestatario() {
		return intestatario;
	}
	
	public void setIntestatario(String intestatario) {
		this.intestatario = intestatario;
	}
	
	public String getNumeroCarta() {
		return numeroCarta;
	}
	
	public void setNumeroCarta(String numeroCarta) {
		this.numeroCarta = numeroCarta;
	}
	
	public String getCvv() {
		return cvv;
	}
	
	public void setCvv(String cvv) {
		this.cvv = cvv;
	}
	
	public Optional<Cliente> getCliente() {
		return cliente;
	}
	
	enum Circuito {
		VISA,
		MASTERCARD,
		AMERICAN_EXPRESS
	}
}
