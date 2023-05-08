package it.unisa.planterior.model.bean;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class Order extends Bean {
	
	private State state;
	private Customer customer;
	private PaymentMethod paymentMethod;
	private ShippingAddress shippingAddress;
	private float totalPrice;
	private Optional<String> trackingCode;
	private Optional<Date> deliveryDate;
	
	private Map<Product, Integer> composition;
	
	public Order() {
		
	}
	
	public Order(Customer customer, PaymentMethod paymentMethod, ShippingAddress shippingAddress, float totalPrice) {
		id = -1; // generato dal DBMS
		state = State.PROCESSING;
		this.customer = customer;
		this.paymentMethod = paymentMethod;
		this.shippingAddress = shippingAddress;
		this.totalPrice = totalPrice;
		trackingCode = Optional.empty();
		deliveryDate = Optional.empty();
		
		composition = new HashMap<>();
	}
	
	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public PaymentMethod getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(PaymentMethod paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public ShippingAddress getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(ShippingAddress shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	public float getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(float totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Optional<String> getTrackingCode() {
		return trackingCode;
	}

	public void setTrackingCode(String trackingCode) {
		this.trackingCode = Optional.ofNullable(trackingCode);
	}

	public Optional<Date> getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = Optional.ofNullable(deliveryDate);
	}

	public Map<Product, Integer> getComposition() {
		return composition;
	}
	
	public void setComposition(Map<Product, Integer> composition) {
		this.composition = composition;
	}
	
	enum State {
		PROCESSING,
		READY,
		SHIPPED,
		DELIVERED;
	}
	
}
