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

	Adding to Wishlist :)
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String user_id = request.getParameter("user_id");
		String cat_id = request.getParameter("category_id");
		String subcat_id = request.getParameter("subcategory_id");
		String item_id = request.getParameter("item_id");
		
		String insert = "INSERT INTO wishlist(user_id, cat_id, subcat_id, item_id)"
				+ "VALUES (?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, user_id);
		ps.setString(2, cat_id);
		ps.setString(3, subcat_id);
		ps.setString(4, item_id);
		ps.executeUpdate();
		
		out.println("Item added successfully!");
		
		
		out.println("<form action='wishlist.jsp' method='POST'>");
		out.println("<input type='hidden' name='going_back' value='true'>");
		out.println("<input type='submit' value='Go Back'>");
		out.println("</form>");
		
		out.println("<br><a href='userLogin.jsp'>Go to home page.</a>");
			
		con.close();
	%>

</body>
</html>