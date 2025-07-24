<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Car Buy & Sell Admin Dashboard</title>
  <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">

  <!-- Corrected CSS Path -->
  <link rel="stylesheet" href="../admin deshboard/css/caradd.css">
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
          <li><a href="#">Feedback</a></li> -->
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
<br>
      <!-- Add Car Form -->
      <section class="add-car-section" id="addcar">
        <h2>Add New Car</h2>

        <form action="../AddCarServlet" method="post" enctype="multipart/form-data">
          <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/carzone";
            String user = "root";
            String password = "Meet@9801";
            
            Connection con = null;
            PreparedStatement psBrand = null;
            PreparedStatement psCategory = null;
            ResultSet rsBrand = null;
            ResultSet rsCategory = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, user, password);

                // Fetch car brands
                String queryBrand = "SELECT * FROM carbrand";
                psBrand = con.prepareStatement(queryBrand);
                rsBrand = psBrand.executeQuery();
          %>

          <!-- Car Brand Dropdown -->
          <label for="carbrand">Car Brand:</label>
          <select id="carbrand" name="carbrand" required>
            <option value="">--Select--</option>
            <% while (rsBrand.next()) { %>
                <option value="<%= rsBrand.getString("cbrand") %>">
                    <%= rsBrand.getString("cbrand") %>
                </option>
            <% } %>
          </select>

          <%
                // Fetch car categories
                String queryCategory = "SELECT id, car_category FROM carcategories";
                psCategory = con.prepareStatement(queryCategory);
                rsCategory = psCategory.executeQuery();
          %>

          <!-- Car Category Dropdown -->
          <label for="carCategory">Car Category:</label>
          <select id="carCategory" name="carCategory" required>
              <option value="">--Select--</option>
              <% while (rsCategory.next()) { %>
                  <option value="<%= rsCategory.getString("car_category") %>">
                      <%= rsCategory.getString("car_category") %>
                  </option>
              <% } %>
          </select>

          <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rsBrand != null) rsBrand.close();
                if (psBrand != null) psBrand.close();
                if (rsCategory != null) rsCategory.close();
                if (psCategory != null) psCategory.close();
                if (con != null) con.close();
            }
          %>

          <label for="carName">Car Name:</label>
          <input type="text" id="carName" name="carName" required>

          <label for="carPrice">Car Price:</label>
          <input type="number" id="carPrice" name="carPrice" required>

          <label for="carYear">Manufacturing Year:</label>
          <input type="number" id="carYear" name="carYear" required>

          <label for="carImage">Car Image:</label>
          <input type="file" id="carImage" name="carImage" accept="image/*" required>

          <label for="carDescription">Car Description:</label>
          <textarea id="carDescription" name="carDescription" rows="4" required></textarea>

          <label for="fuelType">Fuel Type:</label>
          <select id="fuelType" name="fuelType" required>
              <option value="">--Select--</option>
              <option value="Petrol">Petrol</option>
              <option value="Diesel">Diesel</option>
              <option value="Electric">Electric</option>
          </select>

          <label for="transmission">Transmission:</label>
          <select id="transmission" name="transmission" required>
              <option value="">--Select--</option>
              <option value="Manual">Manual</option>
              <option value="Automatic">Automatic</option>
          </select>
          
          <label for="ownerType">Owner Type:</label>
<select id="ownerType" name="ownerType" required>
    <option value="">--Select--</option>
    <option value="1st Owner">1st Owner</option>
    <option value="2nd Owner">2nd Owner</option>
    <option value="3rd Owner">3rd Owner</option>
    <option value="4th Owner">4th Owner</option>
    <option value="5th Owner">5th Owner or More</option>
</select>
          

          <label for="mileage">Mileage (km/l):</label>
          <input type="number" id="mileage" name="mileage" step="0.1" required>

          <button type="submit">Add Car</button>
        </form>
      </section>
    </main>
  </div>

  <!-- Corrected JS Path -->
  <script src="../admin deshboard/js/caradd.js"></script>
</body>
</html>
