<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Update item</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		Statement stmt = con.createStatement();
		String cat_id = request.getParameter("cat_id");
		String subcat_id = request.getParameter("subcat_id");
		String item_id = request.getParameter("item_id");
		String name = request.getParameter("name");
		String brand = request.getParameter("brand");
		String year = request.getParameter("year");
		String desc_1 = request.getParameter("desc_1");
		String desc_2 = request.getParameter("desc_2");
		String desc_3 = request.getParameter("desc_3");
		
		ResultSet result = stmt.executeQuery("select * from item where created_by='" + session.getAttribute("user").toString()+ "' and cat_id='" + cat_id+ "' and subcat_id='" + subcat_id+ "' and item_id='" + item_id+ "'");
		if (result.next()) {
		
			String update = "UPDATE item SET name=?, brand=?, year=?, desc_1=?, desc_2=?, desc_3=? WHERE cat_id=? AND subcat_id=? AND item_id=?";
			PreparedStatement ps = con.prepareStatement(update);
			ps.setString(1, name);
			ps.setString(2, brand);
			ps.setString(3, year);
			ps.setString(4, desc_1);
			ps.setString(5, desc_2);
			ps.setString(6, desc_3);
			ps.setString(7, cat_id);
			ps.setString(8, subcat_id);
			ps.setString(9, item_id);
			ps.executeUpdate();
			
			out.println("Item updated successfully! <a href='userLogin.jsp'>Go to home page.</a>");
		} else {
			out.println("Item not found! <a href='updateExistingItem.jsp'>Go back.</a>");
		}
			
		con.close();
	%>

</body>
</html>