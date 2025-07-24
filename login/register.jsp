<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.security.MessageDigest, java.security.NoSuchAlgorithmException" %>
<!DOCTYPE html>
<html>
<head>
    <!-- basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- site metas -->
    <title>Car Zone - Register</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&family=Raleway:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>
<body>

<!-- header section start -->
<div class="header_section">
    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="index.html"><img src="../images/logo3.png" alt="Logo"></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="../home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="../about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="../services.jsp">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="../gallery.jsp">Cars</a></li>
                    <li class="nav-item"><a class="nav-link" href="../client.jsp">Client</a></li>
                    <li class="nav-item"><a class="nav-link" href="../contact.jsp">Contact</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Login</a></li>
                </ul>
            </div>
        </nav>
    </div>
</div>
<!-- header section end -->

<!-- Registration Form -->
<div class="center-container">
    <form action="register.jsp" method="POST" class="register-form">
        <h2>Register</h2>
        <div class="input-container">
            <span class="icon">👤</span>
            <input type="text" name="fullName" placeholder="Full Name" required class="form-control">
        </div>
        <div class="input-container">
            <span class="icon">✉️</span>
            <input type="email" name="email" placeholder="Email" required class="form-control">
        </div>
        <div class="input-container">
            <span class="icon">📞</span>
            <input type="tel" name="phone" placeholder="Phone Number" required class="form-control">
        </div>
        <div class="input-container">
            <span class="icon">🔒</span>
            <input type="password" name="password" placeholder="Password" pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}" title="Must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long" required class="form-control">
        </div>
        <button type="submit" class="btn-register">Register</button>
        <div class="form-links">
            <a href="../login/index.jsp">🔑 Already have an account? Login</a>
        </div>
    </form>
</div>

<%
    // ✅ Backend logic for registration
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");

    if (fullName != null && email != null && phone != null && password != null) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // 🔒 Hash the password with SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            String hashedPassword = sb.toString();

            // 🔥 Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");

            // ✅ Check if the email is already registered
            String checkQuery = "SELECT email FROM username WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
%>
                <script>
                    alert("Email already exists. Try logging in.");
                    window.location.href = "../login/index.jsp";
                </script>
<%
            } else {
                // 🚀 Insert the new user
                String query = "INSERT INTO username (name, email, phone, password, Isadmin) VALUES (?, ?, ?, ?, 0)";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, fullName);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, hashedPassword);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
%>
                    <script>
                        alert("Registration successful!");
                        window.location.href = "../login/index.jsp";
                    </script>
<%
                } else {
%>
                    <script>
                        alert("Registration failed. Try again.");
                    </script>
<%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
%>
            <script>
                alert("Error: <%= e.getMessage() %>");
            </script>
<%
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.bundle.min.js"></script>

</body>
</html>
