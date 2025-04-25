<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <title> Responsive Admin Dashboard</title>
  <link rel="stylesheet" href="dashboardstyle.css">
  <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    /* Add these styles to your dashboardstyle.css */
    .content-loader {
      text-align: center;
      padding: 50px;
    }
    .loading-spinner {
      border: 5px solid #f3f3f3;
      border-top: 5px solid #3498db;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      animation: spin 1s linear infinite;
      margin: 0 auto 20px;
    }
    @keyframes spin 
      { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    
    .error-message {
      text-align: center;
      padding: 30px;
      background: #ffebee;
      border-radius: 8px;
      margin: 20px;
    }
  </style>
</head>
<body>
<div class="sidebar">
  <div class="logo-details">
    <i class='bx bxl-c-plus-plus'></i>
    <span class="logo_name">Body Master</span>
  </div>
  <ul class="nav-links">
    <li>
      <a href="#" class="active" onclick="loadContent('adminDashboard.jsp')">
        <i class='bx bx-grid-alt'></i>
        <span class="links_name">Dashboard</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('Member.jsp')">
        <i class='bx bx-box'></i>
        <span class="links_name">Members</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('Orders.jsp')">
        <i class='bx bx-list-ul'></i>
        <span class="links_name">Order list</span>
      </a>
    </li>
    <!-- Other menu items remain the same -->
  </ul>
</div>

<section class="home-section">
  <nav>
    <!-- Your existing nav bar remains unchanged -->
  </nav>
  
  <!-- This div will contain either dashboard content or loaded pages -->
  <div id="main-content-container">
    <!-- Default dashboard content -->
    <div class="home-content" id="dashboard-content">
      <div class="overview-boxes">
        <!-- Your existing dashboard boxes -->
      </div>
      <div class="sales-boxes">
        <!-- Your existing Recent Sales and Top Selling Products -->
      </div>
    </div>
  </div>
</section>

<script>
// Store original dashboard content
const originalDashboardContent = document.getElementById('dashboard-content').innerHTML;
const mainContainer = document.getElementById('main-content-container');

function loadDashboardContent() {
  // Restore original dashboard content
  mainContainer.innerHTML = '';
  const dashboardDiv = document.createElement('div');
  dashboardDiv.className = 'home-content';
  dashboardDiv.id = 'dashboard-content';
  dashboardDiv.innerHTML = originalDashboardContent;
  mainContainer.appendChild(dashboardDiv);
  
  // Update active menu item
  setActiveMenuItem('Dashboard');
}

function loadContent(pageUrl) {
  // Show loading state
  mainContainer.innerHTML = `
    <div class="content-loader">
      <div class="loading-spinner"></div>
      <p>Loading page...</p>
    </div>
  `;
  
  // Fetch the page content
  fetch(pageUrl)
    .then(response => {
      if (!response.ok) throw new Error('Network response was not ok');
      return response.text();
    })
    .then(html => {
      // Create a temporary container to parse the HTML
      const tempDiv = document.createElement('div');
      tempDiv.innerHTML = html;
      
      // Extract the main content (assuming your JSPs have a div with class 'page-content')
      const pageContent = tempDiv.querySelector('.page-content') || tempDiv;
      
      // Create new content container
      const contentDiv = document.createElement('div');
      contentDiv.className = 'home-content';
      contentDiv.innerHTML = pageContent.innerHTML;
      
      // Replace loading indicator with the new content
      mainContainer.innerHTML = '';
      mainContainer.appendChild(contentDiv);
      
      // Update active menu item based on the loaded page
      setActiveMenuItem(pageUrl.replace('.jsp', ''));
    })
    .catch(error => {
      mainContainer.innerHTML = `
        <div class="error-message">
          <h3>Error Loading Content</h3>
          <p>${error.message}</p>
          <button onclick="loadDashboardContent()">Return to Dashboard</button>
        </div>
      `;
    });
}

function setActiveMenuItem(pageName) {
  // Remove active class from all menu items
  document.querySelectorAll('.nav-links li a').forEach(item => {
    item.classList.remove('active');
  });
  
  // Find and activate the current menu item
  const menuItems = document.querySelectorAll('.nav-links li a');
  for (let item of menuItems) {
    if (item.textContent.includes(pageName) || 
        (pageName === 'Dashboard' && item.textContent.includes('Dashboard'))) {
      item.classList.add('active');
      break;
    }
  }
}

// Initialize dashboard
document.addEventListener('DOMContentLoaded', function() {
  // Set click handlers for all nav links
  document.querySelectorAll('.nav-links li a').forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
    });
  });
});
</script>
</body>
</html>