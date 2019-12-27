<link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
 <div class="">
       
            <div class="row">
                <div class="col-md-4">
                    <div class="profile-img">
                        <img src="https://hotnew.com.vn/upload/baiviet/avatar-9741.jpg"  alt=""/>
                        <c:if test="${account == 2 }">
	                        <div class="file btn btn-lg btn-primary">
	                            Change Photo
	                            <input type="file" name="file"/>
	                        </div>
                        </c:if>
                        
                    </div>
                    
                </div>
              
                <div class="col-md-6">
                    <div class="profile-head">
                    	
                        <h5>
                           	${customer.getName() }
                        </h5>
                        <h6>
                           New member
                        </h6>
                        <c:if test="${createAddressSuccessfully}"> <p style="color: #c00; font-style: italic">Create new address successfully!</p></c:if>		
                        <c:if test="${deleteAddressSuccessfully}"> <p style="color: #c00; font-style: italic">Delete address successfully!</p></c:if>		
                        <c:if test="${pleaseCreateNewAddress }"><p style="color: #c00; font-style: italic">Please choose addressbook and create a new one!</p></c:if>        	
                        <p class="proile-rating"></p>
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
								<a  class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Profile</a>
                            </li>                        	
                            <li class="nav-item">
                                <a class="nav-link" id="purcharse-history-tab" data-toggle="tab" href="#purcharse-history" role="tab" aria-controls="purcharse-history" aria-selected="false">Purchase History</a>
                            </li>                         
                            <li class="nav-item">
								<a class="nav-link" id="address-book-tab" data-toggle="tab" href="#address-book" role="tab" aria-controls="address-book" aria-selected="false">Address book</a>
                            </li>
                            <c:if test="${account == 2 }">
                            	<li class="nav-item">
	                                <a class="nav-link" id="edit-profile-tab" data-toggle="tab" href="#edit-profile" role="tab" aria-controls="edit-profile" aria-selected="false">Edit Profile</a>
	                            </li>                          	
                            </c:if>
                        </ul>
                        <div class="tab-content profile-tab" id="myTabContent">
                        	<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>User Name</label>
                                    </div>
                                    <div class="col-md-8">
                                        <p>${customer.getUsername() }</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>Email</label>
                                    </div>
                                    <div class="col-md-8">
                                        <p>${customer.getEmail() }</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>Phone</label>
                                    </div>
                                    <div class="col-md-8">
                                        <p>${customer.getPhone() }</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>Address</label>
                                    </div>
                                    <div class="col-md-8">
                                        <p>${customer.getAddress() }</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>City Region</label>
                                    </div>
                                    <div class="col-md-8">
                                        <p>${customer.getCity() }</p>
                                    </div>
                                </div>
                            </div>
                             	 
                            <div class="tab-pane fade" id="purcharse-history" role="tabpanel" aria-labelledby="profile-tab">
                                <div class="row">
                                <p>Please click the confirmation number to see more detail!</p>
                                <hr>
                                	<table class="table table-bordered">
										<thead>
											<tr>
												<th>No.</th>
												<th>Confirmation number</th>
												<th>Receiver</th>
												<th>Date created</th>
												<th>Address</th>												
											</tr>
										</thead>
										<tbody>
											<c:forEach var="customerOrder" items="${customerOrders}" varStatus="iter">
												<tr>
													<td>${iter.count }</td>		
												    <td><a href="<c:url value='orderDetail?${customerOrder.getOrderId()}'/>">${customerOrder.getConfirmationNumber()}</td>
												    <td>${customerOrder.getReceiver()}</td>							    
												    <td>${customerOrder.getDateCreated()}</td>
													<td>${customerOrder.getAddress()}</td>	
													
																									
													
												</tr>
									        </c:forEach>
										</tbody>
									</table>
								</div>	
                            </div>
                            <div class="tab-pane fade" id="address-book" role="tabpanel" aria-labelledby="adress-book-tap">
                                <div class="row">
                                	<table class="table table-bordered">
										<thead>
											<tr>
												<th>RECEIVER</th>
												<th>PHONE</th>
												<th>ADDRESS</th>
												<th>CITY</th>
												<c:if test="${account == 2 }"><th></th></c:if>
												
											</tr>
										</thead>
										<tbody>
											<c:forEach var="addressBook" items="${addressBooks}" varStatus="iter">
												<tr>
												    <td>${addressBook.getReceiver()}</td>
												    <td>${addressBook.getPhone()}</td>							    
												    <td>${addressBook.getAddress()}</td>
													<td>${addressBook.getCity()}</td>	
													
													<c:if test="${account == 2 }">
														<td>
															<form action="<c:url value='deleteAddress'/>" method="get">
																<input type="hidden" name="addressId" value="${addressBook.getAddressId()}" /> 
																<button style="color: #c00; font-style: italic" type="submit">Remove</button>
															</form>
														</td>
													</c:if>													
													
												</tr>
									        </c:forEach>
										</tbody>
									</table>
									<c:if test="${account == 2 }">
										<b>ADD ADDRESS: </b>
										<table class="table table-bordered">
											<thead>
												<tr>
													<th>RECEIVER</th>
													<th>PHONE</th>
													<th>ADDRESS</th>
													<th>CITY</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<form action="<c:url value='addAddress'/>" method="post">
													<tr>
														<td><input type="text" class="form-control" name="receiver" required></td>
														<td><input type="text" class="form-control" name="phone" required></td>
														<td><input type="text" class="form-control" name="address" required></td>
														<td><input type="text" class="form-control" name="city" required></td>
														<td><button style="color: #007bff; font-style: italic" type="submit">Add Address</button></td>
													</tr>
												</form>										
											</tbody>
										</table>
									</c:if>
									
                                </div>
                            </div>
                           
                            <div class="tab-pane fade show "  id="edit-profile" role="tabpanel" aria-labelledby="edit-profile-tab">
                                <form action="/emarket/editProfile" method="post"> 
                                <div class="row ">
                                    <div class="col-md-4">
                                        <label>Password</label>
                                    </div>
                                    <div class=" col-md-8">
                                        <input  class="form-control" type="text" value="${customer.getPassword() }" name="password">
                                    </div>
                                </div>
                                <br>                              

                                <div class="row">
                                    <div class="col-md-4">
                                        <label>Name</label>
                                    </div>
                                    <div class="col-md-8">
                                         <input class="form-control" type="text" value="${customer.getName() }" name="name">
                                    </div>
                                </div>
                                <br> 
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>Email</label>
                                    </div>
                                    <div class="col-md-8">
                                         <input class="form-control" type="text" value="${customer.getEmail() }" name="email">
                                    </div>
                                </div>
                                <br> 
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>Phone</label>
                                    </div>
                                    <div class="col-md-8">
                                        <input class="form-control" type="text" value="${customer.getPhone() }" name="phone">
                                    </div>
                                </div>
                                <br> 
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>Address</label>
                                    </div>
                                    <div class="col-md-8">
                                        <input class="form-control" type="text" value="${customer.getAddress() }" name="address">
                                    </div>
                                </div>
                                <br> 
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>City Region</label>
                                    </div>
                                    <div class="col-md-8">
                                        <input class="form-control" type="text" value="${customer.getCity() }" name="city">
                                    </div>
                                </div>
                                <br>
                                <button class="col-md-4 profile-edit-btn" value="Update Profile">Update Profile</button>
                               	</form>   
                            </div>
                            
                        </div>
                        

                        
                    </div>


                    
                </div>
            </div>
                
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> 
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> 