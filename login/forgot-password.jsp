<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, jakarta.mail.*, jakarta.mail.internet.*, jakarta.mail.Authenticator, jakarta.mail.PasswordAuthentication" %>
<%@ page import="java.security.SecureRandom" %>

<%
    // Initialize message variable
    String message = "";

    // Handle errors or success messages from redirects
    if (request.getParameter("error") != null) {
        message = request.getParameter("error");
    } else if (request.getParameter("success") != null) {
        message = request.getParameter("success");
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");

        // Database connection settings
        String dbURL = "jdbc:mysql://localhost:3306/carzone";
        String dbUser = "root";               // Use actual MySQL username
        String dbPassword = "Meet@9801";        // Use actual MySQL password

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Check if the email exists in the database
            String query = "SELECT * FROM username WHERE email = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Generate OTP
                SecureRandom random = new SecureRandom();
                int otp = 100000 + random.nextInt(900000);

                // Store OTP in session with timestamp
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);
                session.setAttribute("otp_timestamp", System.currentTimeMillis());

                // Email configuration
                String fromEmail = "";         // Replace with your email
                String fromPassword = "";         // Replace with your email password
                String host = "smtp.gmail.com";

                Properties props = new Properties();
                props.put("mail.smtp.host", host);
                props.put("mail.smtp.port", "587");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");

                Session mailSession = Session.getInstance(props, new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, fromPassword);
                    }
                });

                // Send the OTP email
                Message msg = new MimeMessage(mailSession);
                msg.setFrom(new InternetAddress(fromEmail));
                msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                msg.setSubject("CarZone - OTP Verification");
                msg.setText("Your OTP for password reset is: " + otp + "\n\nThis OTP is valid for 5 minutes.");
                Transport.send(msg);

                // Redirect to OTP validation page
                response.sendRedirect("validate-otp.jsp?success=OTP sent successfully");
                return;

            } else {
                message = "Email not found!";
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!-- HTML Section -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - CarZone</title>
    
    <!-- Bootstrap & Icons -->
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
            transition: transform 0.3s, box-shadow 0.3s;
            text-align: center;
            position: relative;
        }

        .container:hover {
            transform: translateY(-10px);
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.3);
        }

        .icon-box {
            font-size: 80px;
            color: #007bff;
            margin-bottom: 20px;
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

        .btn-secondary {
            background-color: #6c757d;
            border: none;
            transition: all 0.3s;
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 30px;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
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
    
    <div class="icon-box">
        <i class="fas fa-lock"></i>
    </div>

    <h2 class="mb-4">Forgot Password</h2>

    <form action="forgot-password.jsp" method="POST">
        <div class="mb-3">
            <label for="email" class="form-label">
                <i class="fas fa-envelope"></i> Enter your email:
            </label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-paper-plane"></i> Send OTP
            </button>

            <a href="index.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Login
            </a>
        </div>
    </form>

    <!-- Display success or error message -->
    <% if (message != null && !message.isEmpty()) { %>
        <div class="alert <%= message.contains("success") ? "alert-success" : "alert-danger" %>">
            <i class="fas <%= message.contains("success") ? "fa-check-circle" : "fa-times-circle" %>"></i>
            <%= message %>
        </div>
    <% } %>

</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>

</body>
</html>
