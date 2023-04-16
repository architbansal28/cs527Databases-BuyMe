<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Delete auction</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		Statement stmt1 = con.createStatement();
		ResultSet result1 = stmt1.executeQuery("SELECT * FROM auction a JOIN item i ON a.item_id=i.item_id AND a.cat_id=i.cat_id AND a.subcat_id=i.subcat_id WHERE i.created_by='" + session.getAttribute("user").toString() + "' AND a.starting_time<=NOW() AND a.closing_time>=NOW()");
		
		out.println("<b>Current auctions:</b><br/>");
		out.println("<table class='styled-table'>");
		out.println("<tr><th>Auction ID</th><th>Category ID</th><th>Subcategory ID</th><th>Item ID</th><th>Name</th><th>Brand</th><th>Starting time</th><th>Closing time</th><th>Initial price</th><th>Increment price</th><th>Minimum price</th><th>Current winner</th><th>Current price</th></tr>");
		while (result1.next()) {
			out.println("<tr><td>");
			out.print(result1.getString("a.auction_id"));
			out.println("</td><td>");
			out.print(result1.getString("cat_id"));
			out.println("</td><td>");
			out.print(result1.getString("subcat_id"));
			out.println("</td><td>");
			out.print(result1.getString("item_id"));
			out.println("</td><td>");
			out.print(result1.getString("name"));
			out.println("</td><td>");
			out.print(result1.getString("brand"));
			out.println("</td><td>");
			out.print(result1.getString("starting_time"));
			out.println("</td><td>");
			out.print(result1.getString("closing_time"));
			out.println("</td><td>");
			out.print(result1.getString("initial_price"));
			out.println("</td><td>");
			out.print(result1.getString("increment_price"));
			out.println("</td><td>");
			out.print(result1.getString("minimum_price"));
			out.println("</td><td>");
			out.print(result1.getString("curr_winner"));
			out.println("</td><td>");
			out.print(result1.getString("curr_price"));
			out.println("</td></tr>");
		}
		out.println("</table><br/><br/>");
		
		Statement stmt2 = con.createStatement();
		ResultSet result2 = stmt2.executeQuery("SELECT * FROM auction a JOIN item i ON a.item_id=i.item_id AND a.cat_id=i.cat_id AND a.subcat_id=i.subcat_id WHERE i.created_by='" + session.getAttribute("user").toString() + "' AND a.starting_time>NOW()");
		
		out.println("<b>Future auctions:</b><br/>");
		out.println("<table class='styled-table'>");
		out.println("<tr><th>Auction ID</th><th>Category ID</th><th>Subcategory ID</th><th>Item ID</th><th>Name</th><th>Brand</th><th>Starting time</th><th>Closing time</th><th>Initial price</th><th>Increment price</th><th>Minimum price</th></tr>");
		while (result2.next()) {
			out.println("<tr><td>");
			out.print(result2.getString("auction_id"));
			out.println("</td><td>");
			out.print(result2.getString("cat_id"));
			out.println("</td><td>");
			out.print(result2.getString("subcat_id"));
			out.println("</td><td>");
			out.print(result2.getString("item_id"));
			out.println("</td><td>");
			out.print(result2.getString("name"));
			out.println("</td><td>");
			out.print(result2.getString("brand"));
			out.println("</td><td>");
			out.print(result2.getString("starting_time"));
			out.println("</td><td>");
			out.print(result2.getString("closing_time"));
			out.println("</td><td>");
			out.print(result2.getString("initial_price"));
			out.println("</td><td>");
			out.print(result2.getString("increment_price"));
			out.println("</td><td>");
			out.print(result2.getString("minimum_price"));
			out.println("</td></tr>");
		}
		out.println("</table><br/><br/>");
		
		out.println("<b>Delete auction:</b><br/>");
		out.println("<form action='checkDeleteAuction.jsp' method='POST'>");
		out.println("<table>");
		out.println("<tr><td>Auction ID:</td><td><input type='text' name='auction_id' required/></td></tr>");
		out.println("</table>&nbsp;<br/> <input type='submit' value='Submit'>");
		out.println("</form><br/>");

		con.close();
	%>
	
	<a href='raiseQuery.jsp'>Raise query</a><br/>
	<a href='auction.jsp'>Go back</a>

</body>
</html>