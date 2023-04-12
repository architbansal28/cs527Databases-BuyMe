<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Add item</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String cat_id = request.getParameter("category");
		String subcat_id = request.getParameter("subcategory");
		String name = request.getParameter("name");
		String brand = request.getParameter("brand");
		String year = request.getParameter("year");
		String desc_1 = request.getParameter("desc_1");
		String desc_2 = request.getParameter("desc_2");
		String desc_3 = request.getParameter("desc_3");
		
		String insert = "INSERT INTO item(cat_id, subcat_id, name, brand, year, desc_1, desc_2, desc_3, created_by)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, cat_id);
		ps.setString(2, subcat_id);
		ps.setString(3, name);
		ps.setString(4, brand);
		ps.setString(5, year);
		ps.setString(6, desc_1);
		ps.setString(7, desc_2);
		ps.setString(8, desc_3);
		ps.setString(9, session.getAttribute("user").toString());
		ps.executeUpdate();
		
		out.println("Item added successfully! <a href='userLogin.jsp'>Go to home page.</a>");
			
		con.close();
	%>

</body>
</html>