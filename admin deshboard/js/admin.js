
// Sidebar Toggle
document.getElementById('toggle-sidebar').addEventListener('click', () => {
  const sidebar = document.getElementById('sidebar');
  const mainContent = document.querySelector('.main-content');

  sidebar.classList.toggle('hidden');
  mainContent.classList.toggle('expanded');

  if (sidebar.classList.contains('hidden')) {
    mainContent.style.width = "100%";
  } else {
    mainContent.style.width = "calc(100% - 250px)"; // Adjust width dynamically
  }
});

// Dynamic Data for Cards
const dashboardData = {
  totalUsers: 1000,
  activeListings: 420,
  transactions: 890,
  revenue: 10000
};

// Update Cards
document.getElementById('total-users').querySelector('p').textContent = dashboardData.totalUsers;
document.getElementById('active-listings').querySelector('p').textContent = dashboardData.activeListings;
document.getElementById('transactions').querySelector('p').textContent = dashboardData.transactions;
document.getElementById('revenue').querySelector('p').textContent = `$${dashboardData.revenue.toLocaleString()}`;

// Dynamic Data for Table
const carListings = [
  { id: 1, name: 'Toyota Corolla', seller: 'John', price: '500,000', status: 'Approved' },
  { id: 2, name: 'Honda Civic', seller: 'Smith', price: '400,000', status: 'Pending' },
  { id: 3, name: 'Ford Mustang', seller: 'Meet', price: '700,000', status: 'Sold' }
];

const tableBody = document.getElementById('listing-table');
carListings.forEach(listing => {
  const row = document.createElement('tr');
  row.innerHTML = `
    <td>${listing.id}</td>
    <td>${listing.name}</td>
    <td>${listing.seller}</td>
    <td>${listing.price}</td>
    <td>${listing.status}</td>
    <td><button class="delete-btn" data-id="${listing.id}">Delete</button></td>
  `;
  tableBody.appendChild(row);
});

// Delete Button Functionality
document.querySelectorAll('.delete-btn').forEach(button => {
  button.addEventListener('click', (event) => {
    event.target.closest('tr').remove();
  });
});

// Chart.js for Sales Analytics
const ctx = document.getElementById('salesChart').getContext('2d');
new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    datasets: [{
      label: 'Sales ($)',
      data: [1200, 1900, 3000, 5000, 2500, 4000, 3500, 4500, 5200, 6100, 7200, 8000],
      backgroundColor: 'rgba(46, 204, 113, 0.6)',
      borderColor: 'rgba(46, 204, 113, 1)',
      borderWidth: 1
    }]
  },
  options: {
    responsive: true,
    scales: {
      y: { beginAtZero: true }
    }
  }
});

// Notifications Section
const notifications = [
  'New user registered!',
  'New car listing added.',
  'Payment received from John Doe.',
  'Car listing ID 3 was sold.',
  'Scheduled maintenance reminder.',
  'Price drop alert on Ford Mustang.',
  'Admin login from new device.'
];

const notificationList = document.getElementById('notification-list');
notifications.forEach(notification => {
  const li = document.createElement('li');
  li.textContent = notification;
  notificationList.appendChild(li);
});
