// Sidebar Toggle Functionality
document.getElementById("toggle-sidebar").addEventListener("click", () => {
    const sidebar = document.getElementById("sidebar");
    const mainContent = document.querySelector(".main-content");

    sidebar.classList.toggle("hidden");
    mainContent.classList.toggle("expanded");

    if (sidebar.classList.contains("hidden")) {
        mainContent.style.width = "100%";
    } else {
        mainContent.style.width = "calc(100% - 250px)";
    }
});

// Confirm Car Deletion
function confirmDelete(carId) {
    if (confirm("Are you sure you want to delete this car?")) {
        deleteCar(carId);
    }
}

// Delete Car Function (AJAX Request)
function deleteCar(carId) {
    fetch(`deleteCar.jsp?id=${carId}`, {
        method: "GET",
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Failed to delete car");
        }
        return response.text();
    })
    .then(data => {
        // Remove car row from the table
        const carRow = document.querySelector(`tr[data-id='${carId}']`);
        if (carRow) {
            carRow.remove();
        }

        // Show success notification
        showNotification("Car deleted successfully.");
    })
    .catch(error => {
        console.error("Error deleting car:", error);
        showNotification("Error deleting car. Please try again.", "error");
    });
}

// Show Notification
function showNotification(message, type = "success") {
    let notification = document.createElement("div");
    notification.classList.add("notification", type);
    notification.innerText = message;

    document.body.appendChild(notification);

    setTimeout(() => {
        notification.remove();
    }, 3000);
}

// Style for notification (optional, include in CSS if not already present)
const style = document.createElement("style");
style.innerHTML = `
    .notification {
        position: fixed;
        top: 10px;
        right: 10px;
        background: #28a745;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        transition: opacity 0.5s ease-in-out;
    }
    .notification.error {
        background: #dc3545;
    }
`;
document.head.appendChild(style);
