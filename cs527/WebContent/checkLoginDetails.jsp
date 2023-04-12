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
	<%
		String userid = request.getParameter("username");
		String pwd = request.getParameter("password");
		//Class.forName("com.mysql.jdbc.Driver");
		//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root","root");
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from user where user_id='" + userid + "' and password='" + pwd+ "'");
		if (rs.next()) {
			session.setAttribute("user", userid); // the username will be stored in the session
			session.setAttribute("name", rs.getString("name"));
			//out.println("Welcome " + userid);
			//out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("success.jsp");
		} else {
			out.println("Invalid credentials<br/><a href='login.jsp'>Try again</a>");
		}
	%>

</body>
</html>