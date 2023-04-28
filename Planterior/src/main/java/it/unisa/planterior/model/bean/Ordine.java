package it.unisa.planterior.model.bean;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class Ordine {

	private long id;
	private Stato stato;
	private Cliente cliente;
	private MetodoPagamento metodoPagamento;
	private IndirizzoConsegna indirizzoConsegna;
	private float totale;
	private Optional<String> codiceTracking;
	private Optional<Date> dataConsegna;
	
	private Map<Prodotto, Integer> composizione;
	
	public Ordine() {
		
	}
	
	public Ordine(Stato stato, Cliente cliente, MetodoPagamento metodoPagamento, IndirizzoConsegna indirizzoConsegna, float totale) {
		id = -1; // generato dal DBMS
		stato = Stato.IN_ELABORAZIONE;
		this.cliente = cliente;
		this.metodoPagamento = metodoPagamento;
		this.indirizzoConsegna = indirizzoConsegna;
		this.totale = totale;
		codiceTracking = Optional.empty();
		dataConsegna = Optional.empty();
		
		composizione = new HashMap<>();
	}
	
	public long getId() {
		return id;
	}
	
	public Stato getStato() {
		return stato;
	}
	
	public void setStato(Stato stato) {
		this.stato = stato;
	}
	
	public Cliente getCliente() {
		return cliente;
	}
	
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	
	public MetodoPagamento getMetodoPagamento() {
		return metodoPagamento;
	}
	
	public void setMetodoPagamento(MetodoPagamento metodoPagamento) {
		this.metodoPagamento = metodoPagamento;
	}
	
	public IndirizzoConsegna getIndirizzoConsegna() {
		return indirizzoConsegna;
	}
	
	public void setIndirizzoConsegna(IndirizzoConsegna indirizzoConsegna) {
		this.indirizzoConsegna = indirizzoConsegna;
	}
	
	public float getTotale() {
		return totale;
	}
	
	public void setTotale(float totale) {
		this.totale = totale;
	}
	
	public Optional<String> getCodiceTracking() {
		return codiceTracking;
	}
	
	public void setCodiceTracking(String codiceTracking) {
		this.codiceTracking = Optional.ofNullable(codiceTracking);
	}
	
	public Optional<Date> getDataConsegna() {
		return dataConsegna;
	}
	
	public void setDataConsegna(Date dataConsegna) {
		this.dataConsegna = Optional.ofNullable(dataConsegna);
	}
	
	public Map<Prodotto, Integer> getComposizione() {
		return composizione;
	}
	
	public void setComposizione(Map<Prodotto, Integer> composizione) {
		this.composizione = composizione;
	}
	
	enum Stato {
		IN_ELABORAZIONE,
		PRONTO,
		SPEDITO,
		CONSEGNATO
	}
}
