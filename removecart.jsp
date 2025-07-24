<%@ page import="java.util.*" %>
<%
    String carId = request.getParameter("car_id");

    if (carId != null) {
        List<String> cart = (List<String>) session.getAttribute("cart");
        if (cart != null) {
            cart.remove(carId);
            session.setAttribute("cart", cart);
        }
    }
    response.sendRedirect("cart.jsp");
%>
