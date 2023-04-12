<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe - Start autobid</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String auction_id = request.getParameter("auction_id");
		String amount = request.getParameter("amount");
		
		LocalDateTime now = LocalDateTime.now();
		
		ResultSet result = stmt.executeQuery("select * from auto_bid where user_id='" + session.getAttribute("user").toString()+"' and auction_id='" + auction_id+"'");
		
		if (result.next()) {
			out.println("Already enrolled in autobid for this auction! <a href='enrollForAutobid.jsp'>Go back</a>.");
		} else {	
			Statement stmt1 = con.createStatement();
			ResultSet result1 = stmt1.executeQuery("select * from auto_bid where auction_id='" + auction_id+"' order by upper_limit desc, timestamp asc");
			Statement stmt2 = con.createStatement();
			ResultSet result2 = stmt2.executeQuery("select * from auction where auction_id='" + auction_id+"'");
			result2.next();
			
			int amount_new = Integer.parseInt(amount);
			int amount_auction = Integer.parseInt(result2.getString("curr_price"));
			int increment = Integer.parseInt(result2.getString("increment_price"));
			String curr_winner = result2.getString("curr_winner");
			
			if (amount_new<=amount_auction) {
				out.println("Upper limit should be greater than current winning amount! <a href='enrollForAutobid.jsp'>Go back</a>.");
			} else {
				if (result1.next()) {
					int amount_old = Integer.parseInt(result1.getString("upper_limit"));
					String winner_old = result1.getString("user_id");
					if (amount_new>amount_auction && amount_old>amount_new) {
						int amount_current = amount_new + increment;
						if (amount_current<=amount_old) {
							//update winner = old entry
							String update = "UPDATE auction SET curr_winner=?, curr_price=? WHERE auction_id=?";
							PreparedStatement ps = con.prepareStatement(update);
							ps.setString(1, winner_old);
							ps.setString(2, Integer.toString(amount_current));
							ps.setString(3, auction_id);
							ps.executeUpdate();
							
							String insert = "INSERT INTO bid(user_id, auction_id, timestamp, amount)"
									+ "VALUES (?, ?, ?, ?)";
							PreparedStatement ps1 = con.prepareStatement(insert);
							ps1.setString(1, winner_old);
							ps1.setString(2, auction_id);
							ps1.setString(3, now.toString());
							ps1.setString(4, Integer.toString(amount_current));
							ps1.executeUpdate();
						}
					} else if (amount_new>amount_auction && amount_auction>=amount_old && !curr_winner.equals(session.getAttribute("user").toString())) {
						int amount_current = amount_auction + increment;
						if (amount_current<=amount_new) {
							//update winner = new entry
							String update = "UPDATE auction SET curr_winner=?, curr_price=? WHERE auction_id=?";
							PreparedStatement ps = con.prepareStatement(update);
							ps.setString(1, session.getAttribute("user").toString());
							ps.setString(2, Integer.toString(amount_current));
							ps.setString(3, auction_id);
							ps.executeUpdate();
							
							String insert = "INSERT INTO bid(user_id, auction_id, timestamp, amount)"
									+ "VALUES (?, ?, ?, ?)";
							PreparedStatement ps1 = con.prepareStatement(insert);
							ps1.setString(1, session.getAttribute("user").toString());
							ps1.setString(2, auction_id);
							ps1.setString(3, now.toString());
							ps1.setString(4, Integer.toString(amount_current));
							ps1.executeUpdate();
						}
					} else if (amount_new>amount_old && amount_old>=amount_auction) {
						int amount_current = amount_old + increment;
						if (amount_current<=amount_new) {
							//update winner = new entry
							String update = "UPDATE auction SET curr_winner=?, curr_price=? WHERE auction_id=?";
							PreparedStatement ps = con.prepareStatement(update);
							ps.setString(1, session.getAttribute("user").toString());
							ps.setString(2, Integer.toString(amount_current));
							ps.setString(3, auction_id);
							ps.executeUpdate();
							
							String insert = "INSERT INTO bid(user_id, auction_id, timestamp, amount)"
									+ "VALUES (?, ?, ?, ?)";
							PreparedStatement ps1 = con.prepareStatement(insert);
							ps1.setString(1, session.getAttribute("user").toString());
							ps1.setString(2, auction_id);
							ps1.setString(3, now.toString());
							ps1.setString(4, Integer.toString(amount_current));
							ps1.executeUpdate();
						}
					}
				} else {
					//update winner = new entry
					int amount_current = amount_auction + increment;
					if (amount_current<=amount_new && !curr_winner.equals(session.getAttribute("user").toString())) {
						String update = "UPDATE auction SET curr_winner=?, curr_price=? WHERE auction_id=?";
						PreparedStatement ps = con.prepareStatement(update);
						ps.setString(1, session.getAttribute("user").toString());
						ps.setString(2, Integer.toString(amount_current));
						ps.setString(3, auction_id);
						ps.executeUpdate();
						
						String insert = "INSERT INTO bid(user_id, auction_id, timestamp, amount)"
								+ "VALUES (?, ?, ?, ?)";
						PreparedStatement ps1 = con.prepareStatement(insert);
						ps1.setString(1, session.getAttribute("user").toString());
						ps1.setString(2, auction_id);
						ps1.setString(3, now.toString());
						ps1.setString(4, Integer.toString(amount_current));
						ps1.executeUpdate();
					}
				}
				
				String insert = "INSERT INTO auto_bid(user_id, auction_id, timestamp, upper_limit)"
						+ "VALUES (?, ?, ?, ?)";
				PreparedStatement ps2 = con.prepareStatement(insert);
				ps2.setString(1, session.getAttribute("user").toString());
				ps2.setString(2, auction_id);
				ps2.setString(3, now.toString());
				ps2.setString(4, amount);
				ps2.executeUpdate();
				
				out.println("Autobid started successfully! <a href='placeBid.jsp'>Go back</a>.");
			}
			
		}
		con.close();
	%>

</body>
</html>