package entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the ordered_product database table.
 * 
 */
@Entity
@Table(name="ordered_product")
@NamedQuery(name="OrderedProduct.findAll", query="SELECT o FROM OrderedProduct o")
public class OrderedProduct implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="order_product_id", unique=true, nullable=false, length=23)
	private String orderProductId;

	private int quantity;

	//bi-directional many-to-one association to CustomerOrder
	@ManyToOne
	@JoinColumn(name="order_id", nullable=false)
	private CustomerOrder customerOrder;

	//bi-directional many-to-one association to ProductDetail
	@ManyToOne
	@JoinColumn(name="product_id", nullable=false)
	private ProductDetail productDetail;

	public OrderedProduct() {
	}

	public String getOrderProductId() {
		return this.orderProductId;
	}

	public void setOrderProductId(String orderProductId) {
		this.orderProductId = orderProductId;
	}

	public int getQuantity() {
		return this.quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public CustomerOrder getCustomerOrder() {
		return this.customerOrder;
	}

	public void setCustomerOrder(CustomerOrder customerOrder) {
		this.customerOrder = customerOrder;
	}

	public ProductDetail getProductDetail() {
		return this.productDetail;
	}

	public void setProductDetail(ProductDetail productDetail) {
		this.productDetail = productDetail;
	}

}