
# 🚗 Car Selling Website

A full-stack web application for buying and selling cars online. This platform allows users to browse cars, register/login, add cars (admin), manage bookings, and much more.

## 📌 Features

### 👨‍💻 User Panel
- User Registration & Login
- Browse cars by brand, category, fuel type, etc.
- Car Details Page with EMI Options
- Add to Wishlist / Favorites
- Book Car with Payment Options (Card, UPI, Net Banking)
- View Booking History
- User Profile & Password Change via OTP

### 🛠️ Admin Panel
- Admin Login
- Add, Edit & Delete Cars
- Manage Users
- View All Bookings
- Manage Complaints
- user and admin login this page

### 📸 Screenshot

<img width="1893" height="906" alt="image" src="https://github.com/user-attachments/assets/9aff963d-75a4-4395-afe4-28afb60f0de8" />

## 🏠 Home Page

The Home Page is the first page users see when they visit the Car Selling Website. It includes:

- A clean navigation bar with links: Home, About, Services, Cars, Client, Contact, and Register.
- Beautiful blue gradient background for a modern UI.
- Quick access to **Login** and **Register** options.
- Fully responsive and mobile-friendly design.
  
### 📸 Screenshot

<img width="1892" height="903" alt="image" src="https://github.com/user-attachments/assets/65261ee9-273f-4213-9f1b-0ec3b161f81d" />

## 🚗 Cars Page

The **Cars Page** allows users to explore all available cars in the platform. Key features include:

- Grid/List layout showing car name, price, image, and key specs.
- Filter or search cars by brand, fuel type, transmission, etc.
- Clickable cards leading to **Car Detail Page** for full specifications.
- “Add to Wishlist” and “Book Now” buttons (if implemented).
- Responsive design for all screen sizes.

### 📸 Screenshot

<img width="1896" height="903" alt="image" src="https://github.com/user-attachments/assets/d5f65f21-c038-45c9-9cc7-538afce89d4b" />

## 🧾 Booking Page

The **Booking Page** allows users to book their selected cars with full details.

### 🔹 Key Features:
- Auto-filled car information from selected car
- Booking form includes:
  - User contact details
  - Payment method (Card / UPI / Net Banking)
  - Down Payment & EMI plan selection
- Real-time validations and user-friendly design
- Saves data to the database and updates booking history

### 📸 Screenshot

<img width="1881" height="895" alt="image" src="https://github.com/user-attachments/assets/d505e2df-d01b-490d-89da-789b97e3e4c5" />



## ℹ️ About Page

The **About Page** explains the purpose of the Car Selling Website and what it offers to users and admins. It gives users a brief overview of the platform's mission, vision, and value.

### 🔹 Key Highlights:
- Introduces the platform and its goal (e.g., easy online car buying/selling).
- Describes services, values, or advantages (like trusted dealers, EMI options, etc.).
- Clean section layout with text and supporting visuals.
- May include team member info, if applicable.
- Responsive and mobile-friendly design.

### 📸 Screenshot

<img width="1893" height="814" alt="image" src="https://github.com/user-attachments/assets/a7a2fb22-e1df-4eed-b2dc-aa55aa3d87c6" />



## 👥 Client Page

The **Client Page** highlights feedback and trust from satisfied customers. It builds credibility for new users and visitors.

### 🔹 Key Highlights:
- Displays client reviews or testimonials in a visually appealing format.
- May include star ratings, client names/photos, or animations.
- Clean layout with good spacing and contrast.
- Responsive design for all screen sizes.

### 📸 Screenshot

<img width="1885" height="906" alt="image" src="https://github.com/user-attachments/assets/5caf201f-483e-4bb2-85ac-2dde557d2792" />

## 🛠️ Admin Panel

The **Admin Panel** is a secure interface for managing the platform.

### 🔹 Key Features:
- Admin login with authentication
- Add / Edit / Delete cars
- View all bookings and users
- Manage complaints and contact messages
- Full dashboard for site control

### 📸 Screenshot

<img width="1919" height="477" alt="image" src="https://github.com/user-attachments/assets/e3cd28bc-61be-4065-b7f7-b4d148d447b8" />
<img width="1884" height="883" alt="image" src="https://github.com/user-attachments/assets/e088b93d-02e2-4a56-b8ca-a09c8779db85" />







### 📦 Technologies Used
- **Frontend:** HTML, CSS, JavaScript, JSP
- **Backend:** Java (Servlets & JSP)
- **Database:** MySQL
- **Server:** Apache Tomcat
- **Tools:** Eclipse IDE, Git, GitHub

## 🧩 Folder Structure
carzone/
├── src/
│ └── main/
│ └── webapp/
│ ├── login/
│ ├── admin/
│ ├── user/
│ ├── css/
│ └── js/
├── images/
├── sql/
│ └── carzone_db.sql
└── README.md

## 🗃️ Database Tables

- `username` – Stores user/admin info
- `cars` – Stores car details
- `bookings` – Booking records
- `wishlist` – Saved cars for user
- `complaints` – User complaints

