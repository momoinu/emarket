<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<form class="form-horizontal" action="addproduct" method="get">
	<fieldset>

		<!-- Form Name -->
		<legend style="text-align: center">ADD PRODUCT</legend>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_id">PRODUCT ID</label>
			<div class="col-md-4">
				<input id="product_id" name="productId" placeholder="PRODUCT ID" class="form-control input-md" type="text">

			</div>
		</div>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_name">PRODUCT NAME</label>
			<div class="col-md-4">
				<input id="product_name" name="name" placeholder="PRODUCT NAME" class="form-control input-md" type="text">

			</div>
		</div>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_description">PRODUCT DESCRIPTION</label>
			<div class="col-md-4">
				<input id="product_description" name="description" placeholder="PRODUCT DESCRIPTION" class="form-control input-md" type="text">

			</div>
		</div>

		<!-- Textarea -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_descriptionDetail">DESCRIPTION DETAIL</label>
			<div class="col-md-4">
				<textarea class="form-control" id="product_descriptionDetail" placeholder="DESCRIPTION DETAIL" name="descriptionDetail"></textarea>
			</div>
		</div>

		<!-- Textarea -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_information">INFORMATION</label>
			<div class="col-md-4">
				<textarea class="form-control" id="product_information" placeholder="INFORMATION" name="information"></textarea>
			</div>
		</div>
		
		<!-- Select Basic -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_category">CATEGORY</label>
			<div class="col-md-4">
				<select id="product_category" name="categoryId" class="form-control">
					<option value="1">Mac</option>
					<option value="2">Iphone</option>
					<option value="3">ipad</option>
					<option value="4">Accessories</option>
				</select>
			</div>
		</div>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_accessories">ACCESSORIES</label>
			<div class="col-md-4">
				<input id="product_accessories" name="accessories" placeholder="ACCESSORIES" class="form-control input-md" type="text">

			</div>
		</div>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_guaranty">GUARANTY</label>
			<div class="col-md-4">
				<input id="product_guaranty" name="guaranty" placeholder="GUARANTY" class="form-control input-md" type="text">

			</div>
		</div>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="product_price">PRICE</label>
			<div class="col-md-4">
				<input id="product_price" name="price" placeholder="PRICE" class="form-control input-md" type="text">

			</div>
		</div>

		<!-- File Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="filebutton">IMAGE</label>
			<div class="col-md-4">
				<input id="filebutton" name="image" class="input-file" type="file">
			</div>
		</div>
		<!-- File Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="filebutton">auxiliary_images1</label>
			<div class="col-md-4">
				<input id="filebutton" name="image1" class="input-file" type="file">
			</div>
		</div>
		<!-- File Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="filebutton">auxiliary_images2</label>
			<div class="col-md-4">
				<input id="filebutton" name="image2" class="input-file" type="file">
			</div>
		</div>
		<!-- File Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="filebutton">auxiliary_images3</label>
			<div class="col-md-4">
				<input id="filebutton" name="image3" class="input-file" type="file">
			</div>
		</div>
		<!-- File Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="filebutton">auxiliary_images4</label>
			<div class="col-md-4">
				<input id="filebutton" name="image4" class="input-file" type="file">
			</div>
		</div>
		<!-- File Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="filebutton">auxiliary_images5</label>
			<div class="col-md-4">
				<input id="filebutton" name="image5" class="input-file" type="file">
			</div>
		</div>

		<!-- Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="singlebutton">Single Button</label>
			<div class="col-md-4">
				<button id="singlebutton" name="singlebutton" type="submit" class="btn btn-primary">Submit</button>
			</div>
		</div>

	</fieldset>
</form>
