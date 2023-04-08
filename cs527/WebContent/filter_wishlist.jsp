<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add To Wishlist</title>
</head>
<body>

<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();

Statement stmt = con.createStatement();
ResultSet result = stmt.executeQuery("select * from category");


out.println("<b>Filter:</b><br/>");
out.println("<form action='wishlist.jsp' method='POST'>");
out.println("<table>");
out.println("<tr><td>Category:</td><td><select id='category' name='category' size=1 onchange='populateSecondDropdown()'>");

while (result.next()) {
	out.println("<option value=" + result.getString("cat_id") + ">" + result.getString("name") + "</option>");
}

out.println("</select></td></tr>");
out.println("<tr><td>Subcategory:</td><td><select id='subcategory' name='subcategory' size=1></select></td></tr>");

out.println("<tr><td>Name:</td><td><input type='text' name='name'/></td></tr>");
out.println("<tr><td>Brand:</td><td><input type='text' name='brand'/></td></tr>");
out.println("<tr><td>Years old:</td><td><input type='number' name='year_old'/></td></tr>");
out.println("<tr><td>Price Range:</td><td><input type='text' name='price_low'/></td> <td><input type='text' name='price_high'/></td></tr>");
out.println("<tr><td>Color:</td><td><input type='text' name='color'/></td></tr>");
out.println("<tr><td>Transmission:</td><td><input type='text' name='desc_3'/></td></tr>");

out.println("</table>&nbsp;<br/> <input type='submit' value='Submit'>");
out.println("</form>");

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
		    }
		}
	</script>



</body>
</html>