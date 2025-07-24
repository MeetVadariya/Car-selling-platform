<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Purchase Bill</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 700px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .btn-print {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-print:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Car Purchase Bill</h2>
    <hr>

    <%
        String bookingId = request.getParameter("booking_id");
        if (bookingId == null || bookingId.isEmpty()) {
            response.sendRedirect("error.jsp"); // Redirect if booking_id is missing
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");

            String query = "SELECT * FROM  bookings WHERE booking_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(bookingId));
            rs = ps.executeQuery();

            if (rs.next()) {
    %>
                <p><strong>Bill ID:</strong> <%= rs.getInt("bill_id") %></p>
                <p><strong>Customer Name:</strong> <%= rs.getString("customer_name") %></p>
                <p><strong>Email:</strong> <%= rs.getString("customer_email") %></p>
                <p><strong>Phone:</strong> <%= rs.getString("customer_phone") %></p>
                <p><strong>Address:</strong> <%= rs.getString("customer_address") %></p>
                <p><strong>Car Name:</strong> <%= rs.getString("car_name") %></p>
                <p><strong>Brand:</strong> <%= rs.getString("car_brand") %></p>
                <p><strong>Price:</strong> ₹<%= rs.getDouble("price") %></p>
                <p><strong>Payment Method:</strong> <%= rs.getString("payment_method") %></p>
                <p><strong>Purchase Date:</strong> <%= rs.getTimestamp("purchase_date") %></p>

                <button class="btn-print" onclick="window.print()">Print Bill</button>
    <%
            } else {
                response.sendRedirect("error.jsp"); // Redirect if no bill found
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</div>

</body>
</html>
