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
<a href='userLogin.jsp'>Go back</a><br/><br/>

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
	
	
	<h4>FAQs</h4>
	Search: <input type="text" id="searchInput" onkeyup="search()">
	<ul id="faqs">
		<li>
			<h4>How do I register to bid on items at BuyMe?</h4>
			<p>To register for BuyMe, you will need to create an account by providing your personal details such as your name and email address.</p>
		</li>
		<li>
			<h4>Can I view items before I bid on them?</h4>
			<p>Yes, you can view items before bidding on them. You can add items to your wishlist to get an alert whenever an item goes on auction.</p>
		</li>
		<li>
			<h4>How do I place a bid on an item?</h4>
			<p>To place a bid on an item, you will need to click the "Place bid" button. You will then need to enter the amount you wish to bid, and confirm your bid.</p>
		</li>
		<li>
			<h4>Can I set a maximum bid amount and have the system automatically bid for me?</h4>
			<p>Yes, you can set a maximum bid amount by clicking on "Enroll for autobid". The system will then automatically bid for you in increments up to that amount, and you will be notified if you are outbid by another bidder.</p>
		</li>
		<li>
			<h4>What happens if I win an auction but decide I no longer want the item?</h4>
			<p>Winning an auction is a binding agreement to purchase the item, so you should only bid on items that you are willing and able to pay for. If you decide not to proceed with the purchase, you may be in breach of the auction terms and could face penalties or legal action.</p>
		</li>
		<li>
			<h4>How long do I have to pay for items I have won in an auction?</h4>
			<p>Typically, you will be required to pay within a few days of the auction's end.</p>
		</li>
		<li>
			<h4>What forms of payment are accepted on BuyMe?</h4>
			<p>We accept credit cards, PayPal, and other online payment methods, as well as wire transfers and bank checks.</p>
		</li>
		<li>
			<h4>How will I receive the items I have won in an auction?</h4>
			<p>Some sellers may offer shipping services, while others may require you to arrange for pickup.</p>
		</li>
		<li>
			<h4>What happens if the item I won arrives damaged or is not as described?</h4>
			<p>If the item you won arrives damaged or is not as described, you should contact us immediately to report the issue.</p>
		</li>
		<li>
			<h4>Are there any fees or commissions charged for bidding on or winning items at BuyMe?</h4>
			<p>Unlike other online auction sites, we do not charge any fees or commissions for bidding on or winning items ;)</p>
		</li>
	</ul>

	<script>
		function search() {
			let input = document.getElementById("searchInput").value.toLowerCase();
			let faqs = document.getElementById("faqs");
			let li = faqs.getElementsByTagName("li");

			for (let i = 0; i < li.length; i++) {
				let h4 = li[i].getElementsByTagName("h4")[0];
				let p = li[i].getElementsByTagName("p")[0];
				let txtValue = h4.textContent.toLowerCase() + p.textContent.toLowerCase();

				if (txtValue.indexOf(input) > -1) {
					li[i].style.display = "";
				} else {
					li[i].style.display = "none";
				}
			}
		}
	</script>
	
	
</body>
</html>
