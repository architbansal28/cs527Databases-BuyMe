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
		
		ResultSet result = stmt.executeQuery("select * from auto_bid where user_id='" + session.getAttribute("user").toString()+"' and auction_id='" + auction_id+"'");
		
		if (result.next()) {
			out.println("Already enrolled in autobid for this auction! <a href='enrollForAutobid.jsp'>Go back.</a>");
		} else {
			String insert = "INSERT INTO auto_bid(user_id, auction_id, upper_limit)"
					+ "VALUES (?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, session.getAttribute("user").toString());
			ps.setString(2, auction_id);
			ps.setString(3, amount);
			ps.executeUpdate();
			
			
			
			out.println("Autobid started successfully! <a href='placeBid.jsp'>Go back.</a>");
		}
		con.close();
	%>

</body>
</html>