<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Sales Reports</title>

	<style>
		table {
			border-collapse: collapse;
			margin-top: 20px;
			margin-bottom: 20px;
		}
		table th,
		table td {
			padding: 10px;
			border: 1px solid #ddd;
			text-align: center;
		}
		table th {
			background-color: #f2f2f2;
		}
		table tr:nth-child(even) td {
			background-color: #f2f2f2;
		}
		.container {
			display: flex;
			flex-wrap: wrap;
			justify-content: center;
			align-items: center;
			background-color: #f2f2f2;
			padding: 7px;
			border: 1px solid #ddd;
			border-radius: 5px;
			margin-top: 20px;
			margin-bottom: 20px;
		}
		.link {
			display: block;
			padding: 10px;
			margin: 10px;
			background-color: #fff;
			border: 1px solid #ddd;
			border-radius: 5px;
			text-decoration: none;
			color: #333;
			font-weight: bold;
			font-size: 15px;
			text-align: center;
			min-width: 150px;
			flex-grow: 1;
			flex-basis: 0;
			transition: all 0.3s ease;
		}
		.link:hover {
			background-color: #ddd;
		}
	</style>

</head>
<body>
	<h4>Sales Reports</h4>
	
	<a href='adminLogin.jsp'>Go back</a>
	<!-- To include 
	SELECT auction_id, cat_id, subcat_id, item_id, starting_time, closing_time, initial_price, increment_price, minimum_price, curr_winner, curr_price as earnings_best_selling_items FROM auction WHERE closing_time < NOW() AND curr_winner IS NOT NULL ORDER BY earnings_best_selling_items DESC LIMIT 10 -->
	<div class="container">
		<a class="link" href="totalEarnings.jsp">Total earnings</a>
		<a class="link" href="earningsPerItem.jsp">Earnings per item</a>
		<a class="link" href="earningsPerItemType.jsp">Earnings per item type</a>
		<a class="link" href="earningsPerEndUser.jsp">Earnings per end-user</a>
		<a class="link" href="bestSellingItem.jsp">Best-selling items</a>
		<a class="link" href="bestSellingPerEndUser.jsp">Best buyers</a>
	</div>
	

	
	
	<table class='styled-table'>
	
	
	<tr>
							<th>Auction ID</th>
							<th>Category ID</th>
							<th>SubCategory ID</th>
							<th>Item ID</th>
							<th>Starting Time</th>
							<th>Closing Time</th>
							<th>Initial Price</th>
							<th>Increment Price</th>
							<th>Minimum Price</th>
							<th>Winner</th>
							<th>Selling Price</th>
							
</tr>

	<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet rs = null;
  try {
    // Get a connection to the database
 
    rs = st.executeQuery("SELECT auction_id, cat_id, subcat_id, item_id, starting_time, closing_time, initial_price, increment_price, minimum_price, curr_winner, curr_price as earnings_best_selling_items FROM auction WHERE closing_time < NOW() AND curr_winner IS NOT NULL ORDER BY earnings_best_selling_items DESC LIMIT 10");
    // Retrieve the total earnings from the result set
    while (rs.next()) {
      //double totalEarnings = rs.getDouble("total_earnings");
      
      //add other variables
      int auction_id = rs.getInt("auction_id");
      String cat_id = rs.getString("cat_id");
      String subcat_id = rs.getString("subcat_id");
      int item_id = rs.getInt("item_id");
      Timestamp starting_time = rs.getTimestamp("starting_time");
      Timestamp closing_time = rs.getTimestamp("closing_time");
      int initial_price = rs.getInt("initial_price");
      int increment_price = rs.getInt("increment_price");
      int  minimum_price = rs.getInt("minimum_price");
      String curr_winner = rs.getString("curr_winner");
      int  earnings_best_selling_items = rs.getInt("earnings_best_selling_items");
      
      %>
      
      
<tr>
							<td><%=auction_id%></td>
							<td><%=cat_id%></td>
							<td><%=subcat_id%></td>
							<td><%=item_id%></td>
							<td><%=starting_time%></td>
							<td><%=closing_time%></td>
							<td><%=initial_price%></td>
							<td><%=increment_price%></td>
							<td><%=minimum_price%></td>
							<td><%=curr_winner%></td>
							<td><%=earnings_best_selling_items%></td>
							
</tr>



<% 
      
      
    }
  } catch (SQLException e) {
    e.printStackTrace();
  } finally {
    // Close the result set, statement, and connection
    try {
      if (rs != null) rs.close();
      if (st != null) st.close();
      if (con != null) con.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
%>

</table><br/>
	

</body>
</html>