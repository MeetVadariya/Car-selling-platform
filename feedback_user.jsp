<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Submit Feedback</title>
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
            width: 60%;
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

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            font-weight: bold;
        }

        input, textarea, select {
            margin-bottom: 15px;
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #218838;
        }

        /* Star Rating Styling */
        .stars {
            display: flex;
            justify-content: center;
            margin-bottom: 15px;
        }

        .star {
            font-size: 40px;
            color: #ccc;
            cursor: pointer;
            transition: color 0.3s;
        }

        .star:hover, .star.selected {
            color: #f39c12;
        }
    </style>
    <script>
        // JavaScript for Star Rating
        function selectRating(stars) {
            const allStars = document.querySelectorAll('.star');
            allStars.forEach((star, index) => {
                if (index < stars) {
                    star.classList.add('selected');
                } else {
                    star.classList.remove('selected');
                }
            });

            // Set the hidden input value
            document.getElementById('rating').value = stars;
        }
    </script>
</head>
<body>

<div class="container">
    <h2>Submit Your Feedback</h2>

    <form action="SaveFeedback.jsp" method="POST">

        <label for="customer_name">Your Name:</label>
        <input type="text" id="customer_name" name="customer_name" required>

        <label for="customer_email">Your Email:</label>
        <input type="email" id="customer_email" name="customer_email" required>

        <label>Rating:</label>
        <div class="stars">
            <span class="star" onclick="selectRating(1)">★</span>
            <span class="star" onclick="selectRating(2)">★</span>
            <span class="star" onclick="selectRating(3)">★</span>
            <span class="star" onclick="selectRating(4)">★</span>
            <span class="star" onclick="selectRating(5)">★</span>
        </div>
        
        <!-- Hidden input to store the rating -->
        <input type="hidden" id="rating" name="rating" value="0" required>

        <label for="message">Your Feedback:</label>
        <textarea id="message" name="message" rows="5" required></textarea>

        <button type="submit">Submit Feedback</button>
    </form>
</div>

</body>
</html>
