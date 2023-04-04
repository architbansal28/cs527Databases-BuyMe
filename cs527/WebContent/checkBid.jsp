<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe - Place bid</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String auction_id = request.getParameter("auction_id");
		String amount = request.getParameter("amount");
		
		ResultSet result = stmt.executeQuery("select * from auction where auction_id='" + auction_id+"'");
		int increment_price = 0;
		while (result.next()) {
			increment_price += Integer.parseInt(result.getString("curr_price")) + Integer.parseInt(result.getString("increment_price"));
		}
		
		if (Integer.parseInt(amount) < increment_price) {
			out.println("Invalid amount! <a href='placeBid.jsp'>Go back.</a>");
		} else {
			LocalDateTime now = LocalDateTime.now();
			String insert = "INSERT INTO bid(user_id, auction_id, timestamp, amount)"
					+ "VALUES (?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, session.getAttribute("user").toString());
			ps.setString(2, auction_id);
			ps.setString(3, now.toString());
			ps.setString(4, amount);
			ps.executeUpdate();
			
			String update = "UPDATE auction SET curr_winner=?, curr_price=? WHERE auction_id=?";
			ps = con.prepareStatement(update);
			ps.setString(1, session.getAttribute("user").toString());
			ps.setString(2, amount);
			ps.setString(3, auction_id);
			ps.executeUpdate();
			
			out.println("Bid added successfully! <a href='placeBid.jsp'>Go back.</a>");
		}
		con.close();
	%>

</body>
</html>