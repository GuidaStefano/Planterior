package it.unisa.planterior.model.bean;

import java.time.ZonedDateTime;
import java.util.*;

import it.unisa.planterior.util.DateUtil;

public class Order extends Bean {
	
	private State state;
	private Customer customer;
	private PaymentMethod paymentMethod;
	private ShippingAddress shippingAddress;
	private float totalPrice;
	private ZonedDateTime orderDate;
	private Optional<String> trackingCode;
	
	private Set<OrderItem> items;
	
	public Order() {
		
	}
	
	public Order(Customer customer, PaymentMethod paymentMethod, ShippingAddress shippingAddress, Set<OrderItem> items) {
		id = -1; // generato dal DBMS
		state = State.PROCESSING;
		this.customer = customer;
		this.paymentMethod = paymentMethod;
		this.shippingAddress = shippingAddress;
		trackingCode = Optional.empty();
		orderDate = DateUtil.now();
		this.items = items;
		
		computePrice();
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
		computePrice();
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
	
	public ZonedDateTime getOrderDate() {
		return orderDate;
	}
	
	public void setOrderDate(ZonedDateTime orderDate) {
		this.orderDate = orderDate;
	}
	
	public Set<OrderItem> getItems() {
		return items;
	}

	public void setItems(Set<OrderItem> items) {
		this.items = items;
	}
	
	private void computePrice() {
		totalPrice = (float) items.stream().mapToDouble(item -> item.getUnitPrice() * item.getAmount()).sum();
	}
	
	public enum State {
		PROCESSING("IN LAVORAZIONE"),
		READY("PRONTO"),
		SHIPPED("SPEDITO"),
		DELIVERED("CONSEGNATO");
		
		private String label;
		State(String label) {
			this.label = label;
		}
		
		@Override
		public String toString() {
			return label;
		}
	}
	
}
