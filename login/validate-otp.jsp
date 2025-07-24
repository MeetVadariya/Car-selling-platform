<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page import="java.io.*" %>

<%
    String errorMessage = (String) session.getAttribute("otpError");
    if (errorMessage == null) {
        errorMessage = "";
    }

    // Clear the error message after displaying it
    session.removeAttribute("otpError");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>OTP Verification - CarZone</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/NewFile.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f4f4f4;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #ffffff;
            padding: 40px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            text-align: center;
            width: 100%;
            max-width: 400px;
        }
        h2 {
            color: #333;
        }
        .form-control {
            margin-bottom: 20px;
            height: 45px;
        }
        .btn-verify {
            background: #28a745;
            color: #fff;
            transition: 0.3s;
        }
        .btn-verify:hover {
            background: #218838;
            transform: scale(1.05);
        }
        .btn-back {
            background: #6c757d;
            color: #fff;
        }
        .btn-back:hover {
            background: #5a6268;
            transform: scale(1.05);
        }
        .error-message {
            color: #dc3545;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
<div class="container">
    <h2><i class="fas fa-shield-alt"></i> OTP Verification</h2>

    <% if (!errorMessage.isEmpty()) { %>
        <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <form action="validate-otp-action.jsp" method="post">
        <label for="otp">Enter OTP:</label>
        <input type="text" id="otp" name="otp" class="form-control" placeholder="Enter 6-digit OTP" required>
        
        <button type="submit" class="btn btn-verify btn-block"><i class="fas fa-check"></i> Verify OTP</button>
        <a href="forgot-password.jsp" class="btn btn-back btn-block mt-2"><i class="fas fa-arrow-left"></i> Back</a>
    </form>
</div>

<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</body>
</html>
