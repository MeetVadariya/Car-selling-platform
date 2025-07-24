<%@ page import="java.sql.*" %>
<%
    // Retrieve feedback details from the form
    String customerName = request.getParameter("customer_name");
    String customerEmail = request.getParameter("customer_email");
    String rating = request.getParameter("rating");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement stmt = null;

    String url = "jdbc:mysql://localhost:3306/carzone";
    String user = "root";
    String password = "Meet@9801";  // Replace with your MySQL password

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL query to insert feedback
        String query = "INSERT INTO feedback (customer_name, customer_email, rating, message) VALUES (?, ?, ?, ?)";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, customerName);
        stmt.setString(2, customerEmail);
        stmt.setInt(3, Integer.parseInt(rating));
        stmt.setString(4, message);

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("feedback_user.jsp");  // Redirect to feedback display page
        } else {
            out.println("<p>Failed to submit feedback. Please try again!</p>");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
