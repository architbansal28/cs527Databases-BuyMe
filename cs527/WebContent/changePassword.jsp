<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Change password</title>
</head>
<body>

	<b>Change password</b>
	<form action="checkChangePassword.jsp" method="POST">
		<table>
			<tr>
				<td>Current password:</td><td><input type="text" name="old" required/></td>
			</tr>
			<tr>
				<td>New password:</td><td><input type="text" name="new" required/></td>
			</tr>
		</table>
		<input type="submit" value="Submit"/>
	</form>

</body>
</html>