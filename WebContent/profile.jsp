
<link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
 <div class="container">
       
            <div class="row">
                <div class="col-md-4">
                    <div class="profile-img">
                        <img src="https://hotnew.com.vn/upload/baiviet/avatar-9741.jpg"  alt=""/>
                        <div class="file btn btn-lg btn-primary">
                            Change Photo
                            <input type="file" name="file"/>
                        </div>
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
                        <p class="proile-rating"></p>
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a  class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Profile</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Purchase History</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="edit-profile-tab" data-toggle="tab" href="#edit-profile" role="tab" aria-controls="edit-profile" aria-selected="false">Edit Profile</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="address-book" data-toggle="tab" href="#address-book" role="tab" aria-controls="address-book" aria-selected="false">Edit Profile</a>
                            </li>

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
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <p>The function is not complete</p>

                            </div>
                            <div class="tab-pane fade" id="address-book" role="tabpanel" aria-labelledby="adress-book-tap">
                                <p>take care by yourself. i dont help you any more.!!</p>
                            </div>
                           
                            <div class="tab-pane fade show "  id="edit-profile" role="tabpanel" aria-labelledby="edit-profile-tab">
                                <form action="/Lab8a/editProfile" method="post"> 
                                <div class="row ">
                                    <div class="col-md-4">
                                        <label>Password</label>
                                    </div>
                                    <div class=" col-md-8">
                                        <input  class="form-control" type="text" value="${customer.getPassword() }" name="pass">
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
                                        <input class="form-control" type="text" value="${customer.getCity() }" name="city-region">
                                    </div>
                                </div>
                                <br>
                                <button class="col-md-4 profile-edit-btn" value="Update Profile">Update Profile
                                </button>
                               	</form>   
                            </div>
                            
                        </div>
                        

                        
                    </div>


                    
                </div>
            </div>
                
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> 
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> 