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
    
    
    .error-message {
      text-align: center;
      padding: 90px;
      background: #ffebee;
      border-radius: 8px;
      margin: 20px;
      margin-bottom: -100px;
    }

    /* Modified sidebar styles */
    .sidebar {
      position: fixed;
      height: 100%;
      width: 240px;
      background: #0A2558;
      padding: 15px;
      z-index: 100;
      transition: all 0.5s ease;
    }
    
    .logo-details {
      height: 60px;
      display: flex;
      align-items: center;
      color: white;
      padding-left: 15px; /* Added padding */
    }
    
    .nav-links {
      margin-top: 20px;
      padding-left: 15px; /* Added padding to move items right */
    }
    
    .nav-links li {
      position: relative;
      list-style: none;
      margin-bottom: 5px;
    }
    
    .nav-links li a {
      display: flex;
      align-items: center;
      text-decoration: none;
      color: white;
      padding: 10px 15px;
      border-radius: 5px;
      transition: all 0.4s ease;
    }
    
    .nav-links li a:hover,
    .nav-links li a.active {
      background: #34495e;
    }
    
    .nav-links li i {
      font-size: 18px;
      margin-right: 5px; /* Increased spacing between icon and text */
    }
    
    .links_name {
      margin-left: -15px; /* Additional spacing */
    }
    
  </style>
</head>
<body>
 
<div class="sidebar">
  <div class="logo-details">
    
    <span class="logo_name">Body Master</span>
  </div>
  <ul class="nav-links">
    <li>
      <a href="#"  onclick="loadContent('adminDashboard.jsp')">
        <i class='bx bx-grid-alt'></i>
        <span class="links_name">Dashboard</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('Member.jsp')">
        <i class='bx bx-user'></i>
        <span class="links_name">Members</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('addTrainers.jsp')">
        <i class='bx bx-user-plus'></i>
        <span class="links_name">Add Trainers</span>
      </a>
    </li>
    <li>
      <a href="#" class="active" onclick="loadContent('Attendance.jsp')">
        <i class='bx bx-calendar-check'></i>
        <span class="links_name">Attendance</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('${pageContext.request.contextPath}/admin/attendance')">
        <i class='bx bx-list-ul'></i>
        <span class="links_name">view Attendance</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('ViewTrainers.jsp')">
        <i class='bx bx-list-ul'></i>
        <span class="links_name">View Trainers</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('${pageContext.request.contextPath}/admin/packages')">
        <i class='bx bx-list-ul'></i>
        <span class="links_name">Manage Packages</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('${pageContext.request.contextPath}/admin/payments')">
        <i class='bx bx-list-ul'></i>
        <span class="links_name">Manage Payments</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('${pageContext.request.contextPath}/admin/shifts')">
        <i class='bx bx-list-ul'></i>
        <span class="links_name">Manage Shifts</span>
      </a>
    </li>
    <li>
      <a href="#" onclick="loadContent('${pageContext.request.contextPath}/admin/trainer_shifts')">
        <i class='bx bx-list-ul'></i>
        <span class="links_name">Manage Trainer Shifts</span>
      </a>
    </li>
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