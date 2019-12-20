package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.ejb.EJB;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.ShoppingCart;
import entity.Category;
import entity.Customer;
import entity.Product;
import entity.ProductDetail;
import session_bean.CategorySessionBean;
import session_bean.CustomerSessionBean;
import session_bean.OrderManager;
import session_bean.ProductDetailSessionBean;
import session_bean.ProductSessionBean;
import valid.Validator;

@WebServlet(name = "ControllerServlet", loadOnStartup = 1, urlPatterns = { "/category", "/product", "/addToCart",
		"/viewCart", "/updateCart", "/checkout", "/purchase", "/login", "/chooseLanguage", "/addproduct",
		"/deleteproduct" })
public class ControllerServlet extends HttpServlet {

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

	@Override
	public void init(ServletConfig servletConfig) throws ServletException {
		super.init(servletConfig);
		// store new product list in servlet context
		getServletContext().setAttribute("newProducts", productSessionBean.findAll());
		getServletContext().setAttribute("newCategories", categorySB.findAll());
		getServletContext().setAttribute("account", (int) 0);
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
				System.out.println("log");
				categoryProducts = (List<Product>) selectedCategory.getProducts();
				session.setAttribute("categoryProducts", categoryProducts);
			}
		}
		// view product
		else if (userPath.equals("/product")) {
			Product selectedProduct;
			ProductDetail selectedProductDetail;
			String productId = request.getQueryString();
//			session.setAttribute("view","/product?"+productId);
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
			cart.update(product, quantity);
			String userView = (String) session.getAttribute("view");
			userPath = userView;
		}
		// addproduct
		else if (userPath.equals("/addproduct")) {
			PrintWriter out = response.getWriter();
			Product selectedProduct = (Product) session.getAttribute("selectedProduct");
			ProductDetail selectedProductDetail = (ProductDetail) session.getAttribute("selectedProductDetail");

			// get info from web
			Random random = new Random();
			int productId = random.nextInt(999999999);
			System.out.println(productId);
			String name = request.getParameter("name");
			String description = request.getParameter("description");
			String descriptionDetail = request.getParameter("descriptionDetail");
			int categoryId = Integer.parseInt(request.getParameter("categoryId"));
			String image = request.getParameter("image");
			Double price = Double.parseDouble(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			String information = request.getParameter("information");
			String accessories = request.getParameter("accessories");
			String guaranty = request.getParameter("guaranty");
			String image1 = request.getParameter("image1");
			String image2 = request.getParameter("image2");
			String image3 = request.getParameter("image3");
			String image4 = request.getParameter("image4");
			String image5 = request.getParameter("image5");

			if (selectedProduct != null) {
				productId = selectedProduct.getProductId();
				session.removeAttribute("selectedProduct");
				session.removeAttribute("selectedProductDetail");
				Product p = productSB.find(productId);
				ProductDetail pd = productDetailSB.find(productId);
				productDetailSB.remove(pd);
				productSB.remove(p);
			}

			try {
				Product p = new Product();
				ProductDetail pd = new ProductDetail();
				Category category = categorySB.find(categoryId);
				// set for product
				p.setProductId(productId);
				p.setName(name);
				p.setImage(image);
				p.setCategory(category);
				p.setDescription(description);
				p.setDescriptionDetail(descriptionDetail);
				p.setThumbImage(image);
				p.setPrice(price);
				java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
				p.setLastUpdate(date);
				productSB.create(p);
				// set for product detail

				pd.setProductId(productId);
				pd.setImage1(image1);
				pd.setImage1(image2);
				pd.setImage1(image3);
				pd.setImage1(image4);
				pd.setImage1(image5);
				pd.setAccessories(accessories);
				pd.setGuaranty(guaranty);
				pd.setInformation(information);

				productDetailSB.create(pd);
				session.setAttribute("selectedProduct", p);
				session.setAttribute("selectedProductDetail", pd);
				userPath = "product";
			} catch (Exception ex) {
				System.out.println(ex);
			}

		}
		// delete product
		else if (userPath.equals("/deleteproduct")) {
			PrintWriter out = response.getWriter();
			int productId = Integer.parseInt(request.getQueryString());
			if (productId != 0) {
				Product product = productSB.find(productId);
				ProductDetail productDetail = productDetailSB.find(productId);
				productDetailSB.remove(productDetail);
				productSB.remove(product);

				out.print("<script type=\"text/javascript\">\r\n" + "		alert('Delete product successfully!');\r\n"
						+ "	</script>");
				request.getRequestDispatcher("index.jsp").include(request, response);
			}
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

		if (userPath.equals("/login")) {
			String username = request.getParameter("user");
			String password = request.getParameter("pass");
			String checkadmin = request.getParameter("check");
			PrintWriter out = response.getWriter();
			if(checkadmin!=null) {
				if ((username.equals("rongden1211") && password.equals("admin"))
						|| (username.equals("momoinu") && password.equals("admin"))) {
					out.print(
							"<script type=\"text/javascript\">\r\n" + "		alert('Welcome Admin');\r\n" + "	</script>");
					session.setAttribute("account", (int) 1);
					request.getRequestDispatcher("index.jsp").include(request, response);

				} else {
					out.print("<script type=\"text/javascript\">\r\n" + "		alert('You are not Admin');\r\n"
							+ "	</script>");
					out.print("</br>");
					request.getRequestDispatcher("login.jsp").include(request, response);
				}	
			}else {
				if ((username.equals("momohaha"))){
					out.print(
							"<script type=\"text/javascript\">\r\n" + " alert('Welcome user!');\r\n" + "	</script>");
					session.setAttribute("account", (int) 2);
					
					
//					Cookie cookie = new Cookie("username",username);
//					cookie.setMaxAge(60*60*10);
//					response.addCookie(cookie);
					
					Customer customer = customerSB.findByUsername(username);
					session.setAttribute("customer", customer);
										
					request.getRequestDispatcher("index.jsp").include(request, response);

				}
			}
			

		} else if (userPath.equals("/purchase")) {
			if (cart != null) {
				String username = request.getParameter("username");
				String receiver = request.getParameter("receiver");
				String phone = request.getParameter("phone");
				String address = request.getParameter("address");
				String ccNumber = request.getParameter("ccNumber");
				boolean validationErrorFlag = false;
				validationErrorFlag = validator.validateForm(username, receiver, phone, address, ccNumber);
				if (!validationErrorFlag) {
					request.setAttribute("validationErrorFlag", validationErrorFlag);
					userPath = "checkout";
				} else {
					int orderId = orderManager.placeOrder(username, receiver, phone, address, ccNumber, cart);
					if (orderId != 0) {
						Locale locale = (Locale) session.getAttribute("javax.servlet.jsp.jstl.fmt.locale.session");
						String language = "";
						if (locale != null) {
							language = (String) locale.getLanguage();
						}
						// dissociate shopping cart from session
						cart = null;
						// end session
						session.invalidate();
						if (!language.isEmpty()) { //

							request.setAttribute("language", language); //

						}
						Map orderMap = orderManager.getOrderDetails(orderId);
						// place order details in request scope
						request.setAttribute("customer", orderMap.get("customer"));
						request.setAttribute("products", orderMap.get("products"));
						request.setAttribute("orderRecord", orderMap.get("orderRecord"));
						request.setAttribute("orderedProducts", orderMap.get("orderedProducts"));
						userPath = "/confirmation";

					} else {
						userPath = "/checkout";
						request.setAttribute("orderFailureFlag", true);
					}
				}
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
