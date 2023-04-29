<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Similar items</title>
</head>
<body>

	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String cat_id = request.getParameter("category_id");
		String subcat_id = request.getParameter("subcategory_id");
		String item_id = request.getParameter("item_id");
		
		ResultSet result = stmt.executeQuery("SELECT * FROM auction a JOIN item i ON a.item_id=i.item_id AND a.cat_id=i.cat_id AND a.subcat_id=i.subcat_id WHERE a.closing_time<NOW() AND a.cat_id='"+ cat_id+"' AND a.subcat_id='"+ subcat_id+"' ORDER BY a.closing_time DESC");
		
		out.println("<b>Similar items on auction in the previous month:</b><br/>");
		out.println("<table class='styled-table'>");
		out.println("<tr><th>Category ID</th><th>Subcategory ID</th><th>Item ID</th><th>Name</th><th>Brand</th><th>Initial price</th><th>Selling price</th></tr>");
		while (result.next()) {
			out.println("<tr><td>");
			out.print(result.getString("cat_id"));
			out.println("</td><td>");
			out.print(result.getString("subcat_id"));
			out.println("</td><td>");
			out.print(result.getString("item_id"));
			out.println("</td><td>");
			out.print(result.getString("name"));
			out.println("</td><td>");
			out.print(result.getString("brand"));
			out.println("</td><td>");
			out.print(result.getString("initial_price"));
			out.println("</td><td>");
			if (result.getString("curr_winner")==null) {
				out.print("NOT SOLD");
			} else {
				out.print(result.getString("curr_price"));
			}
			out.println("</td></tr>");
		}
		out.println("</table><br/>");
		out.println("<br><a href='placeBid.jsp'>Place bid</a>");
		out.println("<br><a href='enrollForAutobid.jsp'>Enroll for autobid</a>");
		con.close();
	%>

</body>
</html>