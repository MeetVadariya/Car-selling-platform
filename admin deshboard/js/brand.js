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
  
  