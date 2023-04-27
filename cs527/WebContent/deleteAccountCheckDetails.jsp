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
if (request.getMethod().equals("POST")) {
  String enteredPassword = request.getParameter("password");
  
  ApplicationDB db = new ApplicationDB();	
  Connection con = db.getConnection();
  Statement st = con.createStatement();
  ResultSet rs;
  rs = st.executeQuery("select password from user where user_id='" + user_id+"'");
  if(rs.next())
  {
	  String password_db = rs.getString("password");
	  
	    if (enteredPassword.equals(password_db)) {
	      response.sendRedirect("deleteAccount.jsp");
	    } else {
	    	response.sendRedirect("success.jsp");
	    }
  }
  st.close();
  con.close();
}
%>

</body>
</html>