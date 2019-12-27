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
			<h4 class="headline">All customers</h4>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>No.</th>
						<th>Username</th>
						<th>Name</th>
						<th>Email</th>						
						<th>Phone</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					
					<c:forEach var="customerProfile" items="${customers}" varStatus="iter">
						<tr>
							<td>${iter.count }</td>
						    <td>${customerProfile.getUsername()}</td>
						    <td>${customerProfile.getName()}</td>
						    <td>${customerProfile.getEmail()}</td>
						    <td>${customerProfile.getPhone()}</td>
						    <td><a href="<c:url value='profile?${customerProfile.getCustomerId() }' />">See more details</a>
						    </form></td>						    
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

