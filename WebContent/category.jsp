<c:set var="pageTitle" scope="request" value="${title}"/>
<%@page import="entity.Category"%>
<%@page import="java.util.List"%>
<%@page import="entity.Product"%>
<%
	session.setAttribute("view", "/category");
	Category category = (Category) request.getAttribute("category");
	List<Product> products = (List<Product>) request.getAttribute("products");
	
%>
<hr> 
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
				<p>We offer you a Free Shipping, if your order value is over
					1000.000 VND. For more information please check:</p>
				<p>
					<a href="#">Free Shipping Information and Conditions</a>
				</p>
			</div>
			<div class="SideBarItem">
				<h4>Pickup</h4>
				<p>You can pickup your goods, after you placed an order and and
					received a ready-for-pickup notification.</p>
			</div>
		</div>
		<div class="Content col-lg-10 col-md-10 col-sm-9 col-xs-12">
			<!-- product -->
			<div>
				<hr>
				<div>
					<h1><%=category.getName()%></h1>
				</div>
				<hr>
				<div class="container">
					<div class="row row-cols-4">						
							<%
								for (Product p : products) {
							%>
								<div class="col">	
										<p>
											<a title="<%=p.getName()%>" href="img/demo/<%=p.getImage()%>" class="portfolio-item-preview" datarel="prettyPhoto"> 							
											<img src="img/demo/<%=p.getImage()%>" alt="" width="210" height="145" class="portfolio-img pretty-box">
											</a>
										</p>
										<h4><a href="#"><%=p.getName()%></a></h4>
										<c:if test="${account == 1 }">
											<p>Quantity in stock: <%=p.getQuantity()%></p>
										</c:if>									
										<p><%=p.getDescription()%></p>
										<p style="text-align: left">
											<a href="product?<%=p.getProductId()%>" class="button_small white">See Details &raquo;</a>
										</p>
								</div>
							<%
								}
							%>					
					</div>
				</div>
			</div>
			<div style="clear: both; height: 40px"></div>
		</div>
</div>
</div>
