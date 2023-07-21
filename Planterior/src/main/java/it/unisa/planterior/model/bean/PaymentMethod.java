package it.unisa.planterior.model.bean;

import java.time.ZonedDateTime;
import java.util.Optional;

public class PaymentMethod extends Bean {

	private CardCircuit cardCircuit;
	private String owner;
	private String cardNumber;
	private String cvv;
	private ZonedDateTime expirationDate;
	private Optional<Customer> customer;
	
	public PaymentMethod() {
		
	}
	
	public PaymentMethod(CardCircuit cardCircuit, String owner, String cardNumber, String cvv, ZonedDateTime expirationDate, Customer customer) {
		id = -1; // generato dal DBMS
		this.cardCircuit = cardCircuit;
		this.owner = owner;
		this.cardNumber = cardNumber;
		this.cvv = cvv;
		this.expirationDate = expirationDate;
		this.customer = Optional.ofNullable(customer);
	}
	
	public CardCircuit getCardCircuit() {
		return cardCircuit;
	}

	public void setCardCircuit(CardCircuit cardCircuit) {
		this.cardCircuit = cardCircuit;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getCvv() {
		return cvv;
	}

	public void setCvv(String cvv) {
		this.cvv = cvv;
	}
	
	public ZonedDateTime getExpirationDate() {
		return expirationDate;
	}
	
	public void setExpirationDate(ZonedDateTime expirationDate) {
		this.expirationDate = expirationDate;
	}

	public Optional<Customer> getCustomer() {
		return customer;
	}
	
	public void setCustomer(Optional<Customer> customer) {
		this.customer = customer;
	}

	public enum CardCircuit {
		VISA("Visa"),
		MASTERCARD("Mastercard"),
		AMERICAN_EXPRESS("American Express");
		
		private String label;
		
		CardCircuit(String label) {
			this.label = label;
		}
		
		@Override
		public String toString() {
			return label;
		}
	}
	
}
