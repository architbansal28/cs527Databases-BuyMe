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
	
	
	String going_back = request.getParameter("going_back");
	
	String cat_id = request.getParameter("category");
	String subcat_id = request.getParameter("subcategory");
	String name = request.getParameter("name");
	String brand = request.getParameter("brand");
	String year = request.getParameter("year");
	String color = request.getParameter("color");
	String transmission = request.getParameter("desc_3");
	String price_low = request.getParameter("price_low");
	String price_high = request.getParameter("price_high");
	
	out.println(cat_id);
	out.println(subcat_id);
	out.println(name);
	out.println(brand);
	out.println(year);
	out.println(color);
	out.println(transmission);
	out.println(price_low);
	out.println(price_high);
	
	
	String WishlistQuery = "select * from item where created_by !='" + user_id + "'";
	
	if(!going_back.matches("true")){
	
		if(!cat_id.isEmpty()){
			WishlistQuery += " AND cat_id LIKE '" + cat_id + "'";
		}
		if(!subcat_id.isEmpty()){
			WishlistQuery += " AND subcat_id LIKE '" + subcat_id + "'";
		}
		if(!name.isEmpty()){
			WishlistQuery += " AND name LIKE '" + name + "'";
		}
		if(!brand.isEmpty()){
			WishlistQuery += " AND brand LIKE '" + brand + "'";
		}
		if(!year.isEmpty()){
			WishlistQuery += " AND year >= '" + year + "'";
		}
	}
	
	out.println(WishlistQuery);
	
	
	//Cannot add items added by user to wishlist
	ResultSet result = stmt.executeQuery(WishlistQuery);
	
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
			cat_id = result.getString("cat_id");
			subcat_id = result.getString("subcat_id");
			
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
		
		result.close();
		
		out.println("</table><br/><br/>");		
	}
		

		
		// Print a Table with current wishlist items
		ResultSet current_wishlist = stmt.executeQuery("select * from wishlist INNER JOIN item ON wishlist.item_id = item.item_id where user_id ='" + user_id + "'");
		
		if (!current_wishlist.isBeforeFirst()) {
			out.println("No items in wishlist");
		}
		
		else{
			out.println("<b> Wishlist items:</b><br/>");
			out.println("<table border='1'>");
			out.println(
			"<tr><th>Category</th><th>Subcategory</th><th>Name</th><th>Brand</th><th>Year</th><th>Description</th><th>Description</th><th>Description</th><th>Seller</th><th>Remove from Wishlist</th></tr>");

			while (current_wishlist.next()){
				
				String item_id = current_wishlist.getString("item_id");
				cat_id = current_wishlist.getString("cat_id");
				subcat_id = current_wishlist.getString("subcat_id");
				
				//result = stmt.executeQuery("select * from item where item_id ='" + item_id + "'");
				//result.next();
				
				out.println("<tr><td>");
				out.print(cat_id);
				out.println("</td><td>");
				out.print(subcat_id);
				out.println("</td><td>");
				out.print(current_wishlist.getString("name"));
				out.println("</td><td>");
				out.print(current_wishlist.getString("brand"));
				out.println("</td><td>");
				out.print(current_wishlist.getString("year"));
				out.println("</td><td>");
				out.print(current_wishlist.getString("desc_1"));
				out.println("</td><td>");
				out.print(current_wishlist.getString("desc_2"));
				out.println("</td><td>");
				out.print(current_wishlist.getString("desc_3"));
				out.println("</td><td>");
				out.print(current_wishlist.getString("created_by"));
				out.println("</td><td>");
				
				out.println("<form action='removeWishlistItems.jsp' method='POST'>");
				out.println("<input type='hidden' name='user_id' value='" + user_id + "' >");
				out.println("<input type='hidden' name='category_id' value='" + cat_id + "' >");
				out.println("<input type='hidden' name='item_id' value='" + item_id + "' >");
				out.println("<input type='hidden' name='subcategory_id' value='" + subcat_id + "' >");
				out.println("<input type='submit' value='Remove From Wishlist'>");
				out.println("</form>");
				
				out.println("</td></tr>");
			}
			
			out.println("</table><br/><br/>");
		}
		
		con.close();		
	%>
	<br />
	<a href='userLogin.jsp'>Go back</a>

</body>
</html>