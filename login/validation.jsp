<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.*, java.sql.*, java.security.MessageDigest" %>

<%@ page import="java.sql.*, java.security.MessageDigest" %>

<%
    // Invalidate any existing session
    if (session != null) {
        session.invalidate();
    }
    session = request.getSession();
    session.setMaxInactiveInterval(30 * 60);  // 30-minute session timeout

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // ✅ Hash the entered password with SHA-256
    String hashedPassword = null;
    try {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedBytes = md.digest(password.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : hashedBytes) {
            sb.append(String.format("%02x", b));
        }
        hashedPassword = sb.toString();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("../login/index.jsp?error=hashing_failed");
        return;
    }

    // Database Credentials
    String dbURL = "jdbc:mysql://localhost:3306/carzone";
    String dbUser = "root";
    String dbPassword = "Meet@9801";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // ✅ Query with hashed password comparison
        String query = "SELECT * FROM username WHERE email = ? AND password = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, email);
        stmt.setString(2, hashedPassword);

        rs = stmt.executeQuery();

        if (rs.next()) {
            // 🌟 Store user info in session
            session.setAttribute("userId", rs.getInt("id"));
            session.setAttribute("userEmail", rs.getString("email"));
            session.setAttribute("Isadmin", rs.getInt("Isadmin"));

            // 🚀 Redirect based on admin status
            if (rs.getInt("Isadmin") == 1) { 
                response.sendRedirect("../admin deshboard/admin.jsp?login=success");
            } else {
                response.sendRedirect("../user.jsp?login=success");
            }
        } else {
            // ❌ Invalid credentials
            response.sendRedirect("../login/index.jsp?error=invalid");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("../login/index.jsp?error=" + e.getMessage());
    } finally {
        // ✅ Close resources
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
