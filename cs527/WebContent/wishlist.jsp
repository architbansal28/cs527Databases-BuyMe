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
	String user_id = session.getAttribute("user").toString();
	
	//Cannot add items added by user to wishlist
	ResultSet result = stmt.executeQuery("select * from item where created_by !='" + user_id + "'");
	
	//ResultSet result = stmt.executeQuery("select * from item");

	if (result.next() == false) {
		out.println("No items in the inventory");
	}

	else{

		out.println("<b> All available items:</b><br/>");
		out.println("<table border='1'>");
		out.println(
		"<tr><th>Category</th><th>Subcategory</th><th>Name</th><th>Brand</th><th>Year</th><th>Description</th><th>Description</th><th>Description</th><th>Seller</th><th>Add to Wishlist</th></tr>");

		do{
			
			String item_id = result.getString("item_id");
			String cat_id = result.getString("cat_id");
			String subcat_id = result.getString("subcat_id");
			
			out.println("<tr><td>");
			out.print(cat_id);
			out.println("</td><td>");
			out.print(subcat_id);
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
			
			out.println("<form action='addWishlistItems.jsp' method='POST'>");
			out.println("<input type='hidden' name='user_id' value='" + user_id + "' >");
			out.println("<input type='hidden' name='category_id' value='" + cat_id + "' >");
			out.println("<input type='hidden' name='item_id' value='" + item_id + "' >");
			out.println("<input type='hidden' name='subcategory_id' value='" + subcat_id + "' >");
			out.println("<input type='submit' value='Add to Wishlist'>");
			out.println("</form>");
			
			out.println("</td></tr>");
		}while (result.next());
		
		out.println("</table><br/><br/>");
	}
	%>


	<br />
	<a href='userLogin.jsp'>Go back</a>

</body>
</html>