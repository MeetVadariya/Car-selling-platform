<%@ page import="java.sql.*" %>

<%
String carId = request.getParameter("id");

if (carId != null) {
    String url = "jdbc:mysql://localhost:3306/carzone";
    String user = "root";
    String password = "Meet@9801";
    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        String query = "DELETE FROM cars WHERE id=?";
        ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(carId));

        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("listing.jsp?msg=Car Deleted Successfully");
        } else {
            response.sendRedirect("listing.jsp?msg=Error Deleting Car");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
} else {
    response.sendRedirect("listing.jsp?msg=Invalid Car ID");
}
%>
