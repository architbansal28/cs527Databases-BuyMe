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

	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String old_pwd = request.getParameter("old");
		String new_pwd = request.getParameter("new");
		
		ResultSet result = stmt.executeQuery("select * from user where user_id='" + session.getAttribute("user").toString()+ "' and password='" + old_pwd+ "'");
		if (result.next()) {
			if (old_pwd.equals(new_pwd)) {
				out.println("New password cannot be same as current password! <a href='changePassword.jsp'>Go back.</a>");
			} else {
				String update = "UPDATE user SET password=? WHERE user_id=?";
				PreparedStatement ps = con.prepareStatement(update);
				ps.setString(1, new_pwd);
				ps.setString(2, session.getAttribute("user").toString());
				ps.executeUpdate();
				out.println("Password updated successfully! <a href='userLogin.jsp'>Go to home page.</a>");
			}
		} else {
			out.println("Current password does not match! <a href='changePassword.jsp'>Go back.</a>");
		}
	
		con.close();
	%>

</body>
</html>