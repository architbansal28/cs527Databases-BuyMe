<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Raise Query</title>
</head>
<body>
<h4>Welcome <%=session.getAttribute("name")%> (<%=session.getAttribute("user")%>) to Customer Care</h4>
	<h1>Raise Query</h1>
	<form action="submitQuery.jsp" method="POST">
		<label for="description">Description:</label>
		<input type="text" name="description" id="description" required>
		<br><br>
		<input type="submit" value="Submit">
	</form>
	Clicked by mistake? <a href='success.jsp'>Go back to menu</a>
	<br><br>
	<h2>My Queries</h2>
	<table border="1">
		<tr>
			<th>Customer Rep ID</th>
			<th>Question Text</th>
			<th>Customer Response</th>
			<th>Status</th>
			<th>Timestamp Asked</th>
			<th>Timestamp Resolved</th>
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
	</table>
</body>
</html>
