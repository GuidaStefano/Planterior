package it.unisa.planterior.model.bean;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class Customer extends Bean {
	
	private String name;
	private String surname;
	private String email;
	private String password;
	private Gender gender;
	private Date birthDate;
	private boolean administrator;
	
	private Set<ProductClass> favourites;
	private Map<ProductClass, Integer> cart;
	
	public Customer() {
		
	}
 
	public Customer(String name, String surname, String email, String password, Gender gender, Date birthDate) {
		id = -1; // generato dal DBMS
		this.name = name;
		this.surname = surname;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.birthDate = birthDate;
		administrator = false;
		
		favourites = new HashSet<>();
		cart = new HashMap<>();
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getSurname() {
		return surname;
	}
	
	public void setSurname(String surname) {
		this.surname = surname;
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
	
	public Gender getGender() {
		return gender;
	}
	
	public void setGender(Gender gender) {
		this.gender = gender;
	}
	
	public Date getBirthDate() {
		return birthDate;
	}
	
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	
	public boolean isAdministrator() {
		return administrator;
	}
	
	public void setAdministrator(boolean administrator) {
		this.administrator = administrator;
	}
	
	public Set<ProductClass> getFavourites() {
		return favourites;
	}
	
	public void setFavourites(Set<ProductClass> favourites) {
		this.favourites = favourites;
	}
	
	public Map<ProductClass, Integer> getCart() {
		return cart;
	}
	
	public void setCart(Map<ProductClass, Integer> cart) {
		this.cart = cart;
	}
	
	public enum Gender {
		M, F;
	}
	
}
