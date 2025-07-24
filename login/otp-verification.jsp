<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String errorMessage = (String) session.getAttribute("otpError");
    if (errorMessage == null) {
        errorMessage = "";
    }
    session.removeAttribute("otpError");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>OTP Verification</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <style>
        body { background: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .container { background: #fff; padding: 40px; border-radius: 10px; box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); }
    </style>
</head>
<body>

<div class="container">
    <h2>OTP Verification</h2>
    
    <% if (!errorMessage.isEmpty()) { %>
        <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <form action="validate-otp-action.jsp" method="post">
        <input type="text" name="otp" class="form-control" placeholder="Enter 6-digit OTP" required>
        <button type="submit" class="btn btn-primary btn-block">Verify OTP</button>
    </form>
</div>

<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</body>
</html>
