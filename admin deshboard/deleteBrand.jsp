<%@ page import="java.sql.*, com.admin.DbConnection" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    try (Connection conn = DbConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement("DELETE FROM carbrand WHERE id = ?")) {
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("brand.jsp");
%>
