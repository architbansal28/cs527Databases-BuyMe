<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Delete autobid</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String auction_id = request.getParameter("auction_id");
				
		ResultSet result = stmt.executeQuery("select * from auto_bid where user_id='" + session.getAttribute("user").toString()+"' and auction_id='" + auction_id+"'");
		
		if (result.next()) {
			String delete = "DELETE FROM auto_bid WHERE user_id='" + session.getAttribute("user").toString()+ "' and auction_id='" + auction_id+ "'";
			PreparedStatement ps = con.prepareStatement(delete);
			ps.executeUpdate();
			out.println("Autobid deleted successfully! <a href='enrollForAutobid.jsp'>Go back</a>.");
		} else {	
			out.println("Autobid does not exist! <a href='enrollForAutobid.jsp'>Go back</a>.");
		}
		
		con.close();
	%>

</body>
</html>