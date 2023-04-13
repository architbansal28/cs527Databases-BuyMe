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
		ResultSet result = stmt.executeQuery("select * from item where created_by='" + session.getAttribute("user").toString()+ "'");
		
		out.println("<b>Your items:</b><br/>");
		out.println("<table class='styled-table'>");
		out.println("<tr><th>Category ID</th><th>Subcategory ID</th><th>Item ID</th><th>Name</th><th>Brand</th><th>Year</th><th>Description</th><th>Description</th><th>Description</th></tr>");
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
			out.print(result.getString("year"));
			out.println("</td><td>");
			out.print(result.getString("desc_1"));
			out.println("</td><td>");
			out.print(result.getString("desc_2"));
			out.println("</td><td>");
			out.print(result.getString("desc_3"));
			out.println("</td></tr>");
		}
		out.println("</table><br/><br/>");
		
		Statement stmt1 = con.createStatement();
		ResultSet result1 = stmt1.executeQuery("select * from category");
	
		out.println("<b>Add new item:</b><br/>");
		out.println("<form action='checkNewItem.jsp' method='POST'>");
		out.println("<table>");
		out.println("<tr><td>Category:</td><td><select id='category' name='category' size=1 onclick='populateSecondDropdown()' onchange='populateSecondDropdown()'>");
		
		while (result1.next()) {
			out.println("<option value=" + result1.getString("cat_id") + ">" + result1.getString("name") + "</option>");
		}

		out.println("</select></td></tr>");
		out.println("<tr><td>Subcategory:</td><td><select id='subcategory' name='subcategory' size=1></select></td></tr>");
		
		out.println("<tr><td>Name:</td><td><input type='text' name='name' required/></td></tr>");
		out.println("<tr><td>Brand:</td><td><input type='text' name='brand' required/></td></tr>");
		out.println("<tr><td>Year:</td><td><input type='number' name='year' min='1500' max='2099' step='1' required/></td></tr>");
		out.println("<tr><td>Desc <i>(e.g., color):</td><td><input type='text' name='desc_1'/></td></tr>");
		out.println("<tr><td>Desc <i>(e.g., fuel):</td><td><input type='text' name='desc_2'/></td></tr>");
		out.println("<tr><td>Desc <i>(e.g., transmission):</td><td><input type='text' name='desc_3'/></td></tr>");
		
		out.println("</table>&nbsp;<br/> <input type='submit' value='Submit'>");
		out.println("</form>");
		
		out.println("<br/><a href='userLogin.jsp'>Home page</a>");
	
		con.close();
	%>
	
	<script>
		function populateSecondDropdown() {
			const firstDropdown = document.getElementById("category");
			const secondDropdown = document.getElementById("subcategory");
			const selectedOption = firstDropdown.value;
			secondDropdown.innerHTML = "";
			//const option = document.createElement("option");
			//option.value = "";
		    //option.text = "";
		    //secondDropdown.add(option);
			
		    if (selectedOption === "VEH") {
		    	const option1 = document.createElement("option");
		    	option1.value = "BIK";
		    	option1.text = "Motorbike";
		    	secondDropdown.add(option1);
	        	const option2 = document.createElement("option");
		    	option2.value = "CAR";
		    	option2.text = "Car";
		    	secondDropdown.add(option2);
		    	const option3 = document.createElement("option");
		    	option3.value = "TRU";
		    	option3.text = "Truck";
		    	secondDropdown.add(option3);
		    } else {
		    	const option1 = document.createElement("option");
		    	option1.value = "";
		    	option1.text = "";
		    	secondDropdown.add(option1);
		    }
		}
	</script>

</body>
</html>