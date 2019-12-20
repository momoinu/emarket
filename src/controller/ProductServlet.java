package controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import entity.Product;
import entity.ProductDetail;
import session_bean.CategorySessionBean;
import session_bean.CustomerSessionBean;
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
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String userPath = request.getRequestURI().substring(request.getContextPath().length());
		// addproduct
		if (userPath.equals("/addproduct")) {
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
				pd.setQuantity(quantity);

				productDetailSB.create(pd);
				session.setAttribute("selectedProduct", p);
				session.setAttribute("selectedProductDetail", pd);
				out.print("<script type=\"text/javascript\">\r\n" 
						+ "	alert('Delete product successfully!');\r\n"
						+ "	</script>");
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

				out.print("<script type=\"text/javascript\">\r\n" 
						+ "	alert('Delete product successfully!');\r\n"
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
		// TODO Auto-generated method stub
		
	}

}
