<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Gallery</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
  <!-- Custom CSS -->
  <link rel="stylesheet" type="text/css" href="css/main.css">
  <link rel="stylesheet" href="css/responsive.css">
  <!-- Favicon -->
  <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">

  <!-- Font CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&family=Raleway:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <!-- Scrollbar Custom CSS -->
  <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
  <!-- Tweaks for older IEs-->
  <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
  <style>
    .gallery_box {
      margin-bottom: 30px;
      text-align: center;
    }
    .gallery_box img {
      width: 100%;
      height: auto;
    }
    /* Ensure rows clear floats */
    .row::after {
      content: "";
      display: table;
      clear: both;
    }
    /* Optional: Adjust padding for columns if needed */
    .col-md-4 {
      padding: 15px;
    }
    .gallery_box img {
  width: 100%;          /* Ensure image fits its container width */
  height: 200px;         /* Fixed height for consistency */
  object-fit: cover;     /* Crop images to fill the fixed dimensions */
  border-radius: 10px;   /* Optional: Rounded corners for a better look */
  transition: transform 0.3s; /* Smooth hover effect */
}

.gallery_box img:hover {
  transform: scale(1.05); /* Slight zoom effect on hover */
}
    
  </style>
</head>
<body>
  <!-- Header Section Start -->
  <div class="header_section">
    <div class="container">
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp"><img src="images/logo3.png" alt="Logo"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
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
  <!-- Header Section End -->

  <div class="call_text_main">
    <div class="container">
      <div class="call_taital">
        <div class="call_text">
          <a href="#"><i class="fa fa-map-marker" aria-hidden="true"></i>
          <span class="padding_left_15">Location</span></a>
        </div>
        <div class="call_text">
          <a href="#"><i class="fa fa-phone" aria-hidden="true"></i>
          <span class="padding_left_15">+91 123456789</span></a>
        </div>
        <div class="call_text">
          <a href="#"><i class="fa fa-envelope" aria-hidden="true"></i>
          <span class="padding_left_15">meet@gmail.com</span></a>
        </div>
      </div>
    </div>
  </div>

  <!-- Optional Search/Filter Section -->
  <!-- When the user submits this form, the filter parameters are sent via GET -->
  <div class="container">
    <div class="select_box_section">
      <div class="select_box_main">
        <form action="gallery.jsp" method="get">
          <div class="row">
            <div class="col-md-3 select-outline">
              <select name="brand" class="mdb-select md-form md-outline colorful-select dropdown-primary">
                <option value="" disabled selected>Car Brand</option>
                <option value="BMW">BMW</option>
                <option value="TATA">TATA</option>
                <option value="Skoda">Skoda</option>
              </select>
            </div>
            <div class="col-md-3 select-outline">
              <select name="type" class="mdb-select md-form md-outline colorful-select dropdown-primary">
                <option value="" disabled selected>Car Type</option>
                <option value="Sedan">Sedan</option>
                <option value="SUV">SUV</option>
                <option value="Hatchback">Hatchback</option>
              </select>
            </div>
            <div class="col-md-3 select-outline">
              <select name="price" class="mdb-select md-form md-outline colorful-select dropdown-primary">
                <option value="" disabled selected>Car Price</option>
                <option value="1000000">₹1,000,000+</option>
                <option value="500000">₹500,000 - ₹1,000,000</option>
                <option value="250000">₹250,000 - ₹500,000</option>
              </select>
            </div>
            <div class="col-md-3">
              <div class="search_btn"><button type="submit" class="btn btn-primary">Search Now</button></div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Gallery Section Start -->
  <div class="gallery_section layout_padding">
    <div class="container">
      <h1 class="gallery_taital text-center">Our Car Listings</h1>
      <%
        // Retrieve filter parameters from the request
        String filterBrand = request.getParameter("brand");
        String filterType  = request.getParameter("type");
        String filterPrice = request.getParameter("price");

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/carzone";
        String dbUser = "root";
        String dbPassword = "Meet@9801";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int counter = 0;

        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          con = DriverManager.getConnection(url, dbUser, dbPassword);

          // Build the query dynamically based on filters
          String query = "SELECT * FROM cars WHERE 1=1";
          if(filterBrand != null && !filterBrand.trim().isEmpty()){
            query += " AND brand = ?";
          }
          if(filterType != null && !filterType.trim().isEmpty()){
            query += " AND type = ?";
          }
          if(filterPrice != null && !filterPrice.trim().isEmpty()){
            // For demonstration, assume price filter is a minimum price.
            query += " AND price >= ?";
          }
          
          ps = con.prepareStatement(query);
          int paramIndex = 1;
          if(filterBrand != null && !filterBrand.trim().isEmpty()){
            ps.setString(paramIndex++, filterBrand);
          }
          if(filterType != null && !filterType.trim().isEmpty()){
            ps.setString(paramIndex++, filterType);
          }
          if(filterPrice != null && !filterPrice.trim().isEmpty()){
            ps.setDouble(paramIndex++, Double.parseDouble(filterPrice));
          }
          
          rs = ps.executeQuery();
          
          out.println("<div class='row'>"); // Start first row
          while (rs.next()) {
            counter++;
      %>
            <div class="col-md-4">
              <div class="gallery_box">
                <div class="gallery_img">
                  <img src="<%= request.getContextPath() %>/uploads/<%= rs.getString("image_path") %>" 
                       alt="<%= rs.getString("name") %>">
                  <h3 class="types_text"><%= rs.getString("brand") %></h3>
                </div>
                <h3 class="types_text"><%= rs.getString("name") %></h3>
                <p class="looking_text">₹<%= rs.getDouble("price") %></p>
                <!-- Book Now Button -->
                <div class="read_bt">
                  <a href="bookCar.jsp?id=<%= rs.getInt("id") %>">Book Now</a>
                </div>
              </div>
            </div>
      <%
            // After every 3 items, close the row and start a new one if needed.
            if (counter % 3 == 0) {
              out.println("</div>");
              if (!rs.isAfterLast()) {
                out.println("<div class='row'>");
              }
            }
          }
          // Close the last row if not closed already.
          if (counter % 3 != 0) {
            out.println("</div>");
          }
        } catch(Exception e) {
          e.printStackTrace();
        } finally {
          if(rs != null) { try { rs.close(); } catch(Exception e) { e.printStackTrace(); } }
          if(ps != null) { try { ps.close(); } catch(Exception e) { e.printStackTrace(); } }
          if(con != null) { try { con.close(); } catch(Exception e) { e.printStackTrace(); } }
        }
      %>
    </div>
  </div>
  <!-- Gallery Section End -->

  <!-- Footer Section Start -->
  <div class="footer_section layout_padding">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="footeer_logo"><img src="" alt=""></div>
        </div>
      </div>
      <div class="footer_section_2">
        <div class="row">
          <div class="col">
            <h4 class="footer_taital">Subscribe Now</h4>
            <p class="footer_text">There are many variations of passages of Lorem Ipsum available.</p>
            <div class="form-group">
              <textarea class="update_mail" placeholder="Enter Your Email" rows="5" id="comment" name="Enter Your Email"></textarea>
              <div class="subscribe_bt"><a href="#">Subscribe</a></div>
            </div>
          </div>
          <div class="col">
            <h4 class="footer_taital">Information</h4>
            <p class="lorem_text">There are many variations of passages of Lorem Ipsum available, but the majority.</p>
          </div>
          <div class="col">
            <h4 class="footer_taital">Helpful Links</h4>
            <p class="lorem_text">There are many variations of passages of Lorem Ipsum available, but the majority.</p>
          </div>
          <div class="col">
            <h4 class="footer_taital">Investments</h4>
            <p class="lorem_text">There are many variations of passages of Lorem Ipsum available, but the majority.</p>
          </div>
          <div class="col">
            <h4 class="footer_taital">Contact Us</h4>
            <div class="location_text">
              <a href="#"><i class="fa fa-map-marker" aria-hidden="true"></i>
              <span class="padding_left_15">Location</span></a>
            </div>
            <div class="location_text">
              <a href="#"><i class="fa fa-phone" aria-hidden="true"></i>
              <span class="padding_left_15">(+71) 8522369417</span></a>
            </div>
            <div class="location_text">
              <a href="#"><i class="fa fa-envelope" aria-hidden="true"></i>
              <span class="padding_left_15">meet@gmail.com</span></a>
            </div>
            <div class="social_icon">
              <ul>
                <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Footer Section End -->


  <!-- Javascript Files -->
  <script src="js/jquery.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.bundle.min.js"></script>
  <script src="js/jquery-3.0.0.min.js"></script>
  <script src="js/plugin.js"></script>
  <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
  <script src="js/custom.js"></script>
</body>
</html>