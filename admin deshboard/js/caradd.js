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
  });document.addEventListener("DOMContentLoaded", function () {

    // Form Validation
    document.querySelector("form").addEventListener("submit", function (event) {
        const carName = document.getElementById("carName").value.trim();
        const carPrice = document.getElementById("carPrice").value.trim();
        const carYear = document.getElementById("carYear").value.trim();
        const carImage = document.getElementById("carImage").files.length;

        if (carName === "" || carPrice === "" || carYear === "" || carImage === 0) {
            alert("All fields are required!");
            event.preventDefault();
        } else if (isNaN(carPrice) || carPrice <= 0) {
            alert("Please enter a valid price.");
            event.preventDefault();
        } else if (carYear.length !== 4 || isNaN(carYear) || carYear < 1990 || carYear > new Date().getFullYear()) {
            alert("Please enter a valid manufacturing year.");
            event.preventDefault();
        }
    });

});
