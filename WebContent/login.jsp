  
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
						Sign In
					</span>
				</div>

				<form action="/emarket/login" method="post" class="login100-form validate-form" >
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

					<div class="flex-sb-m w-full p-b-30">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="admin-login">
							<label class="label-checkbox100" for="ckb1">
								Login With Admin
							</label>
						</div>

						<div>
							<a href="#" class="txt1">
								Forgot Password?
							</a>
						</div>
					</div>
					<div>
					<div></div>
					<div class="container-login100-form-btn">
						<button style="background-color: #8c52ff;" class="login100-form-btn">
							Login
						</button>
					</div>
				</form>
				<div>
					<p style="margin-top: 20px;position:relative; text-align:center;">If you are a new member? <a href="register.jsp" >Register here</a></p>
					<p style="margin: 20px 0 -60px 0; text-align:center;"><a href="index.jsp">Come back home page</a>
				</div>
				
			</div>			
		</div>
	</div>	
</body>
</html>
