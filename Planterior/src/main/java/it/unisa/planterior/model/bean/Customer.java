package it.unisa.planterior.model.bean;

import java.time.ZonedDateTime;

public class Customer extends Bean {
	
	private String name;
	private String surname;
	private String email;
	private String password;
	private Gender gender;
	private ZonedDateTime birthDate;
	private boolean administrator;
	
	public Customer() {
		
	}
 
	public Customer(String name, String surname, String email, String password, Gender gender, ZonedDateTime birthDate) {
		id = -1; // generato dal DBMS
		this.name = name;
		this.surname = surname;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.birthDate = birthDate;
		administrator = false;
	}
	
	@Override
	public String toString() {
		return "Customer [name=" + name + ", surname=" + surname + ", email=" + email + ", password=" + password
				+ ", gender=" + gender + ", birthDate=" + birthDate + ", administrator=" + administrator + "]";
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
	
	public ZonedDateTime getBirthDate() {
		return birthDate;
	}
	
	public void setBirthDate(ZonedDateTime birthDate) {
		this.birthDate = birthDate;
	}
	
	public boolean isAdministrator() {
		return administrator;
	}
	
	public void setAdministrator(boolean administrator) {
		this.administrator = administrator;
	}

	public enum Gender {
		M, F;
	}
	
}
