<%@ page import="java.util.*, java.util.Properties, jakarta.mail.*, jakarta.mail.internet.*, java.sql.*" %>

<%
    String email = request.getParameter("email");
    String otp = String.format("%06d", new Random().nextInt(999999));

    // Store OTP in session
    session.setAttribute("otp", otp);
    session.setAttribute("email", email);

    String fromEmail = "";
    String password = "";  // Gmail App Password
    String host = "smtp.gmail.com";

    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.ssl.trust", "smtp.gmail.com");  // SSL trust

    try {
        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message msg = new MimeMessage(mailSession);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        msg.setSubject("CarZone - OTP Verification");
        msg.setText("Your OTP is: " + otp);

        Transport.send(msg);

        response.sendRedirect("otp-verification.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("error", "Failed to send OTP. Try again.");
        response.sendRedirect("forgot-password.jsp");
    }
%>
