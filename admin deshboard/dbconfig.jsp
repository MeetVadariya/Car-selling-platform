<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/carzone"; // Change as needed
    String dbUser = "root";  // Change to your MySQL username
    String dbPassword = "Meet@9801";  // Change to your MySQL password
    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color: red;'>Database Connection Failed: " + e.getMessage() + "</p>");
    }
%>
