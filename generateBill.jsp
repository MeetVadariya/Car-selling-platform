<%@ page import="java.io.*, java.sql.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>
<%
    String bookingId = request.getParameter("booking_id");

    if (bookingId == null || bookingId.isEmpty()) {
        out.println("<h2>Invalid Booking ID!</h2>");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");

        String query = "SELECT * FROM bookings WHERE id = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(bookingId));
        rs = ps.executeQuery();

        if (rs.next()) {
            // Set response headers for PDF download
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=bill_" + bookingId + ".pdf");

            // Create PDF document
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Add content to the PDF
            document.add(new Paragraph("CarZone Booking Invoice", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
            document.add(new Paragraph("--------------------------------------------------------------"));
            document.add(new Paragraph("Booking ID: " + rs.getInt("id")));
            document.add(new Paragraph("Car ID: " + rs.getInt("car_id")));
            document.add(new Paragraph("Customer Name: " + rs.getString("customer_name")));
            document.add(new Paragraph("Email: " + rs.getString("customer_email")));
            document.add(new Paragraph("Phone: " + rs.getString("customer_phone")));
            document.add(new Paragraph("Address: " + rs.getString("customer_address")));
            document.add(new Paragraph("Price: ₹" + rs.getDouble("price")));
            document.add(new Paragraph("Payment Method: " + rs.getString("payment_method")));
            document.add(new Paragraph("--------------------------------------------------------------"));
            document.add(new Paragraph("Thank you for booking with CarZone!", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14)));

            document.close();
        } else {
            out.println("<h2>No booking found!</h2>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error generating bill.</h2>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
