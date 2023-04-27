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
</head>
<body>
	<h4>Welcome <%=session.getAttribute("name")%> (<%=session.getAttribute("user")%>)</h4>
	
	<b>As a seller, you can:</b><br/>
	<a href='items.jsp'>View your items</a><br/>
	<a href='auction.jsp'>View your auctions</a><br/><br/>
	
	<b>As a buyer, you can:</b><br/>
	<!-- <a href='filter_wishlist.jsp'>Add to Wishlist</a><br/> -->
	<a href='wishlist.jsp'>Add to wishlist</a><br/>
	<a href='placeBid.jsp'>Place bid</a><br/>
	<a href='enrollForAutobid.jsp'>Enroll for autobid</a><br/><br/>
	
	<a href='deleteIntermediateAccount.jsp'>Delete account</a><br/>
	<a href='changePassword.jsp'>Change password</a><br/>
	<a href='raiseQuery.jsp'>Raise query</a><br/>
	<a href='logout.jsp'>Log out</a><br/><br/>
	
	<u>Notifications</u>:<br/>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM alert WHERE end_user_id='" + session.getAttribute("user").toString()+ "' ORDER BY timestamp DESC");
		while (rs.next()) {
			out.println("[" + rs.getString("timestamp") + "] " + rs.getString("message") + "<br/>");
		}
	%>

</body>
</html>