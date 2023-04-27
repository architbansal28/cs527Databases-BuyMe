<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Delete auction</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String auction_id = request.getParameter("auction_id");
		String user_id = request.getParameter("user_id");
		
		ResultSet result = stmt.executeQuery("SELECT * FROM auction a JOIN item i ON a.item_id=i.item_id AND a.cat_id=i.cat_id AND a.subcat_id=i.subcat_id WHERE i.created_by='" + user_id + "' AND a.auction_id='" + auction_id + "' AND a.closing_time>NOW()");
		if (result.next()) {
			String delete = "DELETE FROM auction WHERE auction_id='" + auction_id + "'";
			PreparedStatement ps = con.prepareStatement(delete);
			ps.executeUpdate();
			
			out.println("Auction deleted successfully! <br/><a href='repLogin.jsp'>Go back</a>");
		} else {
			out.println("Auction cannot be deleted! <br/><a href='repLogin.jsp'>Go back</a>");
		}
			
		con.close();
	%>

</body>
</html>