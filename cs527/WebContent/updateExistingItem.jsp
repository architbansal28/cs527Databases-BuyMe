<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Update item</title>
</head>

<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		Statement stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("select * from item where created_by='" + session.getAttribute("user").toString()+ "'");
		
		out.println("<b>Your items:</b><br/>");
		out.println("<table class='styled-table'>");
		out.println("<tr><th>Category ID</th><th>Subcategory ID</th><th>Item ID</th><th>Name</th><th>Brand</th><th>Year</th><th>Description</th><th>Description</th><th>Description</th></tr>");
		while (result.next()) {
			out.println("<tr><td>");
			out.print(result.getString("cat_id"));
			out.println("</td><td>");
			out.print(result.getString("subcat_id"));
			out.println("</td><td>");
			out.print(result.getString("item_id"));
			out.println("</td><td>");
			out.print(result.getString("name"));
			out.println("</td><td>");
			out.print(result.getString("brand"));
			out.println("</td><td>");
			out.print(result.getString("year"));
			out.println("</td><td>");
			out.print(result.getString("desc_1"));
			out.println("</td><td>");
			out.print(result.getString("desc_2"));
			out.println("</td><td>");
			out.print(result.getString("desc_3"));
			out.println("</td></tr>");
		}
		out.println("</table><br/><br/>");
		
		Statement stmt1 = con.createStatement();
		ResultSet result1 = stmt1.executeQuery("select * from category");
	
		out.println("<b>Update item:</b><br/>");
		out.println("<form action='checkUpdateItem.jsp' method='POST'>");
		out.println("<table>");
		out.println("<tr><td>Category ID:</td><td><input type='text' name='cat_id' required/></td></tr>");
		out.println("<tr><td>Subcategory ID:</td><td><input type='text' name='subcat_id' required/></td></tr>");
		out.println("<tr><td>Item ID:</td><td><input type='text' name='item_id' required/></td></tr>");
		out.println("<tr><td>Name:</td><td><input type='text' name='name' required/></td></tr>");
		out.println("<tr><td>Brand:</td><td><input type='text' name='brand' required/></td></tr>");
		out.println("<tr><td>Year:</td><td><input type='number' name='year' min='1500' max='2099' step='1' required/></td></tr>");
		out.println("<tr><td>Desc:</td><td><input type='text' name='desc_1'/></td></tr>");
		out.println("<tr><td>Desc:</td><td><input type='text' name='desc_2'/></td></tr>");
		out.println("<tr><td>Desc:</td><td><input type='text' name='desc_3'/></td></tr>");
		
		out.println("</table>&nbsp;<br/> <input type='submit' value='Submit'>");
		out.println("</form>");
		
		out.println("<br/><a href='userLogin.jsp'>Home page</a>");
	
		con.close();
	%>
	
</body>
</html>