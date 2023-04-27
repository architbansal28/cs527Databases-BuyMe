<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Welcome</title>

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
			padding: 10px;
			border: 1px solid #ddd;
			border-radius: 5px;
			margin-top: 20px;
			margin-bottom: 20px;
		}
		.link {
			display: block;
			padding: 15px;
			margin: 10px;
			background-color: #fff;
			border: 1px solid #ddd;
			border-radius: 5px;
			text-decoration: none;
			color: #333;
			font-weight: bold;
			font-size: 13px;
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
	<h4>Welcome <%=session.getAttribute("name")%> (<%=session.getAttribute("user")%>)</h4>
	
	<a href='adminLogin.jsp'>Go back to menu</a>
	<!-- To include 
	SELECT item.created_by, SUM(auction.curr_price) as earnings_per_seller FROM auction INNER JOIN item ON auction.item_id = item.item_id AND auction.cat_id = item.cat_id AND auction.subcat_id = item.subcat_id WHERE closing_time < NOW() AND curr_winner IS NOT NULL GROUP BY item.created_by ORDER BY earnings_per_seller DESC
	 -->
<div class="container">
		<a class="link" href="totalEarnings.jsp">Total Earnings</a>
		<a class="link" href="earningsPerItem.jsp">Earnings per item </a>
		<a class="link" href="earningsPerItemType.jsp">Earnings per item type </a>
		<a class="link" href="earningsPerEndUser.jsp">Earnings per end-user </a>
		<a class="link" href="bestSellingItem.jsp">Best-selling items </a>
		<a class="link" href="bestSellingPerEndUser.jsp">Best-buyers</a>
	</div>
	

	


<table class='styled-table'>

<tr>
							<td>Seller</td>
							<td>Earnings Per Seller</td>
							
							
</tr>

	<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet rs = null;
  try {
    // Get a connection to the database
 
    rs = st.executeQuery("SELECT item.created_by as end_user, SUM(auction.curr_price) as earnings_per_seller FROM auction INNER JOIN item ON auction.item_id = item.item_id AND auction.cat_id = item.cat_id AND auction.subcat_id = item.subcat_id WHERE closing_time < NOW() AND curr_winner IS NOT NULL GROUP BY item.created_by ORDER BY earnings_per_seller DESC");
    // Retrieve the total earnings from the result set
    while (rs.next()) {
      //double totalEarnings = rs.getDouble("total_earnings");
      
      //add other variables
      String end_user = rs.getString("end_user");
      
      int earnings_per_seller = rs.getInt("earnings_per_seller");
      
      
      %>
      
      
<tr>
							<td><%=end_user%></td>
							<td><%=earnings_per_seller%></td>
							
							
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