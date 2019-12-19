<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<style>
	.form-1 {
   		background-color: rgba(255, 255, 255,0.8 );
    	width: 300px;
    	margin: 60px auto 30px;
    	padding: 10px;
    	position: relative;
    	box-shadow: 0 0 1px rgba(0, 0, 0, 1), 0 3px 7px rgba(0, 0, 0, 0.3), inset 0 1px rgba(255,255,255,1), inset 0 -3px 2px rgba(0,0,0,0.25);
    	border-radius: 5px;
	}
	input{
			font-size: 18px;
			padding: 4px 0px;
		}
	
	button{
  			border: 1px solid;
  			border-radius: 2px;
  			text-align: center;
 			width: 100px;
 			padding: 7px 10px;
 			margin:20px 0px 10px 110px;
	}
	html{
  		background-image: url("https://thanhlycuongphat.com/wp-content/uploads/2019/01/H%C3%ACnh-n%E1%BB%81n-m%C3%A1y-t%C3%ADnh-Gradient-m%C3%A0u-x%C3%A1m.png")
	}
	
	</style>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>Login</title>
</head>
<body>
	<div class="form-1">
	<h1 style="text-align:center;">Lol.team</h1>
	<form action="/Lab8a/login" method="post">
	<strong>
		UserName:  <input  type="text" name="user" required="required"/>
		<br/>
		<br/>
		PassWord: <input type="text" name="pass" required="required"/>	
    <br/>
		<button  type="submit">Login</button>
    </strong>
	</form>
	</div>
	<p style="text-align:center;"><a href="index.jsp" >Home</a></p>

</body>
</html>