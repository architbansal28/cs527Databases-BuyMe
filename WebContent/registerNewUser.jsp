<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Register</title>
</head>
<body>

	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		Statement stmt1 = con.createStatement();
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String userid = request.getParameter("username");
		String pwd = request.getParameter("password");
		
		if ((session.getAttribute("user") == null)) {
			String str = "SELECT * FROM user WHERE email='" + email + "'";
			ResultSet result = stmt.executeQuery(str);
			String str1 = "SELECT * FROM user WHERE user_id='" + userid + "'";
			ResultSet result1 = stmt1.executeQuery(str1);
			
			if (result.next()) {
				out.println("Account with this email already exists. Please <a href='login.jsp'>log in</a>.");
			}
			else if (result1.next()) {
				out.println("Username not available. Please choose a different username. <a href='register.jsp'>Register</a>");
			}
			else {
				String insert = "INSERT INTO user(user_id, password, name, email)"
						+ "VALUES (?, ?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, userid);
				ps.setString(2, pwd);
				ps.setString(3, name);
				ps.setString(4, email);
				ps.executeUpdate();
				
				insert = "INSERT INTO end_user(user_id)"
						+ "VALUES (?)";
				ps = con.prepareStatement(insert);
				ps.setString(1, userid);
				ps.executeUpdate();
				
				out.println("Account created! Please <a href='login.jsp'>log in</a> to continue.");
			}
			
		} else if (session.getAttribute("user").toString().equals("admin")) {
			String insert = "INSERT INTO user(user_id, password, name, email)"
					+ "VALUES (?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, userid);
			ps.setString(2, pwd);
			ps.setString(3, name);
			ps.setString(4, email);
			ps.executeUpdate();
			
			insert = "INSERT INTO customer_representative(user_id)"
					+ "VALUES (?)";
			ps = con.prepareStatement(insert);
			ps.setString(1, userid);
			ps.executeUpdate();
			
			out.println("Account created! <a href='adminLogin.jsp'>Go to home page.</a>");
		}
			
		con.close();
	%>

</body>
</html>