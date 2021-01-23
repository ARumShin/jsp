package dto;

import java.io.Serializable;

public class Product implements Serializable{
	private static final long serialVersionUID=-4274700572038677000L;
	
	private String productId;//상품 아이디
	private String pname;//상품 이름
	private Integer unitPrice;//상품 가격
	private String description;//상품 설명
	private String manufacturer;//제조사
	private String category;//분류
	private long unitsInStock;//재고 수
	private String condition;//신상품 or중고품or재생품
	//이미지 올리려구 멤버변수 선언하고 오버라이드 겟셋해주기
	private String filename;
	private int quantity;
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public Product() {
		super();//부모 클래스
	}
	public Product(String productId,String pname,Integer unitPrice) {
		this.productId=productId;
		this.pname=pname;
		this.unitPrice=unitPrice;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public Integer getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}
	
	public long getUnitsInStock() {
		return unitsInStock;
	}
	public void setUnitsInStock(long unitsInStock) {
		this.unitsInStock = unitsInStock;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	

}
