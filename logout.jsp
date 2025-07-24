<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    response.setHeader("Referrer-Policy", "no-referrer");

    // Invalidate session
    if (session != null) {
        session.invalidate();
    }

    // Clear all cookies
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            cookie.setValue("");
            cookie.setPath("/");
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
    }

    // Redirect to login page
    response.sendRedirect("login/index.jsp?logout=success");
%>

<script>
    // Prevent back button navigation after logout
    window.onload = function () {
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    };
</script>
