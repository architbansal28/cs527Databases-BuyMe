<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add To Wishlist</title>
</head>
<body>

<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		Statement stmt = con.createStatement();
		
		//Cannot add items added by user to wishlist
		ResultSet result = stmt.executeQuery("select * from item where created_by !='" + session.getAttribute("user").toString()+ "'");
		
		out.println("<b> All available items:</b><br/>");
		out.println("<table border='1'>");
		out.println("<tr><th>Category</th><th>Subcategory</th><th>Name</th><th>Brand</th><th>Year</th><th>Description</th><th>Description</th><th>Description</th><th>Seller</th><th>Add to Wishlist</th></tr>");
		while (result.next()) {
			out.println("<tr><td>");
			out.print(result.getString("cat_id"));
			out.println("</td><td>");
			out.print(result.getString("subcat_id"));
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
			out.println("</td><td>");
			out.print(result.getString("created_by"));
			out.println("</td><td>");
			out.print("Add To Wishlist"); //TODO: add form for adding to wishlist
			out.println("</td></tr>");
		}
		out.println("</table><br/><br/>");
	%>


<br/><a href='userLogin.jsp'>Go back</a>

</body>
</html>