<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Delete Account</title>
</head>
<body>
<%
String user_id = (String)session.getAttribute("user");
%>

<h2>Are you sure you want to delete your account?</h2>
<form method="post" action="deleteAccountCheckDetails.jsp">
  <label for="password">Please enter your password to confirm:</label><br>
  <input type="password" id="password" name="password"><br><br>
  <input type="submit" value="Confirm">
</form>



</body>
</html>
