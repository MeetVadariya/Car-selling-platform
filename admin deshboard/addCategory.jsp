<%@ page import="java.sql.*" %>
<%
    String categoryName = request.getParameter("categoryName");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");
        pstmt = conn.prepareStatement("INSERT INTO carcategories (car_category) VALUES (?)");
        pstmt.setString(1, categoryName);
        pstmt.executeUpdate();
        response.sendRedirect("categories.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
