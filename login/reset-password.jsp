<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%
    String message = "";

    // Get email from session
    String email = (String) session.getAttribute("email");

    if (email == null) {
        // Redirect to forgot-password if session expired
        response.sendRedirect("forgot-password.jsp?error=Session expired, please try again.");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword != null && confirmPassword != null && newPassword.equals(confirmPassword)) {
            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                // Connect to database
                String dbURL = "jdbc:mysql://localhost:3306/carzone";
                String dbUser = "root";            
                String dbPassword = "Meet@9801";  

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Hash the password (for security)
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hash = md.digest(newPassword.getBytes("UTF-8"));
                StringBuilder hexString = new StringBuilder();
                for (byte b : hash) {
                    hexString.append(String.format("%02x", b));
                }
                String hashedPassword = hexString.toString();

                // Update password in database
                String query = "UPDATE username SET password = ? WHERE email = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, hashedPassword);
                stmt.setString(2, email);

                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    message = "Password reset successfully! You can now <a href='index.jsp'>login</a>.";
                } else {
                    message = "Failed to reset password. Try again!";
                }

            } catch (Exception e) {
                e.printStackTrace();
                message = "Error: " + e.getMessage();
            } finally {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        } else {
            message = "Passwords do not match!";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - CarZone</title>
    
    <!-- Bootstrap & Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #74EBD5, #ACB6E5);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 600px;
            background: #fff;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 50px;
            border-radius: 12px;
            text-align: center;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            transition: all 0.3s;
            padding: 12px 30px;
            font-size: 18px;
            border-radius: 30px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            transform: scale(1.08);
        }

        .form-control {
            border-radius: 25px;
            padding: 12px;
            font-size: 16px;
        }

        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    
    <h2 class="mb-4">Reset Your Password</h2>

    <form action="reset-password.jsp" method="POST">
        
        <div class="mb-3">
            <label for="newPassword" class="form-label">New Password:</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
        </div>

        <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm Password:</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
        </div>

        <button type="submit" class="btn btn-primary">Reset Password</button>
    </form>

    <!-- Display success or error message -->
    <% if (message != null && !message.isEmpty()) { %>
        <div class="alert <%= message.contains("successfully") ? "alert-success" : "alert-danger" %>">
            <%= message %>
        </div>
    <% } %>

</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>

</body>
</html>
