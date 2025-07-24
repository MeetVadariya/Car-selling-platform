<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Car Buy & Sell Admin Dashboard</title>
  <link rel="stylesheet" href="../admin deshboard/css/admin.css">
  <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
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
        <!--    <li><a href="#">Payment</a></li>
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

      <section class="cards">
        <div class="card" id="total-users"><h3>Total Users</h3><p>Loading...</p></div>
        <div class="card" id="active-listings"><h3>Total Car</h3><p>Loading...</p></div>
        <div class="card" id="transactions"><h3>Transactions</h3><p>Loading...</p></div>
        <div class="card" id="revenue"><h3>Revenue</h3><p>Loading...</p></div>
      </section>

      <section class="table-section">
        <h2>Recent Listings</h2>
        <table>
          <thead>
            <tr><th>ID</th><th>Car Name</th><th>Seller</th><th>Price</th><th>Status</th><th>Actions</th></tr>
          </thead>
          <tbody id="listing-table">
            <!-- Dynamic rows will be inserted here -->
          </tbody>
        </table>
      </section>

      <section class="charts">
        <h2>Analytics</h2>
        <canvas id="salesChart"></canvas>
      </section>

      <section class="notifications">
        <h2>Notifications</h2>
        <ul id="notification-list"></ul>
      </section>
    </main>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="../admin deshboard/js/admin.js"></script>
</body>
</html>
