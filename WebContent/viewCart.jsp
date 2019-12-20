<c:set var='view' value='/viewCart' scope='session' />
<div class="container">
	<hr>
	<div>
		<h1 style="margin-left: 50px;">Information of your cart</h1>
	</div>
	<hr>
	<div class="row">
		<div class="col-8">
			<c:if test="${!empty cart && cart.numberOfItems != 0}">
				<table class="table">
					<thead>
						<tr>
							<th>Product</th>
							<th>Price</th>
							<th>Quantity</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="cartItem" items="${cart.items}" varStatus="iter">
							<c:set var="product" value="${cartItem.product}" />
							<tr>
								<td>${product.name}</td>
								<td class=""><fmt:formatNumber type="currency" currencySymbol="&dollar; " value="${cartItem.total}" /> <br> 
									<span class="smallText">
											( <fmt:formatNumber type="currency" currencySymbol="&dollar; " value="${product.price}" /> / unit )
									</span>
								</td>
								<td>
									<form action="<c:url value='updateCart'/>" method="get">
										<input type="hidden" name="productId" value="${product.productId}" />
										<input type="text" maxlength="2" size="2" value="${cartItem.quantity}" name="quantity" style="margin: 5px" />
										<input type="submit" name="submit" value="update" />
									</form>
								</td>
							</tr>
						</c:forEach>
						<tr>
							<td></td>
							<td>Total: <fmt:formatNumber type="currency" currencySymbol="&dollar; " value="${cart.subtotal}" /></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</c:if>
		</div>
		<div class="col-4">
			<c:set var="value">
				<c:choose>
					<%-- if 'selectedCategory' session object exists, send user to previously viewed category --%>
					<c:when test="${!empty selectedCategory}">category</c:when>
					<%-- otherwise send user to welcome page --%>
					<c:otherwise>index.jsp</c:otherwise>
				</c:choose>
			</c:set>
			<ul class="sidebar_menu" style="margin: 0">
				<li>
					<a href="#">
						<strong> 
							<c:choose>
								<c:when test="${cart.numberOfItems > 1}">Your cart contains ${cart.numberOfItems} items</c:when>
								<c:when test="${cart.numberOfItems == 1}">Your cart contains ${cart.numberOfItems} item</c:when>
								<c:otherwise>Your cart is empty</c:otherwise>
							</c:choose>
						</strong>
					</a>
				</li>
				<c:if test="${!empty cart && cart.numberOfItems != 0}">
					<c:url var="url" value="viewCart">
						<c:param name="clear" value="true" />
					</c:url>
					<li>
						<a href="${url}">&#x279f; Clear your cart</a>
					</li>
				</c:if>
				<c:url var="url" value="${value}" />
				<li>
					<a href="index.jsp">&#x279f; Continue shopping</a>
				</li>
				<c:if test="${!empty cart && cart.numberOfItems != 0}">
					<li>
						<a href="<c:url value='checkout'/>">Proceed to checkout</a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
	<div style="clear: both; height: 40px"></div>
</div>