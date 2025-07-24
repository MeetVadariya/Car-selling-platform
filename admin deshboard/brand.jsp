<%@ page import="java.sql.*, com.admin.DbConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Car Brands</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <link rel="stylesheet" href="css/brand.css">
    <script>
        // Function to confirm deletion before proceeding
        function deleteBrand(id) {
            if (confirm("Are you sure you want to delete this brand?")) {
                window.location.href = "deleteBrand.jsp?id=" + id;
            }
        }
    </script>
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
          			<!--<li><a href="#">Payment</a></li>
          			<li><a href="#">Feedback</a></li>-->
          			<li><a href="../logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                 <button id="toggle-sidebar" class="toggle-btn">&#9776;</button>

        <h1>Welcome, Admin</h1>
        <div class="profile">
          <img src="../admin deshboard/img/profile.png" alt="Admin Profile" />
          <span>Admin</span>
                </div>
            </header>

            <!-- Car Brands Section -->
            <section class="content">
                <h1>Car Brands</h1>

                <!-- Search Bar -->
                <input type="text" id="search" placeholder="Search Brand..." />

                <!-- Brand Count -->
                <h3>Total Brands: <span id="brandCount">
                    <% 
                        int count = 0;
                        try (Connection conn = DbConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM carbrand")) {
                              if (rs.next()) {
                                  count = rs.getInt("total");
                              }
                        } catch(Exception e) {
                            e.printStackTrace();
                        }
                        out.print(count);
                    %>
                </span></h3>

                <!-- Brands Table -->
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Car Brand</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection conn = DbConnection.getConnection();
                                 Statement stmt = conn.createStatement();
                                 ResultSet rs = stmt.executeQuery("SELECT * FROM carbrand ORDER BY id ASC")) {
                                while (rs.next()) {
                                    int id = rs.getInt("id");
                                    String carBrand = rs.getString("cbrand");
                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= carBrand %></td>
                            <td>
                                <button class="delete" onclick="deleteBrand(<%= id %>)">Delete</button>
                            </td>
                        </tr>
                        <%
                                }
                            } catch(Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
                <br><br>

                <!-- Add New Car Brand Form -->
                <h2>New Car Brand</h2>
                <form action="<%= request.getContextPath() %>/AddBrandServlet" method="post">
                    <input type="text" name="carbrand" placeholder="Car Brand" required>
                    <button type="submit">Add</button>
                </form>

            </section>
        </main>
    </div>

    <script src="../admin deshboard/js/brand.js"></script>
</body>
</html>
