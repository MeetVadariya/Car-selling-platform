<%@ page import="java.sql.*" %>
<%
String carId = request.getParameter("id");
String brand = "";
String name = "";
String category = "";
String year = "";
String price = "";
String imagePath = "";

// Database credentials
String url = "jdbc:mysql://localhost:3306/carzone";
String user = "root";
String password = "Meet@9801";

// Fetch car details if carId is provided
if (carId != null) {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);
        
        // Fetch car data for the given carId
        String query = "SELECT * FROM cars WHERE id=?";
        ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(carId));
        rs = ps.executeQuery();
        
        if (rs.next()) {
        	brand = rs.getString("brand");
            name = rs.getString("name");
            category = rs.getString("category");
            year = rs.getString("year");
            price = rs.getString("price");
            imagePath = rs.getString("image_path"); // Fetch existing image path
        } else {
            response.sendRedirect("listing.jsp?msg=Car not found");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("listing.jsp?msg=Error: " + e.getMessage());
        return;
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Car</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 500px;
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-size: 16px;
            margin-bottom: 10px;
            display: block;
        }

        input[type="text"], input[type="file"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #2c3e50;
            color: white;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #34495e;
        }

        img {
            margin-bottom: 15px;
            border-radius: 5px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group:last-child {
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Car Details</h2>

        <% if (carId != null) { %>
            <form action="<%= request.getContextPath() %>/UploadCarImageServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= carId %>">

 				<div class="form-group">
                    <label for="brand"> Car Brand:</label>
                    <input type="text" id="brand" name="brand" value="<%= brand %>" required>
                </div>
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= name %>" required>
                </div>

                <div class="form-group">
                    <label for="category">Category:</label>
                    <input type="text" id="category" name="category" value="<%= category %>" required>
                </div>

                <div class="form-group">
                    <label for="year">Year:</label>
                    <input type="text" id="year" name="year" value="<%= year %>" required>
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="text" id="price" name="price" value="<%= price %>" required>
                </div>

                <div class="form-group">
                    <label>Current Image:</label><br>
                    <% if (imagePath != null && !imagePath.isEmpty()) { %>
      				  <img src="<%= request.getContextPath() %>/uploads/<%= imagePath %>" alt="Car Image" style="width: 150px; height: auto;"><br>
   					 <% } %>
                </div>

                <div class="form-group">
                    <label for="carImage">Upload New Image:</label>
                    <input type="file" id="carImage" name="carImage" accept="image/*">
                </div>

                <div class="form-group">
                    <input type="submit" value="Update Car">
                </div>
            </form>
        <% } %>
    </div>
</body>
</html>
