<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BuyMe - Submit Query</title>
</head>
<body>
    <h1>Submit Query</h1>

<%
	// Retrieve the form data
	String endUserId = session.getAttribute("user").toString(); // Replace with the actual end user ID
	String questionText = request.getParameter("description");
	Timestamp timestampAsked = new Timestamp(System.currentTimeMillis());

	// Add the question to the database
	
	
	int maxQuesId = 0;

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	PreparedStatement stmt=null;
	String sql="";
	try {
		   sql = "INSERT INTO question (ques_text, status, timestamp_asked, end_user_id) VALUES (?,'pending',?,?)";
		    
			stmt = con.prepareStatement(sql);

			stmt.setString(1, questionText);
			stmt.setTimestamp(2, timestampAsked);
			stmt.setString(3, endUserId);
			stmt.executeUpdate();
	} catch (SQLException e) {
	    e.printStackTrace();
	} finally {
	    try { con.close(); } catch (Exception e) {}
	}
	 

		


	// Redirect back to the raiseQuery.jsp page
	response.sendRedirect("raiseQuery.jsp");
	%>
	

</body>
</html>


    