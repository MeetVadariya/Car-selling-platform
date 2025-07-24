<%@ page import="java.sql.*" %>

<%
    // Get form parameters
    String bookingId = request.getParameter("booking_id");
    String newStatus = request.getParameter("status");

    if (bookingId != null && newStatus != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");

            String sql = "UPDATE bookings SET status = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, Integer.parseInt(bookingId));
            pstmt.executeUpdate();

            // Redirect back to adminOrders.jsp
            response.sendRedirect("adminOrders.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminOrders.jsp?error=1");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        response.sendRedirect("adminOrders.jsp?error=1");
    }
%>
