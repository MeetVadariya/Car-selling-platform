<%@ page import="java.sql.*" %>
<%
    String bookingId = request.getParameter("booking_id");
    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");

        String deleteQuery = "DELETE FROM bookings WHERE id = ?";
        ps = con.prepareStatement(deleteQuery);
        ps.setInt(1, Integer.parseInt(bookingId));
        ps.executeUpdate();

        response.sendRedirect("adminOrders.jsp?msg=Booking deleted successfully");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminOrders.jsp?msg=Error deleting booking");
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
