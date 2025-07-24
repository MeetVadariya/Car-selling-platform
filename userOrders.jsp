<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Orders - Car Zone</title>
<link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/orders.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
</head>
<body>

    <!-- Header -->
    <div class="header_section">
        <div class="container">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="navbar-brand" href="index.html"><img src="images/logo3.png"></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                        <li class="nav-item"><a class="nav-link" href="gallery.jsp">Cars</a></li>
                        <li class="nav-item"><a class="nav-link" href="client.jsp">Client</a></li>
                        <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                         <li class="nav-item">
    <a class="nav-link" href="user.jsp">
        <i class="fa fa-user"></i> 
        <%= (session.getAttribute("username") != null) ? session.getAttribute("username") : "Login" %>
    </a>
</li>

                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container mt-5">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
            <div class="sidebar p-3 bg-light">
                <h4>Dashboard</h4>
                <ul class="list-unstyled">
                    <li><a href="user.jsp">Profile</a></li>
                    <li><a href="userOrders.jsp">View Orders</a></li>

                   
                 <!--    <li><a href="#">Settings</a></li>
                    <li><a href="#">Change Password</a></li>  --> 
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
            <!-- Orders Table -->
            <div class="col-md-9">
                <h2 class="text-center">My Orders</h2>
                <table class="table table-bordered mt-4">
                    <thead>
                        <tr>
                            <th>Car Name</th>
                            <th>Price</th>
                            <th>Payment Method</th>
                            <th>Booking Date</th>
                        <!--     <th>Status</th>   -->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;

                            // ✅ Retrieve user email from session
                            String userEmail = (String) session.getAttribute("userEmail");

                            if (userEmail != null) {
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");

                                    String url = "jdbc:mysql://localhost:3306/carzone?useUnicode=true&characterEncoding=UTF-8";
                                    String user = "root";
                                    String pass = "Meet@9801";

                                    conn = DriverManager.getConnection(url, user, pass);

                                    // ✅ Fetch user orders
                                    String sql = "SELECT b.*, c.name AS car_name " +
                                                 "FROM bookings b " +
                                                 "JOIN cars c ON b.car_id = c.id " +
                                                 "WHERE b.customer_email = ?";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, userEmail);
                                    rs = pstmt.executeQuery();

                                    boolean hasOrders = false;

                                    while (rs.next()) {
                                        hasOrders = true;
                        %>
                        <tr>
                            <td><%= rs.getString("car_name") %></td>
                            <td>&#8377;<%= rs.getDouble("price") %></td> <!-- ₹ -->
                            <td><%= rs.getString("payment_method") %></td>
                            <td><%= rs.getDate("booking_date") %></td>
                          <!--  <td>
                               <span style="color: <%= "Delivered".equals(rs.getString("status")) ? "green" :
                                                    "Pending".equals(rs.getString("status")) ? "orange" : "red" %>;">
                                    <%= rs.getString("status") %>
                                </span>   
                            </td>   --> 
                        </tr>
                        <%
                                    }
                                    if (!hasOrders) {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center; color: gray;">No orders found.</td>
                        </tr>
                        <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                        %>
                        <tr>
                            <td colspan="5" style="color: red; text-align: center;">
                                <strong>Error:</strong> <%= e.getMessage() %>
                            </td>
                        </tr>
                        <%
                                } finally {
                                    if (rs != null) rs.close();
                                    if (pstmt != null) pstmt.close();
                                    if (conn != null) conn.close();
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center; color: red;">Please log in to view your orders.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/jquery-3.0.0.min.js"></script>
    <script src="js/plugin.js"></script>
    <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="js/custom.js"></script>

</body>
</html>
