<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Delete item</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String cat_id = request.getParameter("cat_id");
		String subcat_id = request.getParameter("subcat_id");
		String item_id = request.getParameter("item_id");
		
		String delete = "DELETE FROM item WHERE cat_id='" + cat_id + "' and subcat_id='" + subcat_id + "' and item_id='" + item_id + "'";
		PreparedStatement ps = con.prepareStatement(delete);
		ps.executeUpdate();
		
		out.println("Item deleted successfully! <a href='userLogin.jsp'>Go to home page.</a>");
			
		con.close();
	%>

</body>
</html>