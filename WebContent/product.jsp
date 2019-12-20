<%@page import="entity.ProductDetail"%>
<%@page import="entity.Product"%>
<%
	session.setAttribute("view", "/product ");
	Product selectedProduct = (Product) session.getAttribute("selectedProduct");
	ProductDetail selectedProductDetail = (ProductDetail) session.getAttribute("selectedProductDetail");
%>
<br>
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
			<div>
				<hr>
				<div>
					<h1><%=selectedProduct.getName()%></h1>
				</div>
				<hr>
				<div class="row">
					<div class="col-6">
						<
						<div class="amazingslider-wrapper" id="amazingslider-wrapper-1"
							style="display: block; position: relative; max-width: 500px; margin: 0px auto 80px;">
							<div class="amazingslider" id="amazingslider-1"
								style="display: block; position: relative; margin: 0 auto;">
								<ul class="amazingslider-slides"
									style="display: none; border-radius: 4px;">
									<%
										for (String img : selectedProductDetail.getAllImages()) {
									%>
									<li><img src="images/<%=img%>" alt="" title="" /></li>
									<%
										}
									%>
								</ul>
								<ul class="amazingslider-thumbnails" style="display: none;">
									<%
										for (String img : selectedProductDetail.getAllImages()) {
									%>
									<li><img src="images/<%=img%>" alt="" title="" /></li>
									<%
										}
									%>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="OfferSingleProduct panel2 panel-default">
							<div  class=""panel-body">
								<div style="margin: 10px 10px 0px 10px;">
									<h3>Price</h3>
									<p><%=selectedProduct.getPrice()%>
										$
									</p>
									
									<h3>Accessories</h3>
									<p><%=selectedProductDetail.getAccessories()%></p>
									<h3>Warranty Strategy</h3>
									<p><%=selectedProductDetail.getGuaranty()%></p>

									<a href="<c:url value='addToCart?${selectedProduct.getProductId()}'/>" >
										<div class="button btn btn-primary btn-lg btn-block">Add to cart</div></a>
									<h3 style="margin-top:10px;">Technical Details</h3>
									<p style="padding-bottom:20px;">
										<%=selectedProductDetail.getInformation()%>
									</p>
									<c:choose>
										<c:when test="${account == 1}">
											<a href="<c:url value='deleteProduct?${selectedProduct.getProductId()}'/>" >
										<div class="button btn btn-primary btn-lg btn-block">Delete Product</div></a>										
										</c:when>										
									</c:choose>									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div style="clear: both; height: 40px"></div>
</div>