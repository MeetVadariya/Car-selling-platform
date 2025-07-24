<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, jakarta.servlet.http.*, jakarta.servlet.*" %>

<%
    // Get the OTP entered by the user
    String enteredOtp = request.getParameter("otp");

    // Get the OTP stored in the session
    Integer sessionOtp = (Integer) session.getAttribute("otp");
    String email = (String) session.getAttribute("email");

    if (sessionOtp != null && enteredOtp != null) {
        if (enteredOtp.equals(sessionOtp.toString())) {
            // OTP matched
            session.removeAttribute("otp");  // Clear OTP after successful verification

            // Redirect to password reset page
            response.sendRedirect("reset-password.jsp?email=" + email);
            return;
        } else {
            // Incorrect OTP
            session.setAttribute("otpError", "Invalid OTP. Please try again.");
            response.sendRedirect("validate-otp.jsp");
            return;
        }
    } else {
        // Missing OTP or session expired
        session.setAttribute("otpError", "Session expired or OTP missing. Please try again.");
        response.sendRedirect("forgot-password.jsp");
    }
%>
