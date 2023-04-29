<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Enroll for autobid</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		Statement stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("SELECT * FROM auction a JOIN item i ON a.item_id=i.item_id AND a.cat_id=i.cat_id AND a.subcat_id=i.subcat_id WHERE a.starting_time<=NOW() AND a.closing_time>=NOW() AND i.created_by!='"+ session.getAttribute("user").toString()+"'");
		
		out.println("<b>Live auctions:</b><br/>");
		out.println("<table class='styled-table'>");
		out.println("<tr><th>Auction ID</th><th>Category ID</th><th>Subcategory ID</th><th>Item ID</th><th>Name</th><th>Brand</th><th>Starting time</th><th>Closing time</th><th>Initial price</th><th>Increment price</th><th>Current price</th><th>Similar items on auction previously</th></tr>");
		while (result.next()) {
			String item_id = result.getString("item_id");
			String cat_id = result.getString("cat_id");
			String subcat_id = result.getString("subcat_id");
			
			out.println("<tr><td>");
			out.print(result.getString("auction_id"));
			out.println("</td><td>");
			out.print(cat_id);
			out.println("</td><td>");
			out.print(subcat_id);
			out.println("</td><td>");
			out.print(item_id);
			out.println("</td><td>");
			out.print(result.getString("name"));
			out.println("</td><td>");
			out.print(result.getString("brand"));
			out.println("</td><td>");
			out.print(result.getString("starting_time"));
			out.println("</td><td>");
			out.print(result.getString("closing_time"));
			out.println("</td><td>");
			out.print(result.getString("initial_price"));
			out.println("</td><td>");
			out.print(result.getString("increment_price"));
			out.println("</td><td>");
			out.print(result.getString("curr_price"));
			out.println("</td><td>");
			
			out.println("<form action='similarItems.jsp' method='POST'>");
			out.println("<input type='hidden' name='category_id' value='" + cat_id + "' >");
			out.println("<input type='hidden' name='item_id' value='" + item_id + "' >");
			out.println("<input type='hidden' name='subcategory_id' value='" + subcat_id + "' >");
			out.println("<input type='submit' value='View items'>");
			out.println("</form>");
			
			out.println("</td></tr>");
		}
		out.println("</table><br/><br/>");
		
		result = stmt.executeQuery("SELECT * FROM auto_bid WHERE user_id='" + session.getAttribute("user").toString()+"'");
		
		out.println("<b>Your autobids:</b><br/>");
		out.println("<table class='styled-table'>");
		out.println("<tr><th>Auction ID</th><th>Upper limit</th><th>Last updated</th></tr>");
		while (result.next()) {
			out.println("<tr><td>");
			out.print(result.getString("auction_id"));
			out.println("</td><td>");
			out.print(result.getString("upper_limit"));
			out.println("</td><td>");
			out.print(result.getString("timestamp"));
			out.println("</td></tr>");
		}
		out.println("</table><br/><br/>");
		
		
		out.println("<b>Start autobid:</b><br/>");
		out.println("<form action='startAutobid.jsp' method='POST'>");
		out.println("<table>");
		out.println("<tr><td>Auction ID:</td><td><input type='text' name='auction_id' required/></td></tr>");
		out.println("<tr><td>Upper limit:</td><td><input type='number' name='amount' required/></td><td><div id='amountError'></div></td></tr>");
		out.println("</table>&nbsp;<br/> <input type='submit' value='Submit'>");
		out.println("</form><br/><br/>");
		
		out.println("<b>Update autobid:</b><br/>");
		out.println("<form action='updateAutobid.jsp' method='POST'>");
		out.println("<table>");
		out.println("<tr><td>Auction ID:</td><td><input type='text' name='auction_id' required/></td></tr>");
		out.println("<tr><td>Upper limit:</td><td><input type='number' name='amount' required/></td><td><div id='amountError'></div></td></tr>");
		out.println("</table>&nbsp;<br/> <input type='submit' value='Submit'>");
		out.println("</form><br/><br/>");
		
		out.println("<b>Delete autobid:</b><br/>");
		out.println("<form action='deleteAutobid.jsp' method='POST'>");
		out.println("<table>");
		out.println("<tr><td>Auction ID:</td><td><input type='text' name='auction_id' required/></td></tr>");
		out.println("</table>&nbsp;<br/> <input type='submit' value='Submit'>");
		out.println("</form><br/><br/>");

		con.close();
	%>
	
	<a href='raiseQuery.jsp'>Raise query</a><br/>
	<a href='userLogin.jsp'>Go back</a>

</body>
</html>