<%@ page import="java.sql.*" %>

<%
    int feedbackId = Integer.parseInt(request.getParameter("id"));

    Connection conn = null;
    PreparedStatement stmt = null;

    String url = "jdbc:mysql://localhost:3306/carzone";
    String user = "root";
    String password = "Meet@9801";  // Replace with your MySQL password

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL query to delete feedback
        String query = "DELETE FROM feedback WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, feedbackId);

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("AdminFeedback.jsp");  // Redirect back to Admin page
        } else {
            out.println("<p>Failed to delete feedback.</p>");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
