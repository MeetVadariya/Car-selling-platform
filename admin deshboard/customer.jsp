<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Car Buy & Sell Admin Dashboard</title>
  <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
  <link rel="stylesheet" href="../admin deshboard/css/customer.css">
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
    <!--      <li><a href="#">Payment</a></li>
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
      <!-- Customer Table -->
      <section class="customer-section">
        <h2>Customer Details</h2>
        <table border="1">
          <thead>
            <tr>
              <th>Name</th>
              <th>Email</th>
              <th>Phone No</th>
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
                  
                  // Fetch customer data from database
                  String query = "SELECT name, email, phone FROM username"; // Change 'username' to your actual table name
                  ps = con.prepareStatement(query);
                  rs = ps.executeQuery();
                  
                  while (rs.next()) {
            %>
            <tr>
              <td><%= rs.getString("name") %></td>
              <td><%= rs.getString("email") %></td>
              <td><%= rs.getString("phone") %></td>
            </tr>
            <%
                  }
              } catch (Exception e) {
                  e.printStackTrace();
                  out.println("<tr><td colspan='3'>Error fetching customers: " + e.getMessage() + "</td></tr>");
              } finally {
                  try {
                      if (rs != null) rs.close();
                      if (ps != null) ps.close();
                      if (con != null) con.close();
                  } catch (SQLException ex) {
                      ex.printStackTrace();
                  }
              }
            %>
          </tbody>
        </table>
      </section>
    </main>
  </div>
  
  <script src="../admin deshboard/js/customer.js"></script>
</body>
</html>
