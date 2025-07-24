<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Car Orders</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <link rel="stylesheet" href="../admin deshboard/css/adminOrders.css">

    <style>
        /* Style for the status dropdown and button */
    .status-form {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .status-form select {
        padding: 4px 8px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        transition: all 0.3s;
    }

    .status-form select:hover {
        border-color: #007bff;
    }

    .status-btn {
        background-color: #28a745; /* Green color */
        color: #fff;
        border: none;
        padding: 4px 12px;
        font-size: 14px;
        border-radius: 4px;
        cursor: pointer;
        transition: all 0.3s;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .status-btn:hover {
        background-color: #218838; /* Darker green */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    /* Actions buttons container */
    .actions {
        display: flex;
        align-items: center;
        gap: 10px;  /* Space between buttons */
    }

    /* Action buttons */
    .action-btn {
        display: inline-block;
        text-decoration: none;
        color: #fff;
        font-size: 14px;
        padding: 6px 14px;
        border-radius: 4px;
        transition: all 0.3s;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .btn-more {
        background-color: #007bff; /* Blue */
    }

    .btn-more:hover {
        background-color: #0056b3; /* Darker blue */
    }

    .btn-delete {
        background-color: #dc3545; /* Red */
    }

    .btn-delete:hover {
        background-color: #c82333; /* Darker red */
    }
    </style>
</head>
<body>

<div class="dashboard">

    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <h2>Admin Dashboard</h2>
        <nav>
            <ul>
                <li><a href="../admin deshboard/admin.jsp">Home</a></li>
                <li><a href="../admin deshboard/caradd.jsp">Car Add</a></li>
                <li><a href="../admin deshboard/brand.jsp">Car Brand</a></li>
                <li><a href="../admin deshboard/categories.jsp">Car Categories</a></li>
                <li><a href="../admin deshboard/listing.jsp">Car Listings</a></li>
                <li><a href="../admin deshboard/customer.jsp">Customer</a></li>
                <li><a href="../admin deshboard/adminOrders.jsp">Booking</a></li>
              <!--  <li><a href="#">Payment</a></li>
                <li><a href="#">Feedback</a></li>  -->
                <li><a href="../logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <header>
            <button id="toggle-sidebar" class="toggle-btn">☰</button>
            <h1>Welcome, Admin</h1>
            <div class="profile">
                <img src="../admin deshboard/img/profile.png" alt="Admin Profile" />
                <span>Admin</span>
            </div>
        </header>
        <br>

        <!-- Car Orders Table -->
        <div class="container mt-5">
            <h2 class="text-center mb-4">Car Orders</h2>
            <br>
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>Car Image</th>
                            <th>Customer Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Price</th>
                            <th>Payment Method</th>
                            <th>Booking Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");

                                String url = "jdbc:mysql://localhost:3306/carzone?useUnicode=true&characterEncoding=UTF-8";
                                String user = "root";
                                String pass = "Meet@9801";

                                conn = DriverManager.getConnection(url, user, pass);

                                // ✅ SQL query to fetch all necessary details
                                String sql = "SELECT b.id, b.customer_name, b.customer_email, b.customer_phone, " +
                                        "b.price, b.payment_method, b.booking_date, b.status, " +
                                        "c.name AS car_name, c.image_path " +
                                        "FROM bookings b " +
                                        "JOIN cars c ON b.car_id = c.id";

                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();

                                while (rs.next()) {
                                    int bookingId = rs.getInt("id");

                                    // ✅ Display the image with correct path
                                    String imagePath = rs.getString("image_path");
                                    if (imagePath == null || imagePath.isEmpty()) {
                                        imagePath = "admin deshboard/img/default-car.png";
                                    }

                                    String fullImagePath = request.getContextPath() + "/uploads/" + imagePath;
                        %>
                        <tr>
                            <td>
                                <img src="<%= fullImagePath %>" alt="<%= rs.getString("car_name") %>" width="100" height="70" style="border-radius: 8px;">
                            </td>

                            <td><%= rs.getString("customer_name") %></td>
                            <td><%= rs.getString("customer_email") %></td>
                            <td><%= rs.getString("customer_phone") %></td>
                            <td>&#8377;<%= rs.getDouble("price") %></td>
                            <td><%= rs.getString("payment_method") %></td>
                            <td><%= rs.getDate("booking_date") %></td>

                            <!-- Status Column with Update Button -->
						    <td>
						        <form action="updateStatus.jsp" method="POST" class="status-form">
						            <input type="hidden" name="booking_id" value="<%= bookingId %>">
						            <select name="status" class="form-control">
						                <option value="Pending" <%= "Pending".equals(rs.getString("status")) ? "selected" : "" %>>Pending</option>
						                <option value="Delivered" <%= "Delivered".equals(rs.getString("status")) ? "selected" : "" %>>Delivered</option>
						                <option value="Cancelled" <%= "Cancelled".equals(rs.getString("status")) ? "selected" : "" %>>Cancelled</option>
						            </select>
						            <button type="submit" class="status-btn">✔</button>
						        </form>
						    </td>
						
						    <td>
						    <div class="actions">
						        <a href="../bookingDetails.jsp?booking_id=<%= bookingId %>" class="action-btn btn-more">More</a>
						        <a href="../deleteBooking.jsp?booking_id=<%= bookingId %>" class="action-btn btn-delete">Delete</a>
						    </div>
						</td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                        %>
                        <tr>
                            <td colspan="9" style="color: red; text-align: center;">
                                <strong>Error:</strong> <%= e.getMessage() %>
                            </td>
                        </tr>
                        <%
                            } finally {
                                if (rs != null) rs.close();
                                if (pstmt != null) pstmt.close();
                                if (conn != null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<script>
    // Sidebar Toggle
    document.getElementById("toggle-sidebar").addEventListener("click", function () {
        let sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("hidden");
    });
</script>

</body>
</html>
