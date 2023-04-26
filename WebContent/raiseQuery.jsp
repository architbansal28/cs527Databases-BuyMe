<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>BuyMe - Raise query</title>
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
</head>
<body>
<h4>Welcome to Customer Care</h4>
	<b>Raise Query:</b>
	<form action="submitQuery.jsp" method="POST">
		<table><tr>
		<td>Description:</td>
		<td><input type="text" name="description" id="description" required></td>
		</tr></table>
		<br/>
		<input type="submit" value="Submit">
	</form>
	<br><br>
	<b>Your queries:</b>
	<table class='styled-table'>
		<tr>
			<th>Customer Rep ID</th>
			<th>Question Text</th>
			<th>Response</th>
			<th>Status</th>
			<th>Time asked</th>
			<th>Time resolved</th>
		</tr>
		<%
			// Retrieve the list of questions asked by the user
			String endUserId = session.getAttribute("user").toString(); // Replace with the actual end user ID
			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				ApplicationDB db = new ApplicationDB();	
				con = db.getConnection();
				String sql = "SELECT customer_rep_id, ques_text, ans_text, status, timestamp_asked, timestamp_resolved FROM question WHERE end_user_id = ?";
				stmt = con.prepareStatement(sql);
				stmt.setString(1, endUserId);
				rs = stmt.executeQuery();
				while (rs.next()) {
					String customerRepId = rs.getString("customer_rep_id");
					String questionText = rs.getString("ques_text");
					String answerText = rs.getString("ans_text");
					String questionStatus = rs.getString("status");
					Timestamp timestampAsked = rs.getTimestamp("timestamp_asked");
					Timestamp timestampResolved = rs.getTimestamp("timestamp_resolved");
					%>
						<tr>
							<td><%=customerRepId%></td>
							<td><%=questionText%></td>
							<td><%=answerText%></td>
							<td><%=questionStatus%></td>
							<td><%=timestampAsked%></td>
							<td><%=timestampResolved%></td>
						</tr>
					<%
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { stmt.close(); } catch (Exception e) {}
				try { con.close(); } catch (Exception e) {}
			}
		%>
	</table><br/>
	<a href='userLogin.jsp'>Go back</a>
</body>
</html>
