<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
	<title>BuyMe - Login</title>
</head>
	
<body>
	
	<h1>Welcome to BuyMe!</h1>
	<form action="checkLoginDetails.jsp" method="POST">
		<table>
			<tr>
				<td>Username:</td><td><input type="text" name="username" required /></td>
			</tr>
			<tr>
				<td>Password:</td><td><input type="password" name="password" required /></td>
			</tr>
		</table><br/>
		<input type="submit" value="Login"/>
	</form><br/><br/>
	
	Not a member? <a href='register.jsp'>Register</a>

</body>
</html>