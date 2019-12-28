package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;
import java.sql.Date;

import javax.ejb.EJB;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Category;
import entity.Customer;
import entity.OrderedProduct;
import entity.Product;
import entity.ProductDetail;
import session_bean.CategorySessionBean;
import session_bean.CustomerSessionBean;
import session_bean.OrderedProductSessionBean;
import session_bean.ProductDetailSessionBean;
import session_bean.ProductSessionBean;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet(name = "ProductServlet", urlPatterns = { "/deleteProduct", "/addProduct", "/editProduct" })
public class ProductServlet extends HttpServlet {
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
	private OrderedProductSessionBean orderedProductSB;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String userPath = request.getRequestURI().substring(request.getContextPath().length());
		// addproduct
		if (userPath.equals("/addProduct")) {
			PrintWriter out = response.getWriter();
			// get info from web
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

			Product product = productSB.findByName(name);
			
			if (product != null) {
				product.setQuantity(product.getQuantity() + quantity);
				productSB.edit(product);
				ProductDetail productDetail = productDetailSB.find(product.getProductId());
				session.setAttribute("selectedProduct", product);
				session.setAttribute("selectedProductDetail", productDetail);
				request.getServletContext().setAttribute("newProducts", productSessionBean.findAll());
				request.getServletContext().setAttribute("categories", categorySB.findAll());
				request.setAttribute("updateQuantitySuccessfullyFlag", true);
				userPath="product";
			} else {
				try {
					Product p = new Product();
					ProductDetail pd = new ProductDetail();
					Category category = categorySB.find(categoryId);
					// set for product
//					p.setProductId(productId);
					p.setName(name);
					p.setImage(image);
					p.setCategory(category);
					p.setDescription(description);
					p.setDescriptionDetail(descriptionDetail);
					p.setThumbImage(image);
					p.setPrice(price);
					java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
					p.setLastUpdate(date);
					p.setQuantity(quantity);
					productSB.create(p);
					
					// set for product detail
					int productId = productSB.findByName(name).getProductId();
					p.setProductId(productId);
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
					
					request.setAttribute("product", p);
					request.setAttribute("productDetail", pd);
					request.getServletContext().setAttribute("newProducts", productSessionBean.findAll());
					request.getServletContext().setAttribute("categories", categorySB.findAll());
					request.setAttribute("addProductSuccessfullyFlag", true);
					userPath = "product";
				} catch (Exception ex) {
					System.out.println(ex);
				}
			}			
		}

		// delete product
		else if (userPath.equals("/deleteProduct")) {			
			int productId = Integer.parseInt(request.getParameter("productId"));
			if (productId != 0) {
				Product product = productSB.find(productId);
				ProductDetail productDetail = productDetailSB.find(productId);
				List<OrderedProduct> orderedProducts = orderedProductSB.findByProductId(productId);
				if (product.getQuantity() == 0 && orderedProducts.isEmpty()) {
					productDetailSB.remove(productDetail);
					productSB.remove(product);
					getServletContext().setAttribute("newProducts", productSessionBean.findAll());
					PrintWriter out = response.getWriter();
					out.print("<script type=\"text/javascript\">\r\n" + "	alert('Delete product successfully!');\r\n"
							+ "	</script>");
					request.getRequestDispatcher("index.jsp").include(request, response);
					out.close();
				} else {
					request.setAttribute("deleteProductErrorFlag", true);
					request.setAttribute("product", product);
					request.setAttribute("productDetail", productDetail);
					userPath = "product";
				}
			}
		}
		//edit product
		else if (userPath.equals("/editProduct")) {			
			String productId = request.getParameter("productId");
			Product	product = productSB.find(Integer.parseInt(productId));
			ProductDetail productDetail = productDetailSB.find(Integer.parseInt(productId));			
			
			product.setQuantity(Integer.parseInt(request.getParameter("quantity")));			
			product.setPrice(Double.parseDouble(request.getParameter("price")));	
			productDetail.setAccessories(request.getParameter("accessories"));	
			productDetail.setInformation(request.getParameter("information"));
			productDetail.setGuaranty(request.getParameter("guaranty"));			
			
			productDetailSB.edit(productDetail);
			productSB.edit(product);
			request.setAttribute("product", product);
			request.setAttribute("productDetail", productDetail);
			request.getServletContext().setAttribute("newProducts", productSessionBean.findAll());
			request.getServletContext().setAttribute("newCategories", categorySB.findAll());
			request.setAttribute("editProductSuccessfully", true);
			userPath = "product";		
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
		

	}

}
