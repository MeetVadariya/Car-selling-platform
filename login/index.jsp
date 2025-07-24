<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%-- ✅ Session Check: Redirect Logged-in Users --%>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("../dashboard.jsp"); 
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- site metas -->
    <title>Car Zone</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="css/NewFile.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&family=Raleway:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        .alert {
            transition: opacity 0.5s ease-in-out;
        }
    </style>
</head>

<body>

<%-- ✅ Logout Success Message --%>
<%
    String logoutMsg = request.getParameter("logout");
    if ("success".equals(logoutMsg)) {
%>
    <div id="logoutMessage" class="alert alert-success" role="alert">
        Successfully logged out!
    </div>
<% } %>
<%
    String successMessage = request.getParameter("success");
%>

<% if (successMessage != null && !successMessage.isEmpty()) { %>
    <div class="alert alert-success" role="alert">
        <i class="fas fa-check-circle"></i> <%= successMessage %>
    </div>
<% } %>

<%-- ✅ Cache Prevention: Prevent Back Navigation After Logout --%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%-- ✅ Session Check: Redirect Logged-in Users --%>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("../dashboard.jsp");  // Redirect logged-in users
        return;
    }
%>


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
                    <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                </ul>
            </div>
        </nav>
    </div>
</div>
<!-- header section end -->

<!-- Login Form Section -->
<div class="center-container">

    <form method="post" action="../login/validation.jsp" class="login-form">
        <!-- Email with icon -->
        <h2>Log In</h2>
        <div class="input-container">
            <i class="fas fa-envelope icon"></i>
            <input class="form-control" type="email" name="email" id="email" placeholder="Email" required>
        </div>

        <!-- Password with icon -->
        <div class="input-container">
            <i class="fas fa-lock icon"></i>
            <input class="form-control" type="password" name="password" id="password" placeholder="Password" required>
        </div>

        <button class="btn-login" type="submit">Login</button>

        <div class="form-links">
            <a href="forgot-password.jsp" class="forgot-link">
                <i class="fas fa-key"></i> Forgot Password?
            </a>
            <a href="register.jsp" class="register-link">
                <i class="fas fa-user-plus"></i> New User? Register
            </a>
        </div>
    </form>
</div>

<!-- JavaScript files -->
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script src="js/jquery-3.0.0.min.js"></script>
<script src="js/plugin.js"></script>
<script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="js/custom.js"></script>

<!-- ✅ JavaScript to auto-hide the logout message after 2 seconds -->
<!-- ✅ JavaScript to Auto-Hide Logout Message -->
<script>
    window.onload = function() {
        const logoutMessage = document.getElementById("logoutMessage");
        if (logoutMessage) {
            setTimeout(() => {
                logoutMessage.style.opacity = "0";
                setTimeout(() => {
                    logoutMessage.style.display = "none";
                }, 500);  // Smooth fade-out transition
            }, 2000);  // 2 seconds
        }
    };
</script>

</body>
</html>
