<%@ page import="java.sql.*, javax.servlet.*" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    String dbURL = "jdbc:mysql://localhost:3306/carzone";
    String dbUser = "root";
    String dbPass = "Meet@9801";

    try (
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        PreparedStatement pst = conn.prepareStatement("UPDATE username SET name=?, phone=? WHERE email=?")
    ) {
        Class.forName("com.mysql.cj.jdbc.Driver");

        pst.setString(1, name);
        pst.setString(2, phone);
        pst.setString(3, email);

        int updated = pst.executeUpdate();
        if (updated > 0) {
            session.setAttribute("username", name);
            session.setAttribute("phone", phone);
            response.sendRedirect("user.jsp");
        } else {
            out.println("Profile update failed.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
