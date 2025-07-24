<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <style>
        body, html {
            height: 100%;
            margin: 0;
        }
        .full-height {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .card {
            width: 100%;
            max-width: 600px;
        }
    </style>
</head>
<body class="bg-light">

<div class="container full-height">
    <div class="card shadow-lg p-5">
        <h2 class="text-center mb-4">Booking Details</h2>
        <hr>

        <%
            String bookingId = request.getParameter("booking_id");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");

                String query = "SELECT * FROM bookings WHERE id = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(bookingId));
                rs = ps.executeQuery();

                if (rs.next()) {
        %>
                <p><strong>Booking ID:</strong> <%= rs.getInt("id") %></p>
                <p><strong>Car ID:</strong> <%= rs.getInt("car_id") %></p>
                <p><strong>Customer Name:</strong> <%= rs.getString("customer_name") %></p>
                <p><strong>Email:</strong> <%= rs.getString("customer_email") %></p>
                <p><strong>Phone:</strong> <%= rs.getString("customer_phone") %></p>
                <p><strong>Address:</strong> <%= rs.getString("customer_address") %></p>
                <p><strong>Price:</strong> ₹<%= rs.getDouble("price") %></p>
                <p><strong>Payment Method:</strong> <%= rs.getString("payment_method") %></p>

                <div class="text-center mt-4">
                    <a href="gallery.jsp" class="btn btn-primary">Back to Home</a>
                    <a href="generateBill.jsp?booking_id=<%= rs.getInt("id") %>" class="btn btn-success">Download Bill</a>
                </div>
        <%
                } else {
                    out.println("<h2 class='text-danger text-center'>No booking found</h2>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
    </div>
</div>

</body>
</html>
