<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
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
		result.next();
		int increment_price = Integer.parseInt(result.getString("curr_price")) + Integer.parseInt(result.getString("increment_price"));
		
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
			
			//check for autobid
			Statement stmt1 = con.createStatement();
			ResultSet result1 = stmt1.executeQuery("select * from auto_bid where auction_id='" + auction_id+"'order by upper_limit desc, timestamp asc");
			if (result1.next()) {
				int amount_autobid = Integer.parseInt(result1.getString("upper_limit"));
				String winner_autobid = result1.getString("user_id");
				//autobid should not override bid by same user
				if (!winner_autobid.equals(session.getAttribute("user").toString())) {
					increment_price = Integer.parseInt(amount) + Integer.parseInt(result.getString("increment_price"));
					if (increment_price<=amount_autobid) {
						//update winner
						String update1 = "UPDATE auction SET curr_winner=?, curr_price=? WHERE auction_id=?";
						PreparedStatement ps1 = con.prepareStatement(update1);
						ps1.setString(1, winner_autobid);
						ps1.setString(2, Integer.toString(increment_price));
						ps1.setString(3, auction_id);
						ps1.executeUpdate();
						
						String insert1 = "INSERT INTO bid(user_id, auction_id, timestamp, amount)"
								+ "VALUES (?, ?, ?, ?)";
						ps1 = con.prepareStatement(insert1);
						ps1.setString(1, winner_autobid);
						ps1.setString(2, auction_id);
						ps1.setString(3, now.toString());
						ps1.setString(4, Integer.toString(increment_price));
						ps1.executeUpdate();
					}
				}
			}
			
			out.println("Bid added successfully! <a href='placeBid.jsp'>Go back.</a>");
		}
		con.close();
	%>

</body>
</html>