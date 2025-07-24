<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String carId = request.getParameter("id");
    if (carId == null || carId.isEmpty()) {
        response.sendRedirect("error.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String carName = "";
    String carBrand = "";
    String carDescription = "";
    double carPrice = 0.0;
    String fuelType = "";
    String transmission = "";
    String ownerType = "";
    String mileage = "";
    String imagePath = "default_car.jpg"; 
    String carYear = "2024";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carzone", "root", "Meet@9801");

        String query = "SELECT * FROM cars WHERE id = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(carId));
        rs = ps.executeQuery();

        if (rs.next()) {
            carName = rs.getString("name");
            carBrand = rs.getString("brand");
            carDescription = rs.getString("description");
            carPrice = rs.getDouble("price");
            fuelType = rs.getString("fuel_type");
            transmission = rs.getString("transmission");
            ownerType = rs.getString("owner_type");
            mileage = rs.getString("mileage");
            imagePath = (rs.getString("image_path") != null && !rs.getString("image_path").isEmpty()) ? rs.getString("image_path") : "default_car.jpg";
            carYear = rs.getString("year");
        } else {
            response.sendRedirect("error.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
        return;
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Booking</title>

    <!-- Bootstrap and Icons -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/images/car-icon-in-flat-style-simple-traffic-icon-free-vector.jpg">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>

    <style>
        /* Global Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f4f9;
            color: #333;
            line-height: 1.6;
        }
        
        h2, h3 {
            text-align: center;
            margin-bottom: 20px;
        }

        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 20px;
        }

        /* Card Styling */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card img {
            width: 100%;
            height: auto;
            border-radius: 12px 12px 0 0;
        }

        .card h3 {
            font-size: 1.8rem;
            color: #1e3a8a;
            text-align: center;
        }

        .card p {
            font-size: 1rem;
            margin: 10px 0;
        }

        .btn-custom {
            background: #007bff;
            color: #fff;
            padding: 12px 20px;
            border-radius: 8px;
            text-transform: uppercase;
            transition: 0.3s;
        }

        .btn-custom:hover {
            background: #0056b3;
            color: #fff;
        }

        /* Icon Section */
        .icon-box {
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin: 30px 0;
            padding: 20px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        .icon-box div {
            text-align: center;
        }

        .icon-box i {
            font-size: 2.5rem;
            color: #007bff;
            margin-bottom: 10px;
        }

        .icon-box p {
            font-size: 1rem;
            color: #555;
            margin: 0;
        }

        /* Form Styling */
        form label {
            font-weight: bold;
        }

        form input, form textarea {
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        form button {
            width: 100%;
        }
        .payment-details {
    display: none;
    padding: 15px;
    background: #f8f9fa;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

form label {
    font-weight: bold;
    margin-top: 10px;
}

form input, form textarea, form select {
    border-radius: 8px;
    padding: 12px;
    width: 100%;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

form button {
    width: 100%;
    padding: 12px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 8px;
    transition: 0.3s;
}

form button:hover {
    background: #0056b3;
}
        

        /* Responsive Design */
        @media (max-width: 768px) {
            .icon-box {
                flex-direction: column;
                text-align: center;
            }
            
            .icon-box div {
                margin-bottom: 15px;
            }
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Car Booking</h2>
    
    <div class="row">
        <!-- Car Details Section -->
        <div class="col-md-6">
            <div class="card">
                <img src="uploads/<%= imagePath %>" alt="<%= carName %>">
                <div class="p-4">
                    <h3><%= carBrand %> - <%= carName %></h3>
                    <p><strong>Price:</strong> ₹<%= carPrice %></p>

                    <!-- Icon Section -->
                    <div class="icon-box">
                        <div>
                            <i class="bi bi-calendar"></i>
                            <p><%= carYear %></p>
                        </div>
                        <div>
                            <i class="bi bi-fuel-pump"></i>
                            <p><%= fuelType %></p>
                        </div>
                        <div>
                            <i class="bi bi-speedometer2"></i>
                            <p><%= mileage %> km</p>
                        </div>
                        <div>
                            <i class="bi bi-gear-wide-connected"></i>
                            <p><%= transmission %></p>
                        </div>
                        <div>
                            <i class="bi bi-person"></i>
                            <p><%= ownerType %></p>
                        </div>
                        
                    </div>
                    <p><strong>Description:</strong> <%= carDescription %></p>
                </div>
            </div>
        </div>

        <!-- Booking Form -->
        <div class="col-md-6">
            <div class="card p-4">
                <form action="processBooking.jsp" method="post">
                    <input type="hidden" name="car_id" value="<%= carId %>">
                    <input type="hidden" name="price" value="<%= carPrice %>">
                    
                    <label>Full Name:</label>
                    <input type="text" name="customer_name" required>
                    
                    <label>Email:</label>
                    <input type="email" name="customer_email" required>
                    
                    <label>Phone:</label>
                    <input type="text" name="customer_phone" required>
                    
                    <label>Address:</label>
                    <textarea name="customer_address" rows="3" required></textarea>
                    
                     <!-- Payment Method -->
                    <h4 class="mt-3">Select Payment Method</h4>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="payment_method" value="Card" id="card" onclick="showPaymentDetails('card')" required>
                        <label class="form-check-label" for="card">Credit/Debit Card</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="payment_method" value="Net Banking" id="netbanking" onclick="showPaymentDetails('netbanking')">
                        <label class="form-check-label" for="netbanking">Net Banking</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="payment_method" value="UPI" id="upi" onclick="showPaymentDetails('upi')">
                        <label class="form-check-label" for="upi">UPI</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="payment_method" value="EMI" id="emi" onclick="showPaymentDetails('emi')">
                        <label class="form-check-label" for="emi">EMI</label>
                    </div>

                    <!-- Payment Sections -->
                    <div id="cardDetails" class="payment-details mt-3">
                        <h5>Card Details</h5>
                        <input type="text" class="form-control mb-2 card-number" name="card_number" placeholder="Card Number">
                        <input type="month" class="form-control mb-2" name="expiry_date" placeholder="Expiry Date">
                        <input type="password" class="form-control mb-2" name="cvv" placeholder="CVV">
                    </div>

                    <div id="netBankingDetails" class="payment-details mt-3">
                        <h5>Select Bank</h5>
                        <select class="form-control" name="bank">
                            <option value="sbi">State Bank of India</option>
                            <option value="hdfc">HDFC Bank</option>
                            <option value="icici">ICICI Bank</option>
                            <option value="axis">Axis Bank</option>
                        </select>
                    </div>

                    <div id="upiDetails" class="payment-details mt-3">
                        <h5>UPI Payment</h5>
                        <input type="text" class="form-control mb-2" name="upi_id" placeholder="yourupi@upi">
                    </div>

                    <div id="emiDetails" class="payment-details mt-3">
                        <h5>EMI Plan</h5>
                        <input type="text" class="form-control mb-2" name="down_payment" placeholder="Down Payment">
                        <select class="form-control mb-2" name="emi_plan">
                            <option value="3">3 Months - 5% Interest</option>
                            <option value="6">6 Months - 10% Interest</option>
                            <option value="12">12 Months - 12% Interest</option>
                            <option value="24">24 Months - 18% Interest</option>
                            
                        </select>
                        <p><strong>Approximate EMI:</strong> ₹<span id="emiAmount">0</span>/month</p>
                    </div>

                    

                    <button type="submit" class="btn btn-custom mt-3">Confirm Booking</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>

<script>
//Function to display the appropriate payment section
function showPaymentDetails(method) {
    // Hide all payment sections initially
    document.getElementById('cardDetails').style.display = 'none';
    document.getElementById('netBankingDetails').style.display = 'none';
    document.getElementById('upiDetails').style.display = 'none';
    document.getElementById('emiDetails').style.display = 'none';

    // Display the selected payment section
    if (method === 'card') {
        document.getElementById('cardDetails').style.display = 'block';
    } else if (method === 'netbanking') {
        document.getElementById('netBankingDetails').style.display = 'block';
    } else if (method === 'upi') {
        document.getElementById('upiDetails').style.display = 'block';
    } else if (method === 'emi') {
        document.getElementById('emiDetails').style.display = 'block';
    }
}

// Function to calculate EMI
function calculateEMI() {
    const carPrice = parseFloat(document.querySelector('input[name="price"]').value) || 0;
    const downPayment = parseFloat(document.querySelector('input[name="down_payment"]').value) || 0;
    const emiPlan = parseInt(document.querySelector('select[name="emi_plan"]').value) || 1;

    // Validate down payment
    if (downPayment >= carPrice) {
        document.getElementById('emiAmount').innerText = "0";
        alert("Down payment cannot be equal to or greater than the car price.");
        return;
    }

    const loanAmount = carPrice - downPayment;
    
    // EMI interest rates based on duration
    let interestRate = 0.05; // Default for 3 months
    if (emiPlan === 6) {
        interestRate = 0.1;
    } else if (emiPlan === 12) {
        interestRate = 0.12;
    } else if (emiPlan === 24) {
        interestRate = 0.18;
    }

    // Calculate EMI using the formula: EMI = [P × r × (1 + r)^n] / [(1 + r)^n - 1]
    const monthlyInterestRate = interestRate / 12;
    const emi = (loanAmount * monthlyInterestRate * Math.pow(1 + monthlyInterestRate, emiPlan)) /
        (Math.pow(1 + monthlyInterestRate, emiPlan) - 1);

    document.getElementById('emiAmount').innerText = emi.toFixed(2);
}

// Add event listener for EMI calculation
document.addEventListener('DOMContentLoaded', () => {
    const downPaymentInput = document.querySelector('input[name="down_payment"]');
    const emiPlanSelect = document.querySelector('select[name="emi_plan"]');

    // Trigger EMI calculation on input change
    if (downPaymentInput && emiPlanSelect) {
        downPaymentInput.addEventListener('input', calculateEMI);
        emiPlanSelect.addEventListener('change', calculateEMI);
    }
});

</script>

</html>
