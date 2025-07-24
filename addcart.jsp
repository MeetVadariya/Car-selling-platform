<%@ page import="java.sql.*, java.util.*" %>
<%
    // Get the car ID from the request
    String carId = request.getParameter("car_id");

    if (carId != null) {
        // Get the session cart (or create one if it doesn’t exist)
        List<String> cart = (List<String>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        // Add the selected car ID to the cart
        cart.add(carId);
        session.setAttribute("cart", cart);
        
        // Redirect to cart page or show a success message
        response.sendRedirect("cart.jsp");
    } else {
        out.println("<p style='color:red;'>Error adding car to cart!</p>");
    }
%>
