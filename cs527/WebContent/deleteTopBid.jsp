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


<%
String endUserId = session.getAttribute("user").toString(); // Replace with the actual end user ID
Connection con = null;
PreparedStatement st = null;
ResultSet rs = null;
String auctionID = "";
String bidCountSQL = "";
int bidCount=0;
String secondHighestBidWinnerSQL = "";
int secondHighestBid=0;
String nextWinner="";
String initialPriceSQL="";
int initialPrice = 0;
String deleteQuerySQL ="";
String updateQuerySQL="";




try {
	ApplicationDB db = new ApplicationDB();	
	con = db.getConnection();
	
	auctionID = request.getParameter("auctionID");
	
	//System.out.println("Auction ID: " + auctionID);
	
	
	bidCountSQL = "SELECT COUNT(*) as bid_count FROM bid where auction_id= '"+ auctionID + "'";
	st = con.prepareStatement(bidCountSQL);
	rs = st.executeQuery();
	
	
	
	while(rs.next())
	{
		bidCount = rs.getInt("bid_count");	
	}
	
	//System.out.println("Bid count: " + bidCount);
	
	if(bidCount > 1){
		
		//finding next highest bidder and bid amount
		
		secondHighestBidWinnerSQL = "SELECT user_id, amount FROM bid WHERE auction_id = '" + auctionID + "' ORDER BY amount DESC LIMIT 1 OFFSET 1";
		st = con.prepareStatement(secondHighestBidWinnerSQL);
		rs = st.executeQuery();
		
		while(rs.next())
		{
			nextWinner = rs.getString("user_id");
			secondHighestBid = rs.getInt("amount");
			
		}
		
		//System.out.println("Next winner: " + nextWinner);
		//System.out.println("Second highest bid: " + secondHighestBid);
		
	}
	
	
	
		//finding initial price if the row count = 1
				
		initialPriceSQL = "SELECT initial_price FROM auction WHERE auction_id = '" + auctionID +"'";
		st = con.prepareStatement(initialPriceSQL);
		rs = st.executeQuery();
		while(rs.next())
		{
			initialPrice  = rs.getInt("initial_price");
		}
		
		//System.out.println("Initial price: " + initialPrice);
		
	
	
	deleteQuerySQL= "DELETE FROM bid WHERE auction_id = '" + auctionID + "' ORDER BY timestamp DESC LIMIT 1";
	st = con.prepareStatement(deleteQuerySQL);
	int row = st.executeUpdate();
	
	if(bidCount>1)
	{
		updateQuerySQL = "UPDATE auction SET curr_winner = '"+ nextWinner + "', curr_price = '"+ secondHighestBid + "' WHERE auction_id = '"+ auctionID +"'" ;
		st = con.prepareStatement(updateQuerySQL);
		row = st.executeUpdate();
		
	}
	else
	{
		updateQuerySQL = "UPDATE auction SET curr_winner = NULL, curr_price = '"+ initialPrice + "' WHERE auction_id = '"+ auctionID +"'" ;
		st = con.prepareStatement(updateQuerySQL);
		row = st.executeUpdate();
	}
	
	
	
	
	
	
	
	

	
} catch (Exception e) {
	e.printStackTrace();
} finally {
	try { rs.close(); } catch (Exception e) {}
	try { st.close(); } catch (Exception e) {}
	try { con.close(); } catch (Exception e) {}
}


response.sendRedirect("deleteBid.jsp?auctionID="+auctionID);

%>

</body>
</html>