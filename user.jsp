<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    // ✅ Check if the user is logged in
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login/index.jsp");
        return;
    }

    // ✅ Database Connection Details
    String dbURL = "jdbc:mysql://localhost:3306/carzone";
    String dbUser = "root";
    String dbPass = "Meet@9801";

    String name = "", email = "", phone = "";
    int userId = 0;

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        // ✅ Load MySQL Driver First
        Class.forName("com.mysql.cj.jdbc.Driver");

        // ✅ Establish the connection first
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // ✅ Prepare the SQL statement
        String query = "SELECT id, name, email, phone FROM username WHERE email = ? LIMIT 1";
        pst = conn.prepareStatement(query);
        pst.setString(1, userEmail);

        // ✅ Execute the query
        rs = pst.executeQuery();

        if (rs.next()) {
            userId = rs.getInt("id");
            name = rs.getString("name");
            email = rs.getString("email");
            phone = rs.getString("phone");

            // ✅ Store values in session
            session.setAttribute("userId", userId);  // Store userId for future reference
            session.setAttribute("username", name);
            session.setAttribute("email", email);
            session.setAttribute("phone", phone);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // ✅ Close resources properly
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Zone - User Profile</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/user2.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
    
</head>
<body>

<!-- ✅ Navigation Bar -->
<div class="header_section" style="background-color: white;">
         <div class="container" style="background-color: white;">
            <nav class="navbar navbar-expand-lg navbar-light" style="background-color: white;">
               <a class="navbar-brand" href="index.jsp"><img src="images/logo3.png" /></a>
               <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
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
                     <!-- ✅ Display Logged-In Username -->
                    <li class="nav-item">
                        <a class="nav-link" href="user.jsp">
                            <i class="fa fa-user"></i> 
                            <%= (name != null && !name.isEmpty()) ? name : "Profile" %>
                        </a>
                    </li>
                    
                  </ul>                  
               </div>
            </nav>
         </div>
      </div>
                   
                    
           
<!-- ✅ User Profile Section -->
<div class="container mt-5">
    <div class="row">
        <div class="col-md-3">
            <div class="sidebar p-3 bg-light">
                <h4>Dashboard</h4>
                <ul class="list-unstyled">
                    <li><a href="user.jsp">Profile</a></li>
                    <li><a href="userOrders.jsp">View Orders</a></li>
 <!-- <li><a href="feedback_user.jsp">Feedback</a></li>
                   
                   <li><a href="#">Settings</a></li>
                    <li><a href="#">Change Password</a></li>--> 
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>

        <div class="col-md-9">
            <h2 class="text-center">User Profile</h2>
            <div class="card p-4">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <img src="images/profile.png" class="img-fluid rounded-circle" width="150" alt="User Profile Picture">
                    </div>
                    <div class="col-md-8">
                      <!--   <h4><strong>ID:</strong> <%= userId %></h4>  -->
                        <h4><strong>Name:</strong> <%= name %></h4>
                        <p><strong>Email:</strong> <%= email %></p>
                        <p><strong>Phone:</strong> <%= phone %></p>
                        
                        <button class="btn btn-primary" data-toggle="modal" data-target="#editProfileModal">Edit Profile</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ✅ Edit Profile Modal -->
<div class="modal fade" id="editProfileModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Profile</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form action="updateProfile.jsp" method="post">
                    <div class="form-group">
                        <label>Name:</label>
                        <input type="text" class="form-control" name="name" value="<%= name %>">
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" class="form-control" name="email" value="<%= email %>">
                    </div>
                    <div class="form-group">
                        <label>Phone:</label>
                        <input type="text" class="form-control" name="phone" value="<%= phone %>">
                    </div>
                    
                    <div class="text-center">
            <button type="submit" class="btn btn-success">Save Changes</button>
        </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ✅ JavaScript -->
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>

</body>
</html>
