<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<title>BuyMe - Sales reports</title>

	<style>
		table {
			border-collapse: collapse;
			margin-top: 20px;
			margin-bottom: 20px;
		}
		table th,
		table td {
			padding: 10px;
			border: 1px solid #ddd;
			text-align: center;
		}
		table th {
			background-color: #f2f2f2;
		}
		table tr:nth-child(even) td {
			background-color: #f2f2f2;
		}
		.container {
			display: flex;
			flex-wrap: wrap;
			justify-content: center;
			align-items: center;
			background-color: #f2f2f2;
			padding: 7px;
			border: 1px solid #ddd;
			border-radius: 5px;
			margin-top: 20px;
			margin-bottom: 20px;
		}
		.link {
			display: block;
			padding: 10px;
			margin: 10px;
			background-color: #fff;
			border: 1px solid #ddd;
			border-radius: 5px;
			text-decoration: none;
			color: #333;
			font-weight: bold;
			font-size: 15px;
			text-align: center;
			min-width: 150px;
			flex-grow: 1;
			flex-basis: 0;
			transition: all 0.3s ease;
		}
		.link:hover {
			background-color: #ddd;
		}
	</style>

</head>
<body>
	<h4>Sales Reports</h4>
	
	<a href='adminLogin.jsp'>Go back</a>
	<!-- To include 
	Total earnings, 
	Earnings per item, 
	Earnings per item type, 
	Earnings per end-user, 
	Best-selling items, 
	Best-selling end-users:
	 -->
	<div class="container">
		<a class="link" href="totalEarnings.jsp">Total earnings</a>
		<a class="link" href="earningsPerItem.jsp">Earnings per item</a>
		<a class="link" href="earningsPerItemType.jsp">Earnings per item type</a>
		<a class="link" href="earningsPerEndUser.jsp">Earnings per end-user</a>
		<a class="link" href="bestSellingItem.jsp">Best-selling items</a>
		<a class="link" href="bestSellingPerEndUser.jsp">Best buyers</a>
	</div>
	
	
	

</body>
</html>