<%@page import="session_bean.CustomerSessionBean"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.List"%>



<%
	session.setAttribute("view", "/viewProfile");
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
		</div>
		<!-- Content -->
		
		<div class="Content col-lg-7 col-md-7 col-sm-6 col-xs-12">
			<c:if test="${customerErrorFlag}">
				<p style="color: #c00; font-style: italic">We were unable to show customer's profile. Please enter the correct username!</p>
			</c:if>
			
			<c:if test="${account == 1}">
				<h4 class="headline">Admin checkout for customer</h4>
				<form class="needs-validation" action="<c:url value='chooseCustomerToViewProfile' />" method="post" >
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
			

			
			<
		</div>

		<div></div>

		<!-- Cart -->
		<div class="Content col-lg-3 col-md-3 col-sm-3 col-xs-12"></div>
	</div>
</div>

