<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="text-center mt-4">Your Shopping Cart</h2>
        <%
            List<String> cart = (List<String>) session.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
                out.println("<p class='alert alert-warning text-center'>Your cart is empty!</p>");
            } else {
                String url = "jdbc:mysql://localhost:3306/carzone";
                String dbUser = "root";
                String dbPassword = "Meet@9801";
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, dbUser, dbPassword);

                    out.println("<table class='table table-bordered text-center'>");
                    out.println("<tr><th>Car Image</th><th>Car Name</th><th>Brand</th><th>Price</th><th>Action</th></tr>");

                    for (String carId : cart) {
                        String query = "SELECT * FROM cars WHERE id = ?";
                        ps = con.prepareStatement(query);
                        ps.setInt(1, Integer.parseInt(carId));
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            String imageUrl = rs.getString("image_path"); // Fetch image URL from DB

                            out.println("<tr>");
                            out.println("<td><img src='" + imageUrl + "' alt='Car Image' width='100' height='70' class='img-thumbnail'></td>");
                            out.println("<td>" + rs.getString("name") + "</td>");
                            out.println("<td>" + rs.getString("brand") + "</td>");
                            out.println("<td>₹" + rs.getDouble("price") + "</td>");
                            out.println("<td><a href='removecart.jsp?car_id=" + carId + "' class='btn btn-danger'>Remove</a></td>");
                            out.println("</tr>");
                        }
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                }
            }
        %>
        <a href="checkout.jsp" class="btn btn-primary">Proceed to Checkout</a>
    </div>
</body>
</html>
