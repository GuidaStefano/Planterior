 package it.unisa.planterior.model.bean;

import java.util.*;

public class Carrello extends Bean  {
	 

	private int prodotto;
    private int quantita;
    private int ordine=0;
    
    public Carrello() {
    	id=-1;
    	quantita=0;
    	ordine=0;
    }
    
    public Carrello(int prodotto, int quantita) {
        this.prodotto = prodotto;
        this.quantita = quantita;
        ordine=0;
        id=-1;
    }
    public Carrello(int prodotto, int quantita,int ordine) {
        this.prodotto = prodotto;
        this.quantita = quantita;
        this.ordine=ordine;
        id=-1;
    }
    
    public int getProdotto() {
        return prodotto;
    }
    
    public int getQuantita() {
        return quantita;
    }
    public int getOrdine() {
        return ordine;
    }
    
    public void setProdotto(int prodotto) {
        this.prodotto = prodotto;
    }
    
    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }
    public void setOrdine(int ordine) {
        this.ordine = ordine;
    }
    
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Carrello that = (Carrello) o;
        return prodotto == that.prodotto && quantita == that.quantita;
    }

    @Override
    public int hashCode() {
        return Objects.hash(prodotto, quantita);
    }
    @Override
	public String toString() {
		return "Carrello [prodotto=" + prodotto + ", quantita=" + quantita + ", ordine=" + ordine + "]";
	}

}
