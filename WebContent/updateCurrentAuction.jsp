<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Update auction</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String auction_id = request.getParameter("auction_id");
		String closing_time = request.getParameter("closing_time");
		String increment_price = request.getParameter("increment_price");
		String minimum_price = request.getParameter("minimum_price");
		
		ResultSet result = stmt.executeQuery("SELECT * FROM auction WHERE auction_id='" + auction_id + "'");
		result.next();
		
		String update = "UPDATE auction SET closing_time=?, increment_price=?, minimum_price=? WHERE auction_id=?";
		PreparedStatement ps = con.prepareStatement(update);
		if (closing_time.equals("")) {
			ps.setString(1, result.getString("closing_time"));
		} else {
			ps.setString(1, closing_time);
		}
		if (increment_price.equals("")) {
			ps.setString(2, result.getString("increment_price"));
		} else {
			ps.setString(2, increment_price);
		}
		if (minimum_price.equals("")) {
			ps.setString(3, result.getString("initial_price"));
		} else {
			ps.setString(3, minimum_price);
		}
		ps.setString(4, auction_id);
		ps.executeUpdate();
		
		out.println("Auction updated successfully! <br/><a href='auction.jsp'>Go back</a>");

		con.close();
	%>

</body>
</html>