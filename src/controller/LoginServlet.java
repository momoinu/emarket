package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.ejb.EJB;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.AddressBook;
import entity.Customer;
import entity.CustomerOrder;
import session_bean.AddressBookSessionBean;
import session_bean.CategorySessionBean;
import session_bean.CustomerOrderSessionBean;
import session_bean.CustomerSessionBean;
import session_bean.ProductDetailSessionBean;
import session_bean.ProductSessionBean;

@WebServlet(name = "LoginServlet", loadOnStartup = 1, urlPatterns = { "/login", "/register", "/profile", "/logout","/editProfile",
		"/deleteAddress", "/addAddress" })
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
	@EJB
	private AddressBookSessionBean addressBookSB;
	@EJB
	private CustomerOrderSessionBean customerOrderSB;
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
		else if(userPath.equals("/deleteAddress")) {
			Customer customer = (Customer) session.getAttribute("customer");
			int addressId = Integer.parseInt(request.getParameter("addressId"));
			AddressBook addressBook = addressBookSB.findByAddressBookId(addressId);
			addressBookSB.remove(addressBook);
			List<AddressBook> addressBooks = addressBookSB.findByCustomer(customer);
			session.setAttribute("addressBooks", addressBooks);
			request.setAttribute("deleteAddressSuccessfully", true);
			request.getRequestDispatcher("profile.jsp").include(request, response);
		}
		else if(userPath.equals("/profile")) {
			Customer customer = (Customer) session.getAttribute("customer");
			if(customer == null) {
				int customerId = Integer.parseInt(request.getQueryString());
				customer = customerSB.find(customerId);
			}
			List<CustomerOrder> customerOrders = (List<CustomerOrder>) customerOrderSB.findByCustomer(customer);
			session.setAttribute("customerOrders", customerOrders);
			if(customer != null) {
				session.setAttribute("customer", customer);
				List<AddressBook> addressBooks = addressBookSB.findByCustomer(customer);
				session.setAttribute("addressBooks", addressBooks);
				userPath = "profile";
			}else {
				request.setAttribute("customerErrorFlag", true);
				request.getRequestDispatcher("adminViewProfile.jsp").forward(request, response);
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
		Random random = new Random();

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
//					Customer customer = null;
//					session.setAttribute("customer", customer);				
					session.setAttribute("account", (int) 1);
					List<Customer> customers = customerSB.findAll();
					session.setAttribute("customers", customers);
					List<CustomerOrder> customerOrders = customerOrderSB.findAll();
					session.setAttribute("customerOrderHistories", customerOrders);
					request.getRequestDispatcher("index.jsp").include(request, response);
				} else {
					out.print("<script type=\"text/javascript\">\r\n" + " alert('You are not Admin');\r\n"
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
					List<AddressBook> addressBooks = addressBookSB.findByCustomer(customer);
					session.setAttribute("addressBooks", addressBooks);
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
			
			customer.setCustomerId(rand.nextInt(999999999));
			customer.setName(request.getParameter("name"));
			customer.setEmail(request.getParameter("email"));
			customer.setPhone(request.getParameter("phone"));
			customer.setAddress(request.getParameter("address"));
			customer.setCity(request.getParameter("city_region"));
			customer.setUsername(request.getParameter("username"));					
			customer.setPassword(request.getParameter("password"));
			Customer availbleCustomer = customerSB.findByUsername(request.getParameter("username"));
			if (availbleCustomer != null) {
				out.print("<script type=\"text/javascript\">\r\n" + "	alert('Username is not availble!');\r\n"
						+ "	</script>");
				request.getRequestDispatcher("register.jsp").include(request, response);
			} else {
				customerSB.create(customer);
				//create base address book
				AddressBook addressBook = new AddressBook();
				addressBook.setAddressId(rand.nextInt(999999999));
				addressBook.setCustomer(customer);
				addressBook.setAddress(customer.getAddress());
				addressBook.setCity(customer.getCity());
				addressBook.setPhone(customer.getPhone());
				addressBook.setReceiver(customer.getName());
				addressBookSB.create(addressBook);
				List<AddressBook> addressBooks = addressBookSB.findByCustomer(customer);
				session.setAttribute("account", 2);
				session.setAttribute("customer", customer);
				session.setAttribute("addressBooks", addressBooks);
				out.print("<script type=\"text/javascript\">\r\n" + "	alert('Register successfully ');\r\n"
						+ "	</script>");
				request.getRequestDispatcher("index.jsp").include(request, response);
			}
			out.close();
		}
		//edit profile
		else if(userPath.equals("/editProfile")) {
			PrintWriter out = response.getWriter();
			Customer customer = (Customer) session.getAttribute("customer");
			customer.setAddress(request.getParameter("address"));
			customer.setName(request.getParameter("name"));
			customer.setCity(request.getParameter("city"));
			customer.setEmail(request.getParameter("email"));
			customer.setPassword(request.getParameter("password"));
			customer.setPhone(request.getParameter("phone"));
			customerSB.edit(customer);
			session.setAttribute("customer", customer);			
			request.getRequestDispatcher("profile.jsp").forward(request, response);							
		}
		
		else if(userPath.equals("/addAddress")) {
			Customer customer = (Customer) session.getAttribute("customer");
			String receiver = request.getParameter("receiver");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			AddressBook addressBook = new AddressBook();
			addressBook.setAddressId(random.nextInt(999999999));
			addressBook.setCustomer(customer);
			addressBook.setAddress(address);
			addressBook.setCity(city);
			addressBook.setPhone(phone);
			addressBook.setReceiver(receiver);
			addressBookSB.create(addressBook);
			List<AddressBook> addressBooks = addressBookSB.findByCustomer(customer);
			session.setAttribute("addressBooks", addressBooks);
			request.setAttribute("createAddressSuccessfully", true);
			userPath = "profile";
		}
		String url = userPath + ".jsp";
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}

}
