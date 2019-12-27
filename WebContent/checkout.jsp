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
	

%>


<c:if test="${account != 1 && account != 2 }">
	<script type="text/javascript">
		alert('Please login before checkout');
		window.location = 'login.jsp';
	</script>
</c:if>




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
			<c:if test="${orderFailureFlag}">
				<p style="color: #c00; font-style: italic">We were unable to process your order. Please try again!</p>
			</c:if>
			<c:if test="${validationFailureFlag}">
				<p style="color: #c00; font-style: italic">We were unable to process your order. Please complete all information!</p>
			</c:if>
			<c:if test="${usernameFailureFlag}">
				<p style="color: #c00; font-style: italic">We were unable to process your order. Please enter the correct username!</p>
			</c:if>
			
			<c:if test="${account == 1}">
				<h4 class="headline">Admin checkout for customer</h4>
				<form class="needs-validation" action="<c:url value='chooseCustomerToCheckout' />" method="post" >
					<div class="mb-3">
						<label for="usernameOfCustomer">Username</label>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">Username of customer:</span>
							</div>
							<input type="text" class="form-control" id="usernameOfCustomer" name="usernameOfCustomer" value="${customer.getUsername() }" required>
						</div>
					</div>
					<button class="btn btn-primary btn-lg btn-block" type="submit">Continue to get information of customer</button>
				</form>				
				
				<hr class="mb-4">
			</c:if>
			
			<h4 class="headline">Choose AddressBook</h4>
			<c:choose>
				<c:when test="${customer != null}">
					<!-- Choose addressbook -->
					<c:if test="${addressBook == null}"> <p style="color: #c00; font-style: italic">Please select an Address Book!</p></c:if>					
					<form class="needs-validation mb-3" action="<c:url value='addressBook' />" method="post" >			
						<label for="addressBook">Address Book</label>						
						<select class="custom-select d-block w-100" id="addressBook" name="addressBookId" required>								
							<c:choose>
								<c:when test="${addressBook == null }"><option value="">Choose... </option>	
								</c:when>
								<c:otherwise>
									<option value="">
										<b>${addressBook.getReceiver()}: ${addressBook.getPhone()},   </b>
										<span>${addressBook.getAddress()}, ${addressBook.getCity()}</span> 
									</option>
								</c:otherwise>
							</c:choose>
									
							<c:forEach var="addressBook" items="${addressBooks}">
								<option value="${addressBook.getAddressId()}">
									<b>${addressBook.getReceiver()}: ${addressBook.getPhone()},   </b>
									<span>${addressBook.getAddress()}, ${addressBook.getCity()}</span>  
								</option>
							</c:forEach>
							<option value="createNewAddressBook">Create New Address Book</option>	
						</select>
						<div class="invalid-feedback">Please select a valid address book.</div>
						<br>
						<button class="btn btn-primary btn-lg btn-block" type="submit">Confirm</button>
					</form>	
				</c:when>
				<c:otherwise>
					<p style="color: #c00; font-style: italic">Please select customer first!</p>
				</c:otherwise>
			</c:choose>
			
			
			<hr class="mb-4">
			<hr class="mb-4">
			
			<!-- Infomartion -->
			<h4 class="headline">Billing address</h4>
			<form class="needs-validation" action="<c:url value='purchase' />" method="post" >
				<div class="mb-3">
					<label for="name">Name</label> 
					<input type="text" class="form-control" id="name" value="${customer.getName()}" readonly required>
				</div>
				
				<div class="mb-3">
					<label for="email">Email <span class="text-muted">(Optional)</span></label> 
					<input type="text" class="form-control" id="email" value="${customer.getEmail()}" readonly required>
					<div class="invalid-feedback">Please enter a valid email address for shipping updates.</div>
				</div>
				<div class="mb-3">
					<label for="username">Username</label>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text">User</span>
						</div>
						<input type="text" class="form-control" id="username" name="username" value="${customer.getUsername()}" readonly required>
					</div>
				</div>
				
				
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="receiver">Receiver</label> 
						<input type="text" class="form-control" id="receiver" name="receiver"  value="${addressBook.getReceiver()}" required readonly>
						<div class="invalid-feedback">Please enter your shipping address.</div>
					</div>
					<div class="col-md-6 mb-3">
						<label for="phone">Phone</label> 
						<input type="text" class="form-control" id="phone" name="phone"   value="${addressBook.getPhone()}" required readonly>
						<div class="invalid-feedback">Please enter your shipping address.</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="address">Address</label> 
						<input type="text" class="form-control" id="address" name="address"  value="${addressBook.getAddress()}" required readonly>
						<div class="invalid-feedback">Please enter your shipping address.</div>
					</div>	
					<div class="col-md-6 mb-3">
						<label for="city">City</label> 
						<input type="text" class="form-control" id="city" name="city"  value="${addressBook.getCity()}" required readonly>
						<div class="invalid-feedback">Please enter your shipping address.</div>
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
						<input id="pay-directly" name="paymentMethod" type="radio" class="custom-control-input" checked> 
						<label class="custom-control-label" for="pay-directly">Pay directly</label>
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

