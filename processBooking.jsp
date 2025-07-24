<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>

<%
    // Get booking details from form submission
    String carId = request.getParameter("car_id");
    String customerName = request.getParameter("customer_name");
    String customerEmail = request.getParameter("customer_email");
    String customerPhone = request.getParameter("customer_phone");
    String customerAddress = request.getParameter("customer_address");
    String paymentMethod = request.getParameter("payment_method");
    String cardNumber = request.getParameter("card_number");
    String expiryDate = request.getParameter("expiry_date");
    String cvv = request.getParameter("cvv");
    String bank = request.getParameter("bank");
    String upiId = request.getParameter("upi_id");
    String downPayment = request.getParameter("down_payment");
    String emiPlan = request.getParameter("emi_plan");

    // Store current date in SQL format
    LocalDate localDate = LocalDate.now();
    Date currentDate = Date.valueOf(localDate);  

    double price = Double.parseDouble(request.getParameter("price"));

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int bookingId = -1;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");

        // Insert into bookings table
        String insertBooking = "INSERT INTO bookings (car_id, price, customer_name, customer_email, customer_phone, customer_address, payment_method, card_number, expiry_date, cvv, bank, upi_id, down_payment, emi_plan, booking_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        ps = con.prepareStatement(insertBooking, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, Integer.parseInt(carId));
        ps.setDouble(2, price);
        ps.setString(3, customerName);
        ps.setString(4, customerEmail);
        ps.setString(5, customerPhone);
        ps.setString(6, customerAddress);
        ps.setString(7, paymentMethod);
        ps.setString(8, cardNumber);
        ps.setString(9, expiryDate);
        ps.setString(10, cvv);
        ps.setString(11, bank);
        ps.setString(12, upiId);
        ps.setString(13, downPayment);
        ps.setString(14, emiPlan);
        
        // Use setDate() for SQL Date
        ps.setDate(15, currentDate);
        
        ps.executeUpdate();

        // Get generated booking ID
        rs = ps.getGeneratedKeys();
        if (rs.next()) {
            bookingId = rs.getInt(1); // Get the generated booking_id
        }

        // Redirect to the booking details page
        response.sendRedirect("bookingDetails.jsp?booking_id=" + bookingId);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?msg=" + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
