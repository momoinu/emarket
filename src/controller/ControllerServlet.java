package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Map;


import javax.ejb.EJB;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.ShoppingCart;
import entity.AddressBook;
import entity.Category;
import entity.Customer;
import entity.CustomerOrder;
import entity.Product;
import entity.ProductDetail;
import session_bean.AddressBookSessionBean;
import session_bean.CategorySessionBean;
import session_bean.CustomerOrderSessionBean;
import session_bean.CustomerSessionBean;
import session_bean.OrderManager;
import session_bean.ProductDetailSessionBean;
import session_bean.ProductSessionBean;
import valid.Validator;

@WebServlet(name = "ControllerServlet", loadOnStartup = 1, urlPatterns = { "/category", "/product", "/addToCart", "/orderDetail",
		"/viewCart", "/updateCart", "/checkout", "/purchase", "/chooseLanguage", "/chooseCustomerToCheckout", "/addressBook", "/updateStatusOrder" })
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private ProductSessionBean productSessionBean;
	@EJB
	private CategorySessionBean categorySB;
	@EJB
	private ProductSessionBean productSB;
	@EJB
	private CustomerSessionBean customerSB;
	@EJB
	private ProductDetailSessionBean productDetailSB;
	@EJB
	private OrderManager orderManager;
	@EJB
	private AddressBookSessionBean addressBookSB;
	@EJB
	private CustomerOrderSessionBean customerOrderSB;

	@Override
	public void init(ServletConfig servletConfig) throws ServletException {
		super.init(servletConfig);
		// store new product list in servlet context
		getServletContext().setAttribute("newProducts", productSessionBean.findAll());
		getServletContext().setAttribute("newCategories", categorySB.findAll());			
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userPath = request.getRequestURI().substring(request.getContextPath().length());
		// view category
		if (userPath.equals("/category")) {
			String categoryId = request.getQueryString();
			if (categoryId != null) {
				Category selectedCategory;
				List<Product> categoryProducts;
				selectedCategory = categorySB.find(Integer.parseInt(categoryId));
				session.setAttribute("selectedCategory", selectedCategory);
				categoryProducts = (List<Product>) selectedCategory.getProducts();
				session.setAttribute("categoryProducts", categoryProducts);
				request.setAttribute("title", "Category");
			}
		}
		// view product
		else if (userPath.equals("/product")) {
			Product selectedProduct;
			ProductDetail selectedProductDetail;
			String productId = request.getQueryString();
			if (productId != null) {
				selectedProduct = productSB.find(Integer.parseInt(productId));
				selectedProductDetail = productDetailSB.find(Integer.parseInt(productId));
				session.setAttribute("selectedProduct", selectedProduct);
				session.setAttribute("selectedProductDetail", selectedProductDetail);
			}
		}
		// viewCart
		else if (userPath.equals("/viewCart")) {
			String clear = request.getParameter("clear");
			if ((clear != null) && clear.equals("true")) {
				ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
				cart.clear();
			}
		}
		// addtoCart
		else if (userPath.equals("/addToCart")) {
			// if user is adding item to cart for first time
			// create cart object and attach it to user session
			ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

			if (cart == null) {
				cart = new ShoppingCart();
				session.setAttribute("cart", cart);
			}
			// get user input from request
			String productId = request.getQueryString();
			if (!productId.isEmpty()) {
				Product product = productSB.find(Integer.parseInt(productId));
				cart.addItem(product);
			}
//			String userView = (String) session.getAttribute("view");
			userPath = "/index";
		}
		// updateCart
		else if (userPath.equals("/updateCart")) {
			ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
			String productId = request.getParameter("productId");
			String quantity = request.getParameter("quantity");
			Product product = productSB.find(Integer.parseInt(productId));
			if(product.getQuantity() < Integer.parseInt(quantity)) {
				request.setAttribute("cartFailureFlag", true);				
			}else {
				cart.update(product, quantity);
				request.setAttribute("cartFailureFlag", false);	
			}			
			String userView = (String) session.getAttribute("view");
			userPath = userView;
		}
		// order detail
		else if (userPath.contentEquals("/orderDetail")) {
			String orderId = request.getQueryString();
			CustomerOrder customerOrder = customerOrderSB.find(Integer.parseInt(orderId));
			Map orderMap = orderManager.getOrderDetails(Integer.parseInt(orderId));
			// place order details in request scope
			request.setAttribute("customer", orderMap.get("customer"));
			request.setAttribute("products", orderMap.get("products"));
			request.setAttribute("orderRecord", orderMap.get("orderRecord"));
			request.setAttribute("orderedProducts", orderMap.get("orderedProducts"));
			userPath = "orderDetail";
		}
		
		String url = userPath + ".jsp";
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}




	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userPath = request.getRequestURI().substring(request.getContextPath().length());
		ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
		Validator validator = new Validator();
	
		if (userPath.equals("/purchase")) {
			if (cart != null) {
				String username = request.getParameter("username");
				String receiver = request.getParameter("receiver");
				String phone = request.getParameter("phone");
				String address = request.getParameter("address");
				String ccNumber = "187730755";
				boolean validationErrorFlag = false;
				validationErrorFlag = validator.validateForm(username, receiver, phone, address, ccNumber);
				System.out.println(validationErrorFlag+"888888888888888888888888888888888888");
				Customer customer = customerSB.findByUsername(username);
				if (!validationErrorFlag) {
					request.setAttribute("validationFailureFlag", true);
					userPath = "checkout";
				} else if(customer == null) {
					request.setAttribute("usernameFailureFlag", true);		
					userPath = "checkout";
				}else {
					int orderId = orderManager.placeOrder(username, receiver, phone, address, ccNumber, cart);
					if (orderId != 0) {
						Locale locale = (Locale) session.getAttribute("javax.servlet.jsp.jstl.fmt.locale.session");
						String language = "";
						if (locale != null) {
							language = (String) locale.getLanguage();
						}
						// dissociate shopping cart from session
						double total = cart.getTotal();
						cart = null;
						session.setAttribute("cart", cart);
						request.setAttribute("total", total);
						if (!language.isEmpty()) { 
							request.setAttribute("language", language); 
						}
						Map orderMap = orderManager.getOrderDetails(orderId);
						// place order details in request scope
						request.setAttribute("customer", orderMap.get("customer"));
						request.setAttribute("products", orderMap.get("products"));
						request.setAttribute("orderRecord", orderMap.get("orderRecord"));
						request.setAttribute("orderedProducts", orderMap.get("orderedProducts"));
						List<CustomerOrder> customerOrders = customerOrderSB.findAll();
						session.setAttribute("customerOrderHistories", customerOrders);
						userPath = "/confirmation";
					} else {
						userPath = "/checkout";
						request.setAttribute("orderFailureFlag", true);
					}
				}
			}
		}
		else if(userPath.equals("/chooseCustomerToCheckout")) {
			String username = request.getParameter("usernameOfCustomer");
			Customer customer = customerSB.findByUsername(username);
			session.setAttribute("customer", customer);
			List<AddressBook> addressBooks = addressBookSB.findByCustomer(customer);
			request.setAttribute("addressBooks", addressBooks);
			request.getRequestDispatcher("checkout.jsp").forward(request, response);
		}
		else if(userPath.equals("/addressBook")) {
			String addressBookIdtoString = request.getParameter("addressBookId");
			
			if(addressBookIdtoString.equals("createNewAddressBook")) {
				request.setAttribute("pleaseCreateNewAddress", true);
				request.getRequestDispatcher("profile.jsp").forward(request, response);
			}else {
				int addressBookId = Integer.parseInt(addressBookIdtoString);
				AddressBook addressBook = addressBookSB.findByAddressBookId(addressBookId);
				request.setAttribute("addressBook", addressBook);
				request.getRequestDispatcher("checkout.jsp").forward(request, response);
			}
			
		}
		else if(userPath.equals("/updateStatusOrder")) {
			int orderId = Integer.parseInt(request.getParameter("orderId"));
			CustomerOrder customerOrder = customerOrderSB.find(orderId);
			int updateValue = Integer.parseInt(request.getParameter("status"));
			customerOrder.setStatus(updateValue);
			customerOrderSB.edit(customerOrder);
			List<CustomerOrder> customerOrderHistories = customerOrderSB.findAll();
			Collections.reverse(customerOrderHistories);
			session.setAttribute("customerOrderHistories", customerOrderHistories);
			userPath = "orderHistory";

			if (updateValue == 3) {
				orderManager.updateQuantity(orderId);
				request.getServletContext().setAttribute("newProducts", productSessionBean.findAll());
				request.getServletContext().setAttribute("newCategories", categorySB.findAll());
			}
			
		}
		String url = userPath + ".jsp";
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}
}
