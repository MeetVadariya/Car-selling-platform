document.addEventListener("DOMContentLoaded", function () {
    // Sidebar Toggle
    document.getElementById("toggle-sidebar").addEventListener("click", () => {
        document.getElementById("sidebar").classList.toggle("hidden");
    });

    // Search Functionality
    document.getElementById("search").addEventListener("keyup", function() {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("tbody tr");

        rows.forEach(row => {
            let category = row.cells[1].textContent.toLowerCase();
            if (category.includes(filter)) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    });

    // Delete Category
    window.deleteCategory = function(id) {
        if (confirm("Are you sure you want to delete this category?")) {
            window.location.href = "deleteCategory.jsp?id=" + id;
        }
    };

    // Edit Category
    window.editCategory = function(id) {
        let newCategory = prompt("Enter new category name:");
        if (newCategory) {
            window.location.href = "editCategory.jsp?id=" + id + "&name=" + newCategory;
        }
    };
});
