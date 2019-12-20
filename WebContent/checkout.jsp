<%@page import="session_bean.CustomerSessionBean"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.List"%>
<%
	session.setAttribute("view", "/checkout");	
	/* Cookie user = null;
	Cookie[] cookies = request.getCookies();
	for(Cookie cookie: cookies){
		if(cookie.getName().equals("username")){
			user = cookie;
		}
	}
	String username = user.getValue();
	CustomerSessionBean customerSessionBean = new CustomerSessionBean();
	Customer customer = customerSessionBean.findByUsername(username);  */

	Customer customer = (Customer) session.getAttribute("customer");
%>

<div class="container-fluid">
	<div class="row">
		<!-- left -->
		<div class="SideBar col-lg-2 col-md-2 col-sm-3 col-xs-12">
			<div class="SideBarItem">
				<h4 class="headline">Main Categories</h4>
				<div style="margin-left: -40px;">
					<nav>
						<ul class="sidebar-list">
							<li><a href="category?1">Mac</a></li>
							<li><a href="category?3">iPhone</a></li>
							<li><a href="category?2">iPad</a></li>
							<li><a href="category?4">Accessories</a></li>
						</ul>
					</nav>
				</div>
			</div>
			<div class="SideBarItem">
				<h4>Free Shipping</h4>
				<p>We offer you a Free Shipping, if your order value is over 1000.000 VND. For more information please check:</p>
				<p>
					<a href="#">Free Shipping Information and Conditions</a>
				</p>
			</div>
			<div class="SideBarItem">
				<h4>Pickup</h4>
				<p>You can pickup your goods, after you placed an order and and received a ready-for-pickup notification.</p>
			</div>
		</div>
		
		<!-- Content -->
		
		<div class="Content col-lg-7 col-md-7 col-sm-6 col-xs-12">
			<c:if test="${!empty orderFailureFlag}">
				<p style="color: #c00; font-style: italic">We were unable to process your order. Please try again!</p>
			</c:if>
			<h4 class="headline">Billing address</h4>
			<form class="needs-validation" action="<c:url value='purchase' />" method="post" novalidate>
				<div class="col-md-6 mb-3">
					<label for="name">Name</label> 
					<input type="text" class="form-control" id="name" value="${customer.getName()}" readonly>
				</div>
				<div class="mb-3">
					<label for="username">Username</label>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text">User</span>
						</div>
						<input type="text" class="form-control" id="username" name="username" value="${customer.getUsername()}" readonly>
					</div>
				</div>
				<div class="mb-3">
					<label for="email">Email <span class="text-muted">(Optional)</span></label> 
					<input type="email" class="form-control" id="email" value="${customer.getEmail()}" readonly>
					<div class="invalid-feedback">Please enter a valid email address for shipping updates.</div>
				</div>
				
				<div class="mb-3">
					<label for="receiver">Receiver</label> 
					<input type="text" class="form-control" id="receiver" name="receiver" placeholder="" value="" required>
					<div class="invalid-feedback">Please enter your shipping address.</div>
				</div>				
				<div class="mb-3">
					<label for="address">Address</label> 
					<input type="text" class="form-control" id="address" name="address" placeholder="1234 Main St" value="${customer.getAddress()}" required>
					<div class="invalid-feedback">Please enter your shipping address.</div>
				</div>
				<div class="mb-3">
					<label for="phone">Phone</label> 
					<input type="text" class="form-control" id="phone" name="phone" placeholder="0123456789" value="${customer.getPhone()}" required>
					<div class="invalid-feedback">Please enter your shipping address.</div>
				</div>

				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="country">Country</label> <select class="custom-select d-block w-100" id="country" name="" required>
							<option value="">Choose...</option>
							<option value="Viet Nam">viet Nam</option>
						</select>
						<div class="invalid-feedback">Please select a valid country.</div>
					</div>
					<div class="col-md-6 mb-3">
						<label for="state">State</label> <select class="custom-select d-block w-100" id="state" required>
							<option value="">Choose...</option>
							<option value="Ha Noi">Ha Noi</option>
							<option value="TP. Ho Chi minh">TP. Ho Chi minh</option>
							<option value="Vinh">Vinh</option>
						</select>
						<div class="invalid-feedback">Please provide a valid state.</div>
					</div>
				</div>
				<hr class="mb-4">

				<!-- save infomartion for the next time -->

				<!-- <div class="custom-control custom-checkbox">
					<input type="checkbox" class="custom-control-input" id="save-info"> <label class="custom-control-label" for="save-info">Save this information for next time</label>
				</div> -->

				<hr class="mb-4">

				<h4 class="mb-3">Payment</h4>

				<div class="d-block my-3">
					<div class="custom-control custom-radio">
						<input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked required> 
						<label class="custom-control-label" for="credit">Credit card</label>
					</div>
					<div class="custom-control custom-radio">
						<input id="debit" name="paymentMethod" type="radio" class="custom-control-input" required> 
						<label class="custom-control-label" for="debit">Debit card</label>
					</div>
					<div class="custom-control custom-radio">
						<input id="pay-directly" name="paymentMethod" type="radio" class="custom-control-input" required> 
						<label class="custom-control-label" for="pay-directly">Pay directly</label>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="cc-name">Name on card</label> <input type="text" class="form-control" id="cc-name" placeholder="" required> <small class="text-muted">Full name as displayed on card</small>
						<div class="invalid-feedback">Name on card is required</div>
					</div>
					<div class="col-md-6 mb-3">
						<label for="cc-number">Credit card number</label> 
						<input type="text" class="form-control" id="cc-number" name="ccNumber" placeholder="" required>
						<div class="invalid-feedback">Credit card number is required</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3 mb-3">
						<label for="cc-expiration">Expiration</label> <input type="text" class="form-control" id="cc-expiration" placeholder="" required>
						<div class="invalid-feedback">Expiration date required</div>
					</div>
					<div class="col-md-3 mb-3">
						<label for="cc-cvv">CVV</label> <input type="text" class="form-control" id="cc-cvv" placeholder="" required>
						<div class="invalid-feedback">Security code required</div>
					</div>
				</div>
				<hr class="mb-4">
				<button class="btn btn-primary btn-lg btn-block" type="submit">Continue to checkout</button>
			</form>
		</div>

		<div></div>

		<!-- Cart -->
		<div class="Content col-lg-3 col-md-3 col-sm-3 col-xs-12">
		
			<h4 class="d-flex justify-content-between align-items-center mb-3">
				<span class="headline">Your cart</span> 
				<span class="badge badge-secondary badge-pill">${cart.numberOfItems}</span>
			</h4>
			
			<ul class="list-group mb-3">
				<li class="list-group-item d-flex justify-content-between lh-condensed">
					<div>
						<h6 class="my-0">Total order</h6>
					</div>
					<fmt:formatNumber type="currency" currencySymbol="&dollar; " value="${cart.subtotal}" />
				</li>
				<li class="list-group-item d-flex justify-content-between lh-condensed">
					<div>
						<h6 class="my-0">Delivery Surcharge</h6>
					</div>
					<fmt:formatNumber type="currency" currencySymbol="&dollar; " value="5" />
				</li>
				<li class="list-group-item d-flex justify-content-between bg-light">
					<div class="text-success">
						<h6 class="my-0">Promo code</h6>
					</div> 
					<span class="text-success">$0</span>
				</li>
				<li class="list-group-item d-flex justify-content-between">
				<span>Total (USD)</span> 
				<strong><fmt:formatNumber type="currency" currencySymbol="&dollar; " value="${cart.subtotal + 5}" /></strong></li>
			</ul>

			<form class="card p-2">
				<a class="btn btn-primary btn-lg btn-block" href="<c:url value='viewCart'/>">View your Cart</a>
			</form>
		</div>
	</div>
</div>

