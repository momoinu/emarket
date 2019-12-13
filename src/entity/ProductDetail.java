package entity;

import java.io.Serializable;
import javax.persistence.*;

import java.util.ArrayList;
import java.util.List;


/**
 * The persistent class for the product_detail database table.
 * 
 */
@Entity
@Table(name="product_detail")
@NamedQueries({
	 @NamedQuery(name = "ProductDetail.findAll", query = "SELECT p FROM	ProductDetail p"),
	 @NamedQuery(name = "ProductDetail.findByProductId", query = "SELECT p FROM ProductDetail p WHERE p.productId = :productId"),
	 @NamedQuery(name = "ProductDetail.findByImage1", query = "SELECT p FROM ProductDetail p WHERE p.image1 = :image1"),
	 @NamedQuery(name = "ProductDetail.findByImage2", query = "SELECT p FROM ProductDetail p WHERE p.image2 = :image2"),
	 @NamedQuery(name = "ProductDetail.findByImage3", query = "SELECT p FROM ProductDetail p WHERE p.image3 = :image3"),
	 @NamedQuery(name = "ProductDetail.findByImage4", query = "SELECT p FROM ProductDetail p WHERE p.image4 = :image4"),
	 @NamedQuery(name = "ProductDetail.findByImage5", query = "SELECT p FROM ProductDetail p WHERE p.image5 = :image5")})
	 
public class ProductDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="product_id", unique=true, nullable=false)
	private int productId;

	@Column(length=2000)
	private String accessories;

	@Column(length=2000)
	private String guaranty;

	@Column(length=255)
	private String image1;

	@Column(length=255)
	private String image2;

	@Column(length=255)
	private String image3;

	@Column(length=255)
	private String image4;

	@Column(length=255)
	private String image5;

	@Column(length=1000)
	private String information;

	//bi-directional many-to-one association to OrderedProduct
	@OneToMany(mappedBy="productDetail")
	private List<OrderedProduct> orderedProducts;

	//bi-directional one-to-one association to Product
	@OneToOne
	@JoinColumn(name="product_id", nullable=false, insertable=false, updatable=false)
	private Product product;

	public ProductDetail() {
	}

	public int getProductId() {
		return this.productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getAccessories() {
		return this.accessories;
	}

	public void setAccessories(String accessories) {
		this.accessories = accessories;
	}

	public String getGuaranty() {
		return this.guaranty;
	}

	public void setGuaranty(String guaranty) {
		this.guaranty = guaranty;
	}

	public String getImage1() {
		return this.image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return this.image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return this.image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getImage4() {
		return this.image4;
	}

	public void setImage4(String image4) {
		this.image4 = image4;
	}

	public String getImage5() {
		return this.image5;
	}

	public void setImage5(String image5) {
		this.image5 = image5;
	}

	public String getInformation() {
		return this.information;
	}

	public void setInformation(String information) {
		this.information = information;
	}

	public List<OrderedProduct> getOrderedProducts() {
		return this.orderedProducts;
	}

	public void setOrderedProducts(List<OrderedProduct> orderedProducts) {
		this.orderedProducts = orderedProducts;
	}

	public OrderedProduct addOrderedProduct(OrderedProduct orderedProduct) {
		getOrderedProducts().add(orderedProduct);
		orderedProduct.setProductDetail(this);

		return orderedProduct;
	}

	public OrderedProduct removeOrderedProduct(OrderedProduct orderedProduct) {
		getOrderedProducts().remove(orderedProduct);
		orderedProduct.setProductDetail(null);

		return orderedProduct;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	public List<String> getAllImages(){
		 List<String> images = new ArrayList<String>();
		 if (image1 != null) images.add(image1);
		 if (image2 != null) images.add(image2);
		 if (image3 != null) images.add(image3);
		 if (image4 != null) images.add(image4);
		 if (image5 != null) images.add(image5);
		 return images;
	}

	@Override
	public String toString() {
		return "entity.ProductDetail[ productId=" + productId + " ]";
	}

}