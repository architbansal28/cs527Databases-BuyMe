<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Welcome</title>
</head>
<body>
	<%if ((session.getAttribute("user") == null)) {%>
		You are not logged in<br/>
		<a href="login.jsp">Please Login</a>
	<%} else if (session.getAttribute("user").toString().equals("admin")) {%>
		<jsp:include page='adminLogin.jsp'/>
	<%} else if (session.getAttribute("user").toString().equals("rep1") || session.getAttribute("user").toString().equals("rep2") || session.getAttribute("user").toString().equals("rep3") || session.getAttribute("user").toString().equals("rep4") || session.getAttribute("user").toString().equals("rep5")) {%>
		<jsp:include page='repLogin.jsp'/>
	<%} else {%>
		<jsp:include page='userLogin.jsp'/>
	<%}%>

</body>
</html>