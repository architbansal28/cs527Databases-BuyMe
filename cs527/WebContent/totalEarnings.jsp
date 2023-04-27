<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Sales reports</title>

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
	<!-- SQL
	
	SELECT SUM(max_bid) as total_earnings
FROM (
    SELECT MAX(b.amount) AS max_bid
    FROM bid b
    JOIN auction a ON b.auction_id = a.auction_id
    WHERE a.minimum_price IS NOT NULL AND a.minimum_price < b.amount
    GROUP BY b.auction_id
) 
	
	Archit:
	
	select * from auction where closing time is less than now and winner not null
	
	
	SELECT SUM(curr_price) 
	FROM auction
	WHERE closing_time < NOW()
	AND curr_winner IS NOT NULL;
	
	
	
	 -->
	<div class="container">
		<a class="link" href="totalEarnings.jsp">Total earnings</a>
		<a class="link" href="earningsPerItem.jsp">Earnings per item</a>
		<a class="link" href="earningsPerItemType.jsp">Earnings per item type</a>
		<a class="link" href="earningsPerEndUser.jsp">Earnings per end-user</a>
		<a class="link" href="bestSellingItem.jsp">Best-selling items</a>
		<a class="link" href="bestSellingPerEndUser.jsp">Best buyers</a>
	</div>
	

	
	<!-- Get the total earnings and display here-->
<!-- 
	
--totalearnings[total_earnings]
SELECT SUM(curr_price) as total_earnings 
FROM auction 
WHERE closing_time < NOW() 
AND curr_winner IS NOT NULL
--earnings per item (Total earnings wala use karna h - group by item, subcat, cat) [item_id, item_name?, earnings] **
SELECT *
FROM auction 
WHERE closing_time < NOW() 
AND curr_winner IS NOT NULL
ORDER BY curr_price DESC
--earnings per item type (Group by cat & subcat) [cat_id, subcat_id, total_earnings_per_item] name required?
SELECT cat_id, subcat_id, SUM(curr_price) as total_earnings_per_item
FROM auction 
WHERE closing_time < NOW() 
AND curr_winner IS NOT NULL
GROUP BY cat_id, subcat_id
ORDER BY total_earnings_per_item DESC
--earnings per end user / seller (join auction with item and group by based on seller)
SELECT item.created_by, SUM(auction.curr_price) as earnings_per_seller
FROM auction
INNER JOIN item
ON auction.item_id = item.item_id AND auction.cat_id = item.cat_id AND auction.subcat_id = item.subcat_id
WHERE closing_time < NOW()
GROUP BY item.created_by
ORDER BY earnings_per_seller DESC
--best selling items (Limit earnings per item to top 10 sort by earnings) -auction table poora print karna hai top 10
SELECT *, curr_price as earnings_best_selling_items
FROM auction 
WHERE closing_time < NOW() 
AND curr_winner IS NOT NULL
ORDER BY earnings_best_selling_items DESC
LIMIT 10;
--best buyers
SELECT auction.curr_winner, SUM(auction.curr_price) as earnings_per_buyer
FROM auction
INNER JOIN item
ON auction.item_id = item.item_id AND auction.cat_id = item.cat_id AND auction.subcat_id = item.subcat_id
WHERE closing_time < NOW() and auction.curr_winner IS NOT NULL
GROUP BY auction.curr_winner 
ORDER BY earnings_per_buyer DESC
LIMIT 10;	
	
	-->
	
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet rs = null;
  try {
    // Get a connection to the database
 
    rs = st.executeQuery("SELECT SUM(curr_price) as total_earnings FROM auction WHERE closing_time < NOW() AND curr_winner IS NOT NULL");
    // Retrieve the total earnings from the result set
    if (rs.next()) {
      double totalEarnings = rs.getDouble("total_earnings");
      
      
%>
      <font size="5">Total earnings = $<%=totalEarnings%></font>
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
	
	

</body>
</html>