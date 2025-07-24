<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Car Categories</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <link rel="stylesheet" href="../admin deshboard/css/categories.css">
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
               <!--     <li><a href="">Payment</a></li>
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

            <!-- Car Categories Section -->
            <section class="content">
                <h1>Car Categories</h1>

                <!-- Search Bar -->
                <input type="text" id="search" placeholder="Search categories..." />

                <!-- Category Count -->
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    int categoryCount = 0;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");
                        pstmt = conn.prepareStatement("SELECT COUNT(*) FROM carcategories");
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            categoryCount = rs.getInt(1);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                %>
                <h3>Total Categories: <span id="categoryCount"><%= categoryCount %></span></h3>

                <!-- Categories Table -->
                <table>
                    <thead>
                        <tr>
                            <th>Sr. No</th> <!-- Instead of ID -->
                            <th>Car Category</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            int serialNo = 1; // Start serial numbering
                            try {
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");
                                pstmt = conn.prepareStatement("SELECT * FROM carcategories ORDER BY id ASC");
                                rs = pstmt.executeQuery();
                                while (rs.next()) { 
                        %>
                        <tr>
                            <td><%= serialNo++ %></td> <!-- Increment serial number -->
                            <td><%= rs.getString("car_category") %></td>
                            <td>
                                <button class="edit" onclick="editCategory(<%= rs.getInt("id") %>)">Edit</button>
                                <button class="delete" onclick="deleteCategory(<%= rs.getInt("id") %>)">Delete</button>
                            </td>
                        </tr>
                        <% 
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (pstmt != null) pstmt.close();
                                if (conn != null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
                <br>
                <br>

                <!-- Add New Category Form -->
                <h2>Add New Car Category</h2>
                <form action="addCategory.jsp" method="POST">
                    <input type="text" name="categoryName" placeholder="Category Name" required>
                    <button type="submit">Add</button>
                </form>

                <!-- Export & Import Buttons -->
                <button id="exportCSV">Export CSV</button>
                <input type="file" id="importCSV" />
            </section>
        </main>
    </div>

    <script src="../admin deshboard/js/categories.js"></script>
</body>
</html>
