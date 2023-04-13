<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="css/stylesheet.css">
    <title>BuyMe - Raise query</title>
</head>
<body>
    <b>Submit Query</b>

<%
	// Retrieve the form data
	String endUserId = session.getAttribute("user").toString(); // Replace with the actual end user ID
	String questionText = request.getParameter("description");
	//Timestamp timestampAsked = new Timestamp(System.currentTimeMillis());
	LocalDateTime now = LocalDateTime.now();

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
			stmt.setString(2, now.toString());
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


    