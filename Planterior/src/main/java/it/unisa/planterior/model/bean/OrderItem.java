package it.unisa.planterior.model.bean;

import java.util.Objects;

// ID = ID ordine
public class OrderItem extends Bean {
	
	private long productId;
	private short amount;
	private float unitPrice;
	
	public OrderItem() {
		
	}
	
	public OrderItem(long productId, short amount, float unitPrice) {
		id = -1;
		this.productId = productId;
		this.amount = amount;
		this.unitPrice = unitPrice;
	}

	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}

	public short getAmount() {
		return amount;
	}

	public void setAmount(short amount) {
		this.amount = amount;
	}

	public float getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(float unitPrice) {
		this.unitPrice = unitPrice;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Objects.hash(productId);
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderItem other = (OrderItem) obj;
		return productId == other.productId;
	}

}
