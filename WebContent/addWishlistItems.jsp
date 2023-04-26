<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Add to wishlist</title>
</head>
<body>

	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String user_id = request.getParameter("user_id");
		String cat_id = request.getParameter("category_id");
		String subcat_id = request.getParameter("subcategory_id");
		String item_id = request.getParameter("item_id");
		
		ResultSet current_wishlist = stmt.executeQuery("select * from wishlist where user_id ='" + user_id + "' and cat_id ='" + cat_id + "' and subcat_id ='" + subcat_id + "' and item_id ='" + item_id + "'");
		if (current_wishlist.next()) {
			out.println("Item already in wishlist! <a href='wishlist.jsp'>Go back</a>.");
		} else {
		
			String insert = "INSERT INTO wishlist(user_id, cat_id, subcat_id, item_id)"
					+ "VALUES (?, ?, ?, ?)";
			
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, user_id);
			ps.setString(2, cat_id);
			ps.setString(3, subcat_id);
			ps.setString(4, item_id);
			ps.executeUpdate();
			
			//check for alerts
			LocalDateTime now = LocalDateTime.now();
			Statement stmt1 = con.createStatement();
			ResultSet result = stmt1.executeQuery("select * from auction where cat_id='" + cat_id+ "' and subcat_id='" + subcat_id+ "' and item_id='" + item_id+"' and closing_time>NOW()");
			while (result.next()) {
				String insert1 = "INSERT IGNORE INTO alert(end_user_id, timestamp, message)"
						+ "VALUES (?, ?, ?)";
				PreparedStatement ps1 = con.prepareStatement(insert1);
				ps1.setString(1, user_id);
				ps1.setString(2, now.toString());
				ps1.setString(3, "Your wishlist item " + cat_id+ "-" + subcat_id+ "-" + item_id+ " is up on auction from " + result.getString("starting_time")+ " to " + result.getString("closing_time")+ ".");
				ps1.executeUpdate();
			}
			
			out.println("Item added successfully!");
			
			//out.println("<form action='wishlist.jsp' method='POST'>");
			//out.println("<input type='hidden' name='going_back' value='true'>");
			//out.println("<input type='submit' value='Go Back'>");
			//out.println("</form>");
			
			out.println("<br><a href='wishlist.jsp'>Go back</a>");
			out.println("<br><a href='userLogin.jsp'>Home page</a>");
		}
			
		con.close();
	%>

</body>
</html>