package it.unisa.planterior.model.bean;

import java.util.HashSet;
import java.util.Set;

public class Favourites extends Bean {

	private Set<Product> products;
	
	public Favourites() {
		this(new HashSet<>());
	}
	
	public Favourites(Set<Product> products) {
		this.products = products;
	}
	
	public Set<Product> getProducts() {
		return products;
	}
	
	public void setProducts(Set<Product> products) {
		this.products = products;
	}
	
}
