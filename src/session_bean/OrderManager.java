/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session_bean;

import cart.ShoppingCart;
import cart.ShoppingCartItem;
import entity.Customer;
import entity.CustomerOrder;
import entity.OrderedProduct;
import entity.OrderedProductPK;
import entity.Product;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.SessionContext;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Zayt
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class OrderManager {

    @EJB
    public CustomerOrderSessionBean customerOrderSB;
    @EJB
    public ProductSessionBean productSB;
    @EJB
    public OrderedProductSessionBean orderedProductSB;
    @EJB
    public CustomerSessionBean customerSB;
    @EJB
    public ProductDetailSessionBean productDetailSB;
    @PersistenceContext(unitName = "Lab8a")
    public EntityManager em;
    @Resource
    public SessionContext context;
    
    public OrderManager(){}

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public int placeOrder(String username, String receiver, String phone, String address, String ccNumber, ShoppingCart cart) {
        try {
        	Customer customer = customerSB.findByUsername(username);
            
            CustomerOrder order = addOrder(customer, cart, receiver, phone, address, ccNumber);
            addOrderedItems(order, cart);
            return order.getOrderId();
        } catch (Exception e) {
            context.setRollbackOnly();
            e.printStackTrace();
            return 0;
        }
    }

    public CustomerOrder addOrder(Customer customer, ShoppingCart cart, String receiver, String phone, String address, String ccNumber) {
// set up customer order
        int id = customerOrderSB.findAll().size() + 1;
        CustomerOrder order = new CustomerOrder();
        order.setOrderId(id);
        order.setCustomer(customer);
        cart.calculateTotal("5");
        order.setAmount(new BigDecimal(cart.getTotal()));
        
// create confirmation number
        Random random = new Random();
        int i = random.nextInt(999999999);
        order.setConfirmationNumber(i);
//        DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
        java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
        order.setDateCreated(date);
        order.setAddress(address);
        order.setCcNumber(ccNumber);
        order.setReceiver(receiver);
        order.setPhone(phone);
        order.setStatus(1);
        customerOrderSB.create(order);
        return order;
    }

    public void addOrderedItems(CustomerOrder order, ShoppingCart cart) {
        List<ShoppingCartItem> items = cart.getItems();
// iterate through shopping cart and create OrderedProducts
        for (ShoppingCartItem scItem : items) {
            int productId = scItem.getProduct().getProductId();
// set up primary key object
            OrderedProductPK orderedProductPK = new OrderedProductPK();
            orderedProductPK.setOrderId(order.getOrderId());
            orderedProductPK.setProductId(productId);
// create ordered item using PK object
            OrderedProduct orderedItem = new OrderedProduct(orderedProductPK);
            orderedItem.setCustomerOrder(order);
            orderedItem.setProduct(productSB.find(productId));
// set quantity
            orderedItem.setQuantity(scItem.getQuantity());
            orderedProductSB.create(orderedItem);
        }
    }

    public Map getOrderDetails(int orderId) {
        Map orderMap = new HashMap();
// get order
        CustomerOrder order = customerOrderSB.find(orderId);
// get customer
        Customer customer = order.getCustomer();
// get all ordered products
        List<OrderedProduct> orderedProducts = orderedProductSB.findByOrderId(orderId);
// get product details for ordered items
        List<Product> products = new ArrayList<Product>();
        for (OrderedProduct op : orderedProducts) {
            Product p = (Product) productSB.find(op.getId().getProductId());
            products.add(p);
//            p.setQuantity(p.getQuantity() - op.getQuantity());
        }
// add each item to orderMap
        orderMap.put("orderRecord", order);
        orderMap.put("customer", customer);
        orderMap.put("orderedProducts", orderedProducts);
        orderMap.put("products", products);
        return orderMap;
    }
    public void updateQuantity(int orderId) {
		CustomerOrder customerOrder = customerOrderSB.find(orderId);
		List<OrderedProduct> orderedProducts = orderedProductSB.findByOrderId(orderId);
		for (OrderedProduct orderedProduct : orderedProducts) {
			int quantity = orderedProduct.getQuantity();
			Product product = productSB.find(orderedProduct.getProduct().getProductId());
//			ProductDetail product = productDetailSB.find(orderedProduct.getProduct().getProductId());
			int tmp = product.getQuantity();
			if (tmp - quantity <= 0) {
				tmp = 0;
			} else {
				tmp -= quantity;
			}
			product.setQuantity(tmp);
//			product.setSale(product.getSale() + quantity);
			productSB.edit(product);
		}
	}
}
