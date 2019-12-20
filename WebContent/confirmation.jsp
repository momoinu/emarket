<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Confirmation</title>
</head>

<div class="container-fluid">
	<div class="row">
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
	
		<div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
			<h4 class="headline">Billing address</h4>
			<b>Your order has been successful processed and will be delivery within 24 hours</b>
			<br>
			<br>
			<span>Please keep note of your confirmation number: </span>
			<strong>${orderRecord.confirmationNumber}</strong>
			<br>
			<p>If you have any query concerning your order, fell free to <a href="#">contact us</a>. </p>
			
			<p>Thank you for shopping at the LoL.team Store!See you soon!</p>
			
			<div class="row">
				<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
					<h4 class="headline">Order Summary</h4>
					<hr>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>PRODUCT</th>
								<th>QUANTITY</th>
								<th>PRICE</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="orderedProduct" items="${orderedProducts}" varStatus="iter">
								<tr>
								    <td>
								        ${products[iter.index].name}
								    </td>
								    <td>
								        ${orderedProduct.quantity}
								    </td>
								    <td>
								        ${products[iter.index].price * orderedProduct.quantity}
								    </td>
								</tr>
					        </c:forEach>
							<tr>
								<td>Delivery Surcharge</td>
								<td></td>
								<td>5</td>
							</tr>
							<tr>
								<td>Credit Total</td>
								<td></td>
								<td>5</td>
							</tr>
							<tr>
								<td>Date create</td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
					<h4 class="headline">Delivery Address</h4>
					<hr>
					<table>
						<tr>
							<td colspan="3">
								<strong>Receiver :</strong>
								${customer.name}
								<br>
								<strong>Address :</strong>
								${customer.address}
								<br>
								<strong>Phone :</strong>
								${customer.phone}
							</td>
						</tr>
		               </table>
				</div>
			</div>
		</div>		
	</div>
</div>