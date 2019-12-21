<script src="js/jquery.tools.min.js"></script>
<script>
	$(function() {
		$("#prod_nav ul").tabs("#panes > div", {
			effect : 'fade',
			fadeOutSpeed : 400
		});
	});
</script>
<script>
	$(document).ready(function() {
		$(".pane-list li").click(function() {
			window.location = $(this).find("a").attr("href");
			return false;
		});
	});
</script>
<c:set var='view' value='/index' scope='session' />

<!-- AMAZING SLIDER -->

<div class="bd-example">
	<div id="carouselExampleCaptions" class="carousel slide carousel-fade" data-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active" data-interval="4000">
				<img src="./images/iphone-11.png" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item" data-interval="3000">
				<img src="./images/laptop-gaming2.png" class="d-block w-100"
					alt="...">
				<div class="carousel-caption d-none d-md-block">
					<h1>Laptop Gaming</h1>
				</div>
			</div>
			<div class="carousel-item" data-interval="3000">
				<img src="./images/macbook-pro-13-inch-2019.png" 	
					class="d-block w-100" alt="...">
				<div class="carousel-caption d-none d-md-block">
					<h1>Macbook Pro 13 inch 2019</h1>
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleCaptions"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</div>

<!-- CONTENT -->

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
		<!-- mid -->
		<div class="Content col-lg-10 col-md-10 col-sm-9 col-xs-12">
			<!-- product -->
			<div>
				<hr>
				<h1>Current Offers</h1>				
				<hr>
				<div class="row">
					<c:set var="countProduct" scope="request" value="${1}" />
					<c:forEach var="product" items="${newProducts}">
						<div class="col-xs-6 col-sm-6 col-md-4 col-lg-3">
							<div class="GirdProduct">
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="panel-product-image">
											<a href="<c:url value='product?${product.productId}'/>">
												<div>
													<img style="width: 100%; height: 100%; justify-content: center; align-items: center; -webkit-box-pack: center; -webkit-box-align: center; position: absolute; background: rgb(255, 255, 255); top: 0px; left: 0px;"
														src="${initParam.imgProductPath}${product.getImage()}" alt="">
												</div>
											</a>
										</div>
										<div style="margin-left: 10px;" class="panel-body-text">
											<div class="panel-body-heading">
												<h4 class="panel-product-name">${product.getName()}</h4>
											</div>
											<div class="panel-body-cart-price-area row">
												<div class="panel-body-addtocart col-6">
													<div style="position: relative;">
														<div class="loadable-content-wrap">
															<a href="<c:url value='addToCart?${product.productId}'/>"  style="background-color: white;" type="button" class="btn btn-primary button">
																<img class="InlineIcon" src="img/cart.png" viewBox="0 0 24 24" width="24" heigh="24">
															</a>
														</div>
													</div>
												</div>
												<div style="margin: 7px 0px 0px 20px" class="panel-product-price col">$${product.getPrice()}</div>
											</div>
										</div>
									</div>
									<div class="panel-footer">
										<p style="margin-left: 10px;">${product.getDescription() }</p>
									</div>
								</div>
							</div>
						</div>
						<c:set var="countProduct" scope="request"
							value="${countProduct+1}" />
					</c:forEach>
					<div style="clear: both; margin-top: 200px;"></div>
					<hr>
				</div>	
			</div>
			<!-- category -->
			<div>
				<hr>
				<div>
					<h1>Category</h1>
				</div>
				<hr>
				<div class="row">
					<c:set var="countCategory" scope="request" value="${1}" />
					<c:forEach var="category" items="${newCategories}">
						<div class="col-xs-6 col-sm-6 col-md-4 col-lg-3">
							<div class="GirdProduct">
								<div style="height: 220px;" class="panel panel-default">
									<div class="panel-body">
										<div class="panel-product-image">
											<a href="<c:url value='category?${category.categoryId}'/>">
												<div>
													<img style="width: 100%; height: 100%; justify-content: center; align-items: center; -webkit-box-pack: center; -webkit-box-align: center; position: absolute; background: rgb(255, 255, 255); top: 0px; left: 0px;"
														src="${initParam.imgCategoryPath}${category.getImage()}" alt="">
												</div>
											</a>
										</div>
										<div style="margin-left: 10px;" class="panel-body-text">
											<div align="center" style="margin-top:14px;" class="panel-body-heading">
												<h4 class="panel-product-name">${category.getName()}</h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<c:set var="countCategory" scope="request"
							value="${countCategory+1}" />
					</c:forEach>
					<div style="clear: both; margin-top: 200px;"></div>
					<hr>
				</div>
			</div>
		</div>
	</div>
</div>

