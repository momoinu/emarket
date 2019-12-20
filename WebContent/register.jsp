   
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Login </title>
	<meta charset="UTF-8">
	
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form-title" style="background-image: url(images/Lol.team.png);">

					<span class="login100-form-title-1">
						Register 
					</span>
					<p style="color: white;">Quick and easy</p>
				</div>
				
				<form action="/Lab8a/register" method="post" class="login100-form validate-form" >
					<div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
						<span class="label-input100">Username</span>
						<input class="input100" type="text" name="username" placeholder="Enter username">
						<span class="focus-input100"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-18" data-validate = "Password is required">
						<span class="label-input100">Password</span>
						<input class="input100" type="password" name="password" placeholder="Enter password">
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
						<span class="label-input100">Name</span>
						<input class="input100" type="text" name="name" placeholder="Enter your name">
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
						<span class="label-input100">Email</span>
						<input class="input100" type="text" name="email" placeholder="Enter your email">
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
						<span class="label-input100">Phone</span>
						<input class="input100" type="text" name="phone" placeholder="Enter your phone number">
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
						<span class="label-input100">Address</span>
						<input class="input100" type="text" name="address" placeholder="Enter address">
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
						<span class="label-input100">City Region</span>
						<input class="input100" type="text" name="city_region" placeholder="Enter city region">
						<span class="focus-input100"></span>
					</div>
					
					<div class="container-login100-form-btn">
						<button style="background-color: #8c52ff;" class="login100-form-btn">
							Register now
						</button>
					</div>
				</form>
				<div style="margin: -40px 0 20px 0;">
					<p style="text-align:center;"><a href="login.jsp" >Login</a><a style="margin-left: 50px;" href="index.jsp">Home</a></p>					
				</div>			
			</div>			
		</div>
	</div>
</body>
</html>