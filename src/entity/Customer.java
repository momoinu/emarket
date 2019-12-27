package entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the customer database table.
 * 
 */
@Entity
@NamedQueries({
	@NamedQuery(name="Customer.findAll", query="SELECT c FROM Customer c"),
	@NamedQuery(name="Customer.findByUserPass", query="SELECT c FROM Customer c WHERE c.username = :username AND c.password = :password"),
	@NamedQuery(name="Customer.findByUsername", query="SELECT c FROM Customer c WHERE c.username = :username")})
public class Customer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="customer_id")
	private int customerId;

	private String address;

	private String avatar;

	private String city;

	private String email;

	private String name;

	private String password;

	private String phone;

	private String username;

	//bi-directional many-to-one association to AddressBook
	@OneToMany(mappedBy="customer")
	private List<AddressBook> addressBooks;

	//bi-directional many-to-one association to CustomerOrder
	@OneToMany(mappedBy="customer")
	private List<CustomerOrder> customerOrders;

	public Customer() {
	}

	public int getCustomerId() {
		return this.customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvatar() {
		return this.avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<AddressBook> getAddressBooks() {
		return this.addressBooks;
	}

	public void setAddressBooks(List<AddressBook> addressBooks) {
		this.addressBooks = addressBooks;
	}

	public AddressBook addAddressBook(AddressBook addressBook) {
		getAddressBooks().add(addressBook);
		addressBook.setCustomer(this);

		return addressBook;
	}

	public AddressBook removeAddressBook(AddressBook addressBook) {
		getAddressBooks().remove(addressBook);
		addressBook.setCustomer(null);

		return addressBook;
	}

	public List<CustomerOrder> getCustomerOrders() {
		return this.customerOrders;
	}

	public void setCustomerOrders(List<CustomerOrder> customerOrders) {
		this.customerOrders = customerOrders;
	}

	public CustomerOrder addCustomerOrder(CustomerOrder customerOrder) {
		getCustomerOrders().add(customerOrder);
		customerOrder.setCustomer(this);

		return customerOrder;
	}

	public CustomerOrder removeCustomerOrder(CustomerOrder customerOrder) {
		getCustomerOrders().remove(customerOrder);
		customerOrder.setCustomer(null);

		return customerOrder;
	}

}