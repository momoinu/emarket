package controller;

import session_bean.CategorySessionBean;
import session_bean.ProductDetailSessionBean;
import session_bean.ProductSessionBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.ejb.EJB;
import javax.naming.Context;
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
import entity.Category;
import entity.Product;
import entity.ProductDetail;

@WebServlet(name = "ControllerServlet", loadOnStartup = 1, urlPatterns = { "/category", 
																		   "/product", 
																		   "/addToCart",
																		   "/viewCart", 
																		   "/updateCart", 
																		   "/checkout", 
																		   "/purchase",
																		   "/login",
																		   "/chooseLanguage",
																		   "/addproduct"})
public class ControllerServlet extends HttpServlet {

	@EJB
	private ProductSessionBean productSessionBean;
	@EJB
	private CategorySessionBean categorySB;
	@EJB
	private ProductSessionBean productSB;
	@EJB
	private ProductDetailSessionBean productDetailSB;

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
		} else if (userPath.equals("/product")) {
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
		} else if (userPath.equals("/viewCart")) {
			String clear = request.getParameter("clear");
			if ((clear != null) && clear.equals("true")) {
				ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
				cart.clear();
			}
		} else if (userPath.equals("/addToCart")) {
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
		} else if (userPath.equals("/updateCart")) {
			ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
			String productId = request.getParameter("productId");
			String quantity = request.getParameter("quantity");
			Product product = productSB.find(Integer.parseInt(productId));
			cart.update(product, quantity);
			String userView = (String) session.getAttribute("view");
			userPath = userView;
		} else if(userPath.equals("/addproduct")) {
			PrintWriter out = response.getWriter();
				
			// get info from web
			int productId = Integer.parseInt(request.getParameter("productId"));
			String name = request.getParameter("name");
			String description = request.getParameter("description");
			String descriptionDetail= request.getParameter("descriptionDetail");
			String information = request.getParameter("information");
			int categoryId = Integer.parseInt(request.getParameter("categoryId")) ;
			String accessories = request.getParameter("accessories");
			String guaranty = request.getParameter("guaranty");
			Double price = Double.parseDouble(request.getParameter("price"));
			String image = request.getParameter("image");
			String image1 = request.getParameter("image1");
			String image2 = request.getParameter("image2");
			String image3 = request.getParameter("image3");
			String image4 = request.getParameter("image4");
			String image5 = request.getParameter("image5");
			
			try {

				Product product = new Product();
				Category category = new Category();
				ProductDetail productDetail = new ProductDetail();
				
				// create product
				category = categorySB.find(categoryId);
				product.setProductId(productId);
				product.setName(name);
				product.setPrice(price);
				product.setDescription(description);
				product.setDescriptionDetail(descriptionDetail);
				product.setCategory(category);
				product.setImage(image);					
				productSB.create(product);
				
				// create productDetail
				productDetail.setProductId(productId);
				productDetail.setInformation(information);
				productDetail.setAccessories(accessories);
				productDetail.setGuaranty(guaranty);
				productDetail.setImage1(image1);
				productDetail.setImage2(image2);
				productDetail.setImage3(image3);
				productDetail.setImage4(image4);
				productDetail.setImage5(image5);
				productDetailSB.create(productDetail);
				
				//select this product to preview
				Product selectedProduct;
				ProductDetail selectedProductDetail;
				selectedProduct = productSB.find(productId);
				selectedProductDetail = productDetailSB.find(productId);
				session.setAttribute("selectedProduct", selectedProduct);
				session.setAttribute("selectedProductDetail", selectedProductDetail);
				out.print("<script type=\"text/javascript\">\r\n" + 
						"		alert('Add product successfully');\r\n" + 
						"	</script>");
				request.getRequestDispatcher("index.jsp").include(request, response);
			} catch(Exception ex) {
				System.out.println(ex);
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
		if (userPath.equals("/login")) {
			String user = request.getParameter("user");
			String pass = request.getParameter("pass");
			PrintWriter out = response.getWriter();
			if (user.equals("rongden1211") && pass.equals("admin")) {
				out.print("<script type=\"text/javascript\">\r\n" + 
							"		alert('Welcome Thinh');\r\n" + 
							"	</script>");
				session.setAttribute("account", (int) 1);	
				request.getRequestDispatcher("index.jsp").include(request, response);
				
			
			} else {
				out.print("<script type=\"text/javascript\">\r\n" + 
					"		alert('You are not Admin');\r\n" + 
						"	</script>");
				out.print("</br>");
				request.getRequestDispatcher("login.jsp").include(request, response);
			}
			
		}

	}
}
