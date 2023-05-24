package it.unisa.planterior.model.bean;

import java.util.HashMap;
import java.util.Map;

public class Cart extends Bean {

	private Map<Product, Integer> products;
	
	public Cart() {
		this(new HashMap<>());
	}
	
	public Cart(Map<Product, Integer> products) {
		this.products = products;
	}
	
	public Map<Product, Integer> getProducts() {
		return products;
	}
	
	public void setProducts(Map<Product, Integer> products) {
		this.products = products;
	}
	
}
