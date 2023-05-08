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
	
	public Product() {
		
	}
	
	public Product(String name, Subcategory category, String minimalDescription, String description, float height,
			float flowerpotCircumference, float basePrice, float discountRate) {
		id = -1; // generato dal DBMS
		this.name = name;
		this.category = category;
		this.minimalDescription = minimalDescription;
		this.description = description;
		this.height = height;
		this.flowerpotCircumference = flowerpotCircumference;
		this.basePrice = basePrice;
		this.discountRate = discountRate;
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

	private void computePrice() {
		price = basePrice - (basePrice / 100 * discountRate);
	}

	enum Category {
		PIANTE_DA_INTERNO,
		TERRARIUM,
		HOME_DECOR
	}
	
	enum Subcategory {
		PIANTE_VERDI(Category.PIANTE_DA_INTERNO),
		PIANTE_GRASSE(Category.PIANTE_DA_INTERNO),
		BONSAI(Category.PIANTE_DA_INTERNO),
		PIANTE_FIORITE(Category.PIANTE_DA_INTERNO),
		ORCHIDEE(Category.PIANTE_DA_INTERNO),
		TERRARIUM(Category.TERRARIUM),
		VASI(Category.HOME_DECOR),
		ACCESSORI_PIANTE(Category.HOME_DECOR);
		
		private Category node;
		
		private Subcategory(Category node) {
			this.node = node;
		}
		
		public Category getNode() {
			return node;
		}
	}

}
