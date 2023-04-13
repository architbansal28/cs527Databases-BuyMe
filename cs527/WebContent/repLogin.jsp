<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe - Welcome</title>
</head>
<body>
	<h4>Welcome <%=session.getAttribute("name")%> (<%=session.getAttribute("user")%>)</h4>
	<a href='logout.jsp'>Log out</a>
	
	
	<h2>Resolve Queries</h2>
	
	<form action="repResponse.jsp" method="POST">
		<label for="ques_id">Question ID:</label>
		<input type="text" name="ques_id" id="ques_id" required>
		
		<br><br>
		
		<label for="response">Response:</label>
		<input type="text" name="response" id="response" required>
		<br><br>
		
		<label for="status">Status:</label>
    	<select name="status" id="status">
        	<option value="declined">Declined</option>
        	<option value="resolved">Resolved</option>
    	</select>
		
		<input type="submit" value="Submit">
	</form>
	

	
	<h2>Customer Queries</h2>
	<table border="1">
		<tr>
			<th>Customer ID</th>
			<th>Question ID</th>
			<th>Question Text</th>
			<th>Answer Text</th>
			
			<th> Customer Rep ID</th>
			<th>Timestamp Asked</th>
			<th>Timestamp Resolved</th>
			
			
		</tr>
		<%
			// Retrieve the list of questions asked by the user
			String repId = session.getAttribute("user").toString(); // Replace with the actual end user ID
			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				ApplicationDB db = new ApplicationDB();	
				con = db.getConnection();
				String sql = "SELECT end_user_id, ques_id, ques_text, ans_text, customer_rep_id, timestamp_asked, timestamp_resolved FROM question where status='Pending'";
				stmt = con.prepareStatement(sql);
				//stmt.setString(1, endUserId);
				rs = stmt.executeQuery();
				while (rs.next()) {
					String end_user_id = rs.getString("end_user_id");
					int ques_id = rs.getInt("ques_id");
					String ques_text = rs.getString("ques_text");
					String ans_text = rs.getString("ans_text");
					//String status = rs.getString("status");
					String customerRepId = rs.getString("customer_rep_id");
					
					Timestamp timestampAsked = rs.getTimestamp("timestamp_asked");
					Timestamp timestampResolved = rs.getTimestamp("timestamp_resolved");
					
					%>
						<tr>
							<td><%=end_user_id%></td>
							<td><%=ques_id %></td>
							<td><%=ques_text %></td>
							<td><%=ans_text %></td>
							
							<td><%=customerRepId%></td>
							
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