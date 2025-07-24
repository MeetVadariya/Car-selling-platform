<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta charset="UTF-8">
    <title>Admin Payment Page</title>
    <link rel="stylesheet" href="../admin deshboard/css/payment.css"> <!-- Add your CSS file -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
</head>
   
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
                    <li><a href="">Payment</a></li>
                    <li><a href="#">Feedback</a></li>
                    <li><a href="#">Logout</a></li>
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
    <h2>Admin Payment Page</h2>
    
    <br>

    <!-- Filter Form -->
    <form method="GET" action="AdminPayment.jsp">
        <label>From Date: </label>
        <input type="date" name="fromDate">
        <label>To Date: </label>
        <input type="date" name="toDate">

        <label>Payment Method: </label>
        <select name="paymentMethod">
            <option value="">All</option>
            <option value="Card">Card</option>
            <option value="UPI">UPI</option>
            <option value="Bank Transfer">Bank Transfer</option>
        </select>

        <label>Status: </label>
        <select name="status">
            <option value="">All</option>
            <option value="Pending">Pending</option>
            <option value="Completed">Completed</option>
            <option value="Failed">Failed</option>
        </select>

        <input type="submit" value="Filter">
    </form>

    <table>
        <tr>
            <th>Booking ID</th>
            <th>Customer Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Car ID</th>
            <th>Price</th>
            <th>Payment Method</th>
            <th>Card/UPI/Bank</th>
            <th>Down Payment</th>
            <th>EMI Plan</th>
            <th>Booking Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <%
            // Database Connection
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            String url = "jdbc:mysql://localhost:3306/carzone";
            String user = "root";
            String password = "Meet@9801";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                // Get filters
                String fromDate = request.getParameter("fromDate");
                String toDate = request.getParameter("toDate");
                String paymentMethod = request.getParameter("paymentMethod");
                String status = request.getParameter("status");

                StringBuilder query = new StringBuilder("SELECT * FROM bookings WHERE 1=1");

                if (fromDate != null && !fromDate.isEmpty()) {
                    query.append(" AND booking_date >= '").append(fromDate).append("'");
                }
                if (toDate != null && !toDate.isEmpty()) {
                    query.append(" AND booking_date <= '").append(toDate).append("'");
                }
                if (paymentMethod != null && !paymentMethod.isEmpty()) {
                    query.append(" AND payment_method = '").append(paymentMethod).append("'");
                }
                if (status != null && !status.isEmpty()) {
                    query.append(" AND status = '").append(status).append("'");
                }

                stmt = conn.prepareStatement(query.toString());
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("customer_name") %></td>
                    <td><%= rs.getString("customer_email") %></td>
                    <td><%= rs.getString("customer_phone") %></td>
                    <td><%= rs.getInt("car_id") %></td>
                    <td>₹<%= rs.getDouble("price") %></td>
                    <td><%= rs.getString("payment_method") %></td>
                    <td>
                        <%= rs.getString("card_number") != null ? rs.getString("card_number") : "" %>
                        <%= rs.getString("upi_id") != null ? rs.getString("upi_id") : "" %>
                        <%= rs.getString("bank") != null ? rs.getString("bank") : "" %>
                    </td>
                    <td>₹<%= rs.getDouble("down_payment") %></td>
                    <td><%= rs.getString("emi_plan") %></td>
                    <td><%= rs.getString("booking_date") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td>
    <a href="UpdatePaymentStatus.jsp?id=<%= rs.getInt("id") %>&status=Completed" 
       class="action-btn complete-btn">Complete</a>
    <a href="UpdatePaymentStatus.jsp?id=<%= rs.getInt("id") %>&status=Failed" 
       class="action-btn fail-btn">Fail</a>
</td>

                </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
</body>
</html>
