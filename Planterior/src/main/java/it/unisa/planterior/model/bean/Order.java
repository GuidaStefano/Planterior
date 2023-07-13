package it.unisa.planterior.model.bean;

import java.util.*;

public class Order extends Bean {
	private static int cont=7656;
	
	private State state;
	private Customer customer;
	private PaymentMethod paymentMethod;
	private ShippingAddress shippingAddress;
	private float totalPrice;
	private String trackingCode;
	private Date OrderDate;
	
	
	
	public Order() {
		
	}
	
	public Order(Customer customer, PaymentMethod paymentMethod, ShippingAddress shippingAddress, float totalPrice) {
		id = -1; // generato dal DBMS
		this.cont++;
		state = State.PROCESSING;
		this.customer = customer;
		this.paymentMethod = paymentMethod;
		this.shippingAddress = shippingAddress;
		this.totalPrice = totalPrice;
		trackingCode = String.valueOf(cont);
		Calendar calendar = Calendar.getInstance();
        OrderDate =calendar.getTime()  ;
		
	
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

	public String getTrackingCode() {
		return trackingCode;
	}
	public void setTrackingCode(String trackingCode ) {
		 this.trackingCode=trackingCode;
	}

 

	public Date getOrderDate() {
		return OrderDate;
	}
	
	public void setOrderDate(Date OrderDate ) {
		this.OrderDate=OrderDate;
	}

 

	
	
	public enum State {
		PROCESSING,
		READY,
		SHIPPED,
		DELIVERED;
	}
	
}
