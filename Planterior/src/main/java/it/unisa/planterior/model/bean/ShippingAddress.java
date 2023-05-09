package it.unisa.planterior.model.bean;

import java.util.Optional;

public class ShippingAddress extends Bean {
	
	private String street;
	private short houseNumber;
	private String postalCode;
	private Optional<Customer> customer;
	
	public ShippingAddress() {
		
	}
	
	public ShippingAddress(String street, short houseNumber, String postalCode, Customer customer) {
		id = -1; // generato dal DBMS
		this.street = street;
		this.houseNumber = houseNumber;
		this.postalCode = postalCode;
		this.customer = Optional.ofNullable(customer);
	}
	
	public String getStreet() {
		return street;
	}
	
	public void setStreet(String street) {
		this.street = street;
	}
	
	public short getHouseNumber() {
		return houseNumber;
	}
	
	public void setHouseNumber(short houseNumber) {
		this.houseNumber = houseNumber;
	}
	
	public String getPostalCode() {
		return postalCode;
	}
	
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	
	public Optional<Customer> getCustomer() {
		return customer;
	}
	
	public void setCustomer(Optional<Customer> customer) {
		this.customer = customer;
	}
	
}
