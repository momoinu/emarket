<%@page import="session_bean.CustomerSessionBean"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.List"%>



<%
	session.setAttribute("view", "/viewProfile");
%>

<div class="container-fluid">
	<div class="row">
		<!-- left -->
		<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
		</div>
		<!-- Content -->
		
		<div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
			<h4 class="headline">All orders</h4>
			<br>
			<p>Please click the confirmation number to see more detail!</p>
			<hr>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>No.</th>
						<th>Confirm Number</th>
						<th>Name Customer</th>
						<th>Username</th>
						<th>Date</th>
						<th>Status</th>
						<th></th>
					</tr>
				</thead>
				<tbody>				
					<c:forEach var="customerOrder" items="${customerOrderHistories}" varStatus="iter">
						<c:set var="customer" value="${customerOrder.getCustomer()}" />
						<tr>
							<td>${iter.count }</td>
						    <td><a href="<c:url value='orderDetail?${customerOrder.getOrderId()}'/>">${customerOrder.getConfirmationNumber()}</td>
						    <td>${customer.getName()}</td>
						    <td>${customer.getUsername()}</td>
						    <td>${customerOrder.getDateCreated()}</td>
						    
							<td>
								<c:if test="${customerOrder.status == 3 }">
									<p><b>Delivered</b></p>
								</c:if>
								<c:if test="${customerOrder.status == 1}">
									<p><b>Awaiting delivery</b></p>						
								</c:if>	
								<c:if test="${customerOrder.status == 2}">
									<p><b>Shipping</b></p>						
								</c:if>	
								<c:if test="${customerOrder.status == 4}">
									<p><b>Cancel Order</b></p>						
								</c:if>	
								<c:if test="${customerOrder.status < 3}">
									<form action="<c:url value='updateStatusOrder'/>" method="post">
									<input type="hidden" name="orderId" value="${customerOrder.orderId}" /> 							
									<select name="status" id="status">
											<option value="">- Status -</option>
											<option value="1">Waiting to Delivery</option>
											<option value="2">Shipping</option>
											<option value="3">Delivered</option>
											<option value="4">Cancel Order</option>
											
										</select>
									<input type="submit" name="submit" value="update" />
									</form>						
								</c:if>										
							</td>				    
						</tr>
			        </c:forEach>
				</tbody>
			</table>
			
		</div>

		<div></div>

		<!-- Cart -->
		<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2"></div>
	</div>
</div>

