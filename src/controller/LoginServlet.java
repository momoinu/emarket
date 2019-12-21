package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.ejb.EJB;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Customer;
import session_bean.CategorySessionBean;
import session_bean.CustomerSessionBean;
import session_bean.ProductDetailSessionBean;
import session_bean.ProductSessionBean;

@WebServlet(name = "LoginServlet", loadOnStartup = 1, urlPatterns = { "/login", "/register", "/viewProfile", "/logout" })
public class LoginServlet extends HttpServlet {
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
	public void init(ServletConfig servletConfig) throws ServletException {
		super.init(servletConfig);
		// TODO Auto-generated method stub
		getServletContext().setAttribute("account", (int) 0);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userPath = request.getRequestURI().substring(request.getContextPath().length());
//		logout		
		if (userPath.equals("/logout")) {
			session.setAttribute("account", 0);		
			session.setAttribute("customer", null);
			session.setAttribute("cart", null);
			request.getRequestDispatcher("index.jsp").include(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userPath = request.getRequestURI().substring(request.getContextPath().length());

//		login
		if (userPath.equals("/login")) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/html");
			String admin = request.getParameter("admin-login");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			// admin
			if (admin != null) {
				if ((username.equals("rongden1211") && password.equals("admin"))
						|| (username.equals("momoinu") && password.equals("a1k43pbc"))) {
					Customer customer = null;
					session.setAttribute("customer", customer);				
					session.setAttribute("account", (int) 1);
					request.getRequestDispatcher("index.jsp").include(request, response);
				} else {
					out.print("<script type=\"text/javascript\">\r\n" + " alert('Username or password incorrect');\r\n"
							+ "	</script>");
					out.print("</br>");
					request.getRequestDispatcher("login.jsp").include(request, response);
				}
			} // user
			else {
				Customer customer = customerSB.findByUserPass(username, password);
				if (customer == null) {
					out.print("<script type=\"text/javascript\">\r\n"
							+ "	alert('Username or password incorrect!');\r\n" + "	</script>");
					request.getRequestDispatcher("login.jsp").include(request, response);
				} else {
					session.setAttribute("account", (int)2);
					session.setAttribute("customer", customer);
					request.getRequestDispatcher("index.jsp").include(request, response);
				}
			}
			out.close();
		}
//		register		
		else if (userPath.equals("/register")) {
			PrintWriter out = response.getWriter();
			Random rand = new Random();
			Customer customer = new Customer();
			customer.setAddress(request.getParameter("address"));
			customer.setCityRegion(request.getParameter("city_region"));
			customer.setCustomerId(rand.nextInt(999999999));
			customer.setEmail(request.getParameter("email"));
			customer.setName(request.getParameter("name"));
			customer.setPassword(request.getParameter("password"));
			customer.setPhone(request.getParameter("phone"));
			customer.setUsername(request.getParameter("username"));
			Customer customerAvailble = customerSB.findByUsername(request.getParameter("username"));
			if (customerAvailble != null) {
				out.print("<script type=\"text/javascript\">\r\n" + "	alert('Username is not availble!');\r\n"
						+ "	</script>");
				request.getRequestDispatcher("register.jsp").include(request, response);
			} else {
				customerSB.create(customer);

				session.setAttribute("account", 2);
				session.setAttribute("customer", customer);
				out.print("<script type=\"text/javascript\">\r\n" + "	alert('Register successfully ');\r\n"
						+ "	</script>");
				request.getRequestDispatcher("index.jsp").include(request, response);
			}
			out.close();
		}

	}

}
