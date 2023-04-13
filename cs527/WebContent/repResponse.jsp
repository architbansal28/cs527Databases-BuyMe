<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BuyMe - Resolve Query</title>
</head>
<body>
    <h1>Rep Response</h1>
    <%
// Handle form submission
if (request.getMethod().equals("POST")) {
    String quesId = request.getParameter("ques_id");
    String ansText = request.getParameter("response");
    String status = request.getParameter("status");
    String customerRepId = session.getAttribute("user").toString();
    
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    PreparedStatement stmt=null;
    String sql="";
    try {
        // Update question table
        stmt = con.prepareStatement("UPDATE question SET ans_text = ?, status = ?, customer_rep_id = ?, timestamp_resolved = ? WHERE ques_id = ?");
        stmt.setString(1, ansText);
        stmt.setString(2, status);
        stmt.setString(3, customerRepId);
        stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
        stmt.setString(5, quesId);
        stmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { stmt.close(); } catch (Exception e) {}
        try { con.close(); } catch (Exception e) {}
    }
    
    // Redirect to the same page
    response.sendRedirect("repLogin.jsp");
}
%>
    
</body>
</html>