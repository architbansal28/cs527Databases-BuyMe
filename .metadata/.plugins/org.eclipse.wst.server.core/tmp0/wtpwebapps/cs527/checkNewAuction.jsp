<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe - Start auction</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String cat_id = request.getParameter("cat_id");
		String subcat_id = request.getParameter("subcat_id");
		String item_id = request.getParameter("item_id");
		String starting_time = request.getParameter("starting_time");
		String closing_time = request.getParameter("closing_time");
		String initial_price = request.getParameter("initial_price");
		String increment_price = request.getParameter("increment_price");
		String minimum_price = request.getParameter("minimum_price");
		
		ResultSet result = stmt.executeQuery("select cat_id,subcat_id,item_id from auction where cat_id='" + cat_id+ "' and subcat_id='" + subcat_id+ "' and item_id='" + item_id+"'");
		if (result.next()) {
			out.println("Item already on auction! <a href='startAuction.jsp'>Go back.</a>");
		} else {
			String insert = "INSERT INTO auction(cat_id, subcat_id, item_id, starting_time, closing_time, initial_price, increment_price, minimum_price)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, cat_id);
			ps.setString(2, subcat_id);
			ps.setString(3, item_id);
			ps.setString(4, starting_time);
			ps.setString(5, closing_time);
			ps.setString(6, initial_price);
			ps.setString(7, increment_price);
			ps.setString(8, minimum_price);
			ps.executeUpdate();
			
			out.println("Auction added successfully! <a href='auction.jsp'>Go back.</a>");
		}
		con.close();
	%>

</body>
</html>