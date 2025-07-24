<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Feedback Management</title>
    <link rel="stylesheet" href="style.css"> <!-- External CSS -->
    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
        }

        .container {
            width: 90%;
            margin: 0 auto;
            padding: 20px;
            background: white;
            box-shadow: 0 0 10px #ccc;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background: #333;
            color: white;
        }

        /* Star Rating Styling */
        .stars {
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .star {
            font-size: 24px;            /* Star size */
            color: #ccc;                 /* Unfilled star color */
            transition: color 0.3s;
        }

        .star.filled {
            color: #f39c12;              /* Filled star color */
        }

        /* Delete Button Styling */
        .delete-btn {
            display: inline-block;
            padding: 8px 16px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: 0.3s;
        }

        .delete-btn:hover {
            background: #c0392b;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Admin Feedback Management</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Customer Name</th>
                <th>Email</th>
                <th>Rating</th>
                <th>Message</th>
                <th>Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            String url = "jdbc:mysql://localhost:3306/carzone";
            String user = "root";
            String password = "Meet@9801";  // Replace with your MySQL password

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                // Query to get all feedback
                String query = "SELECT * FROM feedback ORDER BY feedback_date DESC";
                stmt = conn.prepareStatement(query);
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("customer_name") %></td>
            <td><%= rs.getString("customer_email") %></td>

            <!-- Star Rating Display -->
            <td>
                <div class="stars">
                    <%
                        int rating = rs.getInt("rating");
                        for (int i = 1; i <= 5; i++) {
                            if (i <= rating) {
                    %>
                    <span class="star filled">★</span>
                    <%
                            } else {
                    %>
                    <span class="star">★</span>
                    <%
                            }
                        }
                    %>
                </div>
            </td>

            <td><%= rs.getString("message") %></td>
            <td><%= rs.getTimestamp("feedback_date") %></td>

            <!-- Delete Button -->
            <td>
                <a href="DeleteFeedback.jsp?id=<%= rs.getInt("id") %>" class="delete-btn">Delete</a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
