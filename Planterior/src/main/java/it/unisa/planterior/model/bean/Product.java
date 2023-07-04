package it.unisa.planterior.model.bean;

public class Product extends Bean {
	
	private String name;
	private Subcategory category;
	private String minimalDescription;
	private String description;
	private float height;
	private float flowerpotCircumference;
	private float basePrice;
	private float discountRate;
	private float price;
	private short availableAmount;

	public Product() {
		
	}
	
	public Product(String name, String category, String minimalDescription, String description, float height,
			float flowerpotCircumference, float basePrice, float discountRate, short availableAmount) {
		id = -1; // generato dal DBMS
		this.name = name;
		this.category = Subcategory.valueOf(category);
		this.minimalDescription = minimalDescription;
		this.description = description;
		this.height = height;
		this.flowerpotCircumference = flowerpotCircumference;
		this.basePrice = basePrice;
		this.discountRate = discountRate;
		this.availableAmount = availableAmount;
		computePrice();
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Subcategory getCategory() {
		return category;
	}

	public void setCategory(Subcategory category) {
		this.category = category;
	}

	public String getMinimalDescription() {
		return minimalDescription;
	}

	public void setMinimalDescription(String minimalDescription) {
		this.minimalDescription = minimalDescription;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public float getHeight() {
		return height;
	}

	public void setHeight(float height) {
		this.height = height;
	}

	public float getFlowerpotCircumference() {
		return flowerpotCircumference;
	}

	public void setFlowerpotCircumference(float flowerpotCircumference) {
		this.flowerpotCircumference = flowerpotCircumference;
	}

	public float getBasePrice() {
		return basePrice;
	}

	public void setBasePrice(float basePrice) {
		this.basePrice = basePrice;
		computePrice();
	}

	public float getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(float discountRate) {
		this.discountRate = discountRate;
		computePrice();
	}

	public float getPrice() {
		return price;
	}
	
	public short getAvailableAmount() {
		return availableAmount;
	}
	
	public void setAvailableAmount(short availableAmount) {
		this.availableAmount = availableAmount;
	}

	private void computePrice() {
		price = basePrice - (basePrice / 100 * discountRate);
	}

	public enum Category {
		PIANTE_DA_INTERNO("Piante da interno", 
				Subcategory.PIANTE_VERDI, Subcategory.PIANTE_GRASSE, Subcategory.BONSAI, Subcategory.PIANTE_FIORITE, Subcategory.ORCHIDEE),
		TERRARIUM("Terrarium", Subcategory.TERRARIUM),
		HOME_DECOR("Home Decor", Subcategory.VASI, Subcategory.ACCESSORI_PIANTE);
		
		private final String label;
		private Subcategory[] subcategories;
		
		Category(String label, Subcategory... subcategories) {
			this.label = label;
			this.subcategories = subcategories;
		}
		
		public Subcategory[] getSubcategories() {
			return subcategories;
		}
		
		@Override
		public String toString() {
			return label;
		}
	}
	
	public enum Subcategory {
		PIANTE_VERDI("Piante verdi"),
		PIANTE_GRASSE("Piante grasse"),
		BONSAI("Bonsai"),
		PIANTE_FIORITE("Piante fiorite"),
		ORCHIDEE("Orchidee"),
		TERRARIUM("Terrarium"),
		VASI("Vasi"),
		ACCESSORI_PIANTE("Accessori piante");
		
		private final String label;
		
		private Subcategory(String label) {
			this.label = label;
		}
		
		@Override
		public String toString() {
			return label;
		}
	}

}
