<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Your auctions</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//check auction winners
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * FROM auction WHERE closing_time<NOW() AND curr_winner IS NOT NULL");
		while (rs.next()) {
			int minimum_price = Integer.parseInt(rs.getString("minimum_price"));
			int curr_price = Integer.parseInt(rs.getString("curr_price"));
			if (curr_price<minimum_price) {
				//update => no winner
				String update = "UPDATE auction SET curr_winner=NULL WHERE auction_id=?";
				PreparedStatement ps = con.prepareStatement(update);
				ps.setString(1, rs.getString("auction_id"));
				ps.executeUpdate();
			} else {
				//send alert to winner
				String insert = "INSERT IGNORE INTO alert(end_user_id, timestamp, message)"
						+ "VALUES (?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, rs.getString("curr_winner"));
				ps.setString(2, rs.getString("closing_time"));
				ps.setString(3, "Congrats! You won Auction "+rs.getString("auction_id")+" for $"+rs.getString("curr_price")+".");
				ps.executeUpdate();
			}
		}
		
		Statement stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("SELECT * FROM auction a JOIN item i ON a.item_id=i.item_id AND a.cat_id=i.cat_id AND a.subcat_id=i.subcat_id WHERE i.created_by='" + session.getAttribute("user").toString() + "' AND a.closing_time<NOW()");
		
		out.println("<b>Past auctions:</b><br/>");
		out.println("<table class='styled-table'>");
		out.println("<tr><th>Auction ID</th><th>Category ID</th><th>Subcategory ID</th><th>Item ID</th><th>Name</th><th>Brand</th><th>Starting time</th><th>Closing time</th><th>Initial price</th><th>Increment price</th><th>Minimum price</th><th>Winner</th><th>Price sold</th></tr>");
		while (result.next()) {
			out.println("<tr><td>");
			out.print(result.getString("auction_id"));
			out.println("</td><td>");
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
			out.print(result.getString("starting_time"));
			out.println("</td><td>");
			out.print(result.getString("closing_time"));
			out.println("</td><td>");
			out.print(result.getString("initial_price"));
			out.println("</td><td>");
			out.print(result.getString("increment_price"));
			out.println("</td><td>");
			out.print(result.getString("minimum_price"));
			out.println("</td><td>");
			out.print(result.getString("curr_winner"));
			out.println("</td><td>");
			out.print(result.getString("curr_price"));
			out.println("</td></tr>");
		}
		out.println("</table><br/><br/>");
		
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
		con.close();
	%>
	
	<a href='startAuction.jsp'>Start auction</a><br/>
	<!-- <a href='deleteAuction.jsp'>Delete auction</a><br/> -->
	<a href='updateAuction.jsp'>Update auction</a><br/><br/>
	
	<a href='raiseQuery.jsp'>Raise query</a><br/>
	<a href='userLogin.jsp'>Go back</a>

</body>
</html>