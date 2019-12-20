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