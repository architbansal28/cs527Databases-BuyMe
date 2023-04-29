<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
	<title>BuyMe - Delete bid</title>
</head>
	
<body>
	
	<!-- <form action="deleteBid.jsp" method="POST">
		<table>
			<tr>
				<td>Auction ID:</td><td><input type="text" name="auctionID" required /></td>
			</tr>
			
		</table><br/>
		<input type="submit" value="Submit"/>
		
	</form><br/> -->
	
	
	
	<a href='deleteTopBid.jsp?auctionID=<%= request.getParameter("auctionID") %>'>Delete top bid</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href='repLogin.jsp'>Go back</a><br><br>
	
	<b>Bid table:</b>
	<table class='styled-table'>
		<tr>
			<th>Bid ID</th>
			<th>User ID</th>
			<th>Auction ID</th>
			<th>Timestamp</th>
			<th>Amount</th>
		</tr>
		
		
		<%
		String endUserId = session.getAttribute("user").toString(); // Replace with the actual end user ID
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String auctionID = "";
		try {
			ApplicationDB db = new ApplicationDB();	
			con = db.getConnection();
			
			auctionID = request.getParameter("auctionID");
			
			
			String sql = "SELECT  bid_id, user_id, auction_id, timestamp, amount FROM bid WHERE auction_id = '" + auctionID + "' ORDER BY timestamp DESC";
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				String bid_id = rs.getString("bid_id");
				String user_id = rs.getString("user_id");
				String auction_id = rs.getString("auction_id");
				Timestamp timestamp = rs.getTimestamp("timestamp");
				int amount = rs.getInt("amount");
				%>
					<tr>
						<td><%=bid_id%></td>
						<td><%=user_id%></td>
						<td><%=auction_id%></td>
						<td><%=timestamp%></td>
						<td><%=amount%></td>
					</tr>
				<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { rs.close(); } catch (Exception e) {}
			try { stmt.close(); } catch (Exception e) {}
			try { con.close(); } catch (Exception e) {}
		}
		
		
		%>


</body>
</html>