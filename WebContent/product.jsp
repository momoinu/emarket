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
				<c:if test="${editProductSuccessfully }"><p style="color: #c00; font-style: italic">Update product successfully!</p></c:if>
				<hr>
				<div class="row">
					<div class="col-6">
						
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
							<div class="panel-body">
							<c:choose>
								
									<c:when test="${account != 1}">
										<div style="margin: 10px 10px 0px 10px;">														
									<h3>Price</h3>
									<p><%=selectedProduct.getPrice()%>$</p>								
									<h3>Accessories</h3>
									<p><%=selectedProductDetail.getAccessories()%></p>
									<h3>Warranty Strategy</h3>
									<p><%=selectedProductDetail.getGuaranty()%></p>

									<a href="<c:url value='addToCart?${selectedProduct.getProductId()}'/>" >
										<div style="font-size: 30px" class="fa fa-cart-plus btn-block"> Add to cart</div>
									</a>
									<h3 style="margin-top:10px;">Technical Details</h3>
									<p style="padding-bottom:20px;">
										<%=selectedProductDetail.getInformation()%>
									</p>
									
								</div>
									</c:when>
									<c:when test="${account == 1}">
										<p class="proile-rating"></p>
                        			<ul style="color:black;" class="nav nav-tabs" id="myTab" role="tablist">
                            			<li class="nav-item">
                                			<a  class="nav-link active" id="product-tap" data-toggle="tab" href="#product" role="tab" aria-controls="product" aria-selected="true">Detail</a>
                           				</li>
                           				 <li class="nav-item">
                           				    <a class="nav-link" id="edit-product-tap" data-toggle="tab" href="#edit-product" role="tab" aria-controls="edit-product" aria-selected="false">Edit Product</a>
                           				 </li>
                           				 <li class="nav-item">
                           				    <a class="nav-link" id="delete-product-tap" data-toggle="tab" href="#delete-product" role="tab" aria-controls="delete-product" aria-selected="false">Delete Product</a>
                           				 </li>
                            			
                        			</ul>
                        			  <div class="tab-content profile-tab" id="myTabContent">
                        			  
       <!-- ------------------------------------------------------------------------------------------------------------------------------- -->                 			  
                        			  
			                          <div class="tab-pane fade show active" id="product" role="tabpanel" aria-labelledby="product-tab">
			                             <div style="margin: 10px 10px 0px 10px;">
										<h3>Quantity of stock</h3>
										<p><%=selectedProduct.getQuantity()%></p>															
										<h3>Price</h3>
										<p><%=selectedProduct.getPrice()%>$</p>								
										<h3>Accessories</h3>
										<p><%=selectedProductDetail.getAccessories()%></p>
										<h3>Warranty Strategy</h3>
										<p><%=selectedProductDetail.getGuaranty()%></p>
			
										<a href="<c:url value='addToCart?${selectedProduct.getProductId()}'/>" >
											<div style="font-size: 30px" class="fa fa-cart-plus btn-block"> Add to cart</div>
										</a>
										<h3 style="margin-top:10px;">Technical Details</h3>
										<p style="padding-bottom:20px;">
											<%=selectedProductDetail.getInformation()%>
										</p>
										
									</div>
		                          </div>
		                            <div class="tab-pane fade show "  id="edit-product" role="tabpanel" aria-labelledby="edit-product-tab">
			                            	
			                            	
			                                 <div style="margin: 10px 10px 0px 15px;">
			                                 <br>
			                                 <a href="<c:url value='deleteProduct?${selectedProduct.getProductId()}'/>">
													
												
												</a>
				                                <form action="/Lab8a/editProduct" method="post">
					                                		<input type="text"  value="${selectedProduct.getProductId() }" hidden name="id">
													<h3>Quantity of stock</h3>
														<input class="form-control"  value="${selectedProduct.getQuantity() }" type="text" name="quantity">															
													<h3>Price</h3>
														<input class="form-control"  value="${selectedProduct.getPrice() }" type="text" name="price">
																					
													<h3>Accessories</h3>
														<input class="form-control"  value="${selectedProductDetail.getAccessories() }" type="text" name="accessory">
													<h3>Warranty Strategy</h3>
														<input class="form-control"  value="${selectedProductDetail.getGuaranty() }" type="text" name="warranty">
																
													<h3 style="margin-top:10px;">Technical Details</h3>
														<textarea class="form-control" type="text" style="height: 300px;" aria-label="With textarea" name="technical-details">
															${selectedProductDetail.getInformation() }
														</textarea>
													
													<br> <br>
													<button class="col-md-4 profile-edit-btn" >Update</button>
												</form>	
												<br>
											</div>
										</div>
							<div class="tab-pane fade show" id="delete-product" role="tabpanel" aria-labelledby="delete-product-tab">
								<br>
								<button style="color:red; font-size:30 " class="form-control col-md-4 fa fa-close"> Delete Product</button>
								<br>
							</div>
									</c:when>
								</c:choose>			
														                             
                            </div>
                        </div>												
					</div>
					
					
				</div>
			</div>
		</div>
	</div>
	<div style="clear: both; height: 40px"></div>
</div>