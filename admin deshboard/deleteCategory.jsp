<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");
        pstmt = conn.prepareStatement("DELETE FROM carcategories WHERE id = ?");
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
        response.sendRedirect("categories.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
