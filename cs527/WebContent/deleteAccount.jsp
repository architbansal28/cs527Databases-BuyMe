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
	//get the user_id from session
	String user_id = (String)session.getAttribute("user");
	
	//delete user's account from the database
	ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    PreparedStatement stmt=null;
    String sql="DELETE FROM user WHERE user_id=?";
	try {
		stmt = con.prepareStatement(sql);
		stmt.setString(1, user_id);
		stmt.executeUpdate();
		
		//invalidate the session and redirect to login page
		session.invalidate();
		response.sendRedirect("login.jsp");
		
	} catch (Exception e) {
		out.println("Error: "+e.getMessage());
	} finally {
		try {
			if(stmt!=null) stmt.close();
			if(con!=null) con.close();
		} catch(Exception e) {
			out.println("Error: "+e.getMessage());
		}
	}
%>
</body>
</html>