<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Car Listings - Admin Dashboard</title>
  <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
  <link rel="stylesheet" href="../admin deshboard/css/listing.css">
</head>
<body>
  <div class="dashboard">
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
       <!--   <li><a href="#">Payment</a></li>
          <li><a href="#">Feedback</a></li>-->
          <li><a href="../logout.jsp">Logout</a></li>
        </ul>
      </nav>
    </aside>

    <main class="main-content">
      <header>
        <button id="toggle-sidebar" class="toggle-btn">☰</button>
        <h1>Welcome, Admin</h1>
        <div class="profile">
          <img src="../admin deshboard/img/profile.png" alt="Admin Profile" />
          <span>Admin</span>
        </div>
      </header>

      <!-- Car Listings Section -->
      <br>
      <section class="car-table">
        <h2>Car Listings</h2>
        <br>
        <br>
        <!-- Add New Car Button -->
        <div class="add-btn-container">
          <a href="../admin deshboard/caradd.jsp" class="add-btn">+ Add New Car</a>
        </div>

        <table border="1">
          <thead>
            <tr>
            <!-- <th>ID</th>  -->
           
              <th>Car Image</th>
              <th>Car Brand</th>
              <th>Car Name</th>
              <th>Category</th>
              <th>Year</th>
              <th>Price</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
          <% 
          // Database connection details
          String url = "jdbc:mysql://localhost:3306/carzone";
          String user = "root";
          String password = "Meet@9801";
          Connection con = null;
          PreparedStatement ps = null;
          ResultSet rs = null;

          try {
              Class.forName("com.mysql.cj.jdbc.Driver");
              con = DriverManager.getConnection(url, user, password);

              // Fetch all cars from the database
              String query = "SELECT * FROM cars";
              ps = con.prepareStatement(query);
              rs = ps.executeQuery();

              while (rs.next()) {
          %>
          
          <tr>
           <!--  <td><%= rs.getInt("id") %></td>  --> 
            <td>
              <img src="<%= request.getContextPath() %>/uploads/<%= rs.getString("image_path") %>" alt="<%= rs.getString("name") %>" width="100">
            </td>
            <td><%= rs.getString("brand") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getInt("year") %></td>
            <td>₹<%= rs.getDouble("price") %></td>
            <td>
              <a href="editCar.jsp?id=<%= rs.getInt("id") %>" class="edit-btn"> Edit</a>
              <a href="deleteCar.jsp?id=<%= rs.getInt("id") %>" class="delete-btn" onclick="return confirm('Are you sure you want to delete this car?')"> Delete</a>
            </td>
          </tr>

          <%
              }
          } catch (Exception e) {
              e.printStackTrace();
          } finally {
              if (rs != null) rs.close();
              if (ps != null) ps.close();
              if (con != null) con.close();
          }
          %>

          </tbody>
        </table>
      </section>
    </main>
  </div>

  <script src="../admin deshboard/js/listing.js"></script>
</body>
</html>
