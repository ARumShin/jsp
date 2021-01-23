package mvc.model.cart;

public class ShippingInfoVO {
	private String cartId;
	private String name;
	private String zipCode;
	private String country;
	private String addressName;
	private String addressName2;
	public ShippingInfoVO() {}
	public String getCartId() {
		return cartId;
	}
	public void setCartId(String cartId) {
		this.cartId = cartId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getAddressName() {
		return addressName;
	}
	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}
	public String getAddressName2() {
		return addressName2;
	}
	public void setAddressName2(String addressName2) {
		this.addressName2 = addressName2;
	}
	
	

}
