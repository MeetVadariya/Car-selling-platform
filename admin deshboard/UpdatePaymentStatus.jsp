<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String status = request.getParameter("status");

    Connection conn = null;
    PreparedStatement stmt = null;

    String url = "jdbc:mysql://localhost:3306/carzone";
    String user = "root";
    String password = "Meet@9801";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String query = "UPDATE bookings SET status = ? WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, status);
        stmt.setInt(2, id);
        stmt.executeUpdate();

        response.sendRedirect("AdminPayment.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
