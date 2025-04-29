<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <title>Check-In Confirmation | Body Master</title>
  <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    /* Dashboard base styles */
    :root {
      --primary: #3498db;
      --success: #2ecc71;
      --error: #e74c3c;
      --sidebar: #2c3e50;
      --sidebar-hover: #34495e;
      --text-light: #ecf0f1;
      --text-dark: #2c3e50;
      --bg-light: #f5f5f5;
      --white: #ffffff;
    }
    
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
      min-height: 100vh;
      background-color: var(--bg-light);
    }
    
    /* Sidebar styles - Updated with better spacing */
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
      color: var(--white);
      padding-left: 15px; /* Added padding */
    }
    
    .logo-details i {
      font-size: 28px;
      margin-right: 5px;
    }
    
    .logo_name {
      font-size: 20px;
      font-weight: 600;
    }
    
    .nav-links {
      margin-top: 20px;
      height: calc(100% - 60px);
      overflow-y: auto;
      padding-left: 15px; /* Added padding */
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
      color: var(--text-light);
      padding: 12px 15px; /* Increased padding */
      border-radius: 5px;
      transition: all 0.4s ease;
    }
    
    .nav-links li a:hover,
    .nav-links li a.active {
      background: var(--sidebar-hover);
    }
    
    .nav-links li i {
      font-size: 18px;
      margin-right: 15px; /* Increased spacing */
    }
    
    .links_name {
      margin-left: 10px; /* Additional spacing */
    }

    /* Rest of your existing styles remain unchanged */
    /* Top Navigation Bar */
    .top-nav {
      position: fixed;
      top: 0;
      left: 240px;
      width: calc(100% - 250px);
      height: 76px;
      background: var(--white);
      box-shadow: 0 1px 5px rgba(0,0,0,0.1);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 20px;
      z-index: 99;
    }
    
    .top-nav-title {
      font-size: 20px;
      font-weight: 600;
      color: var(--text-dark);
    }
    
    .user-profile {
      display: flex;
      align-items: center;
    }
    
    .user-profile img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      margin-right: 10px;
    }
    
    .user-name {
      font-weight: 500;
    }
    
    /* Main content area */
    .home-section {
      position: relative;
      left: 250px;
      width: calc(100% - 250px);
      min-height: 100vh;
      transition: all 0.5s ease;
      padding-top: 80px; /* Space for top nav */
    }
    
    /* Confirmation box styles */
    .confirmation-container {
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: calc(100vh - 80px);
    }
    
    .confirmation-box {
      background-color: var(--white);
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 500px;
      padding: 30px;
      text-align: center;
    }
    
    .confirmation-icon {
      font-size: 48px;
      color: var(--success);
      margin-bottom: 20px;
    }
    
    .confirmation-title {
      color: var(--text-dark);
      margin-bottom: 20px;
      font-size: 24px;
    }
    
    .member-details {
      text-align: left;
      margin: 25px 0;
      padding: 20px;
      background-color: rgba(0,0,0,0.03);
      border-radius: 6px;
    }
    
    .member-detail {
      margin: 12px 0;
      display: flex;
    }
    
    .detail-label {
      font-weight: 600;
      min-width: 150px;
    }
    
    .status-out {
      color: var(--error);
    }
    
    .status-in {
      color: var(--success);
    }
    
    .action-buttons {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin-top: 25px;
    }
    
    .btn {
      padding: 10px 25px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 600;
      transition: all 0.2s;
    }
    
    .btn-confirm {
      background-color: var(--success);
      color: white;
    }
    
    .btn-confirm:hover {
      background-color: #27ae60;
    }
    
    .btn-cancel {
      background-color: var(--error);
      color: white;
    }
    
    .btn-cancel:hover {
      background-color: #c0392b;
    }
    
    .btn-back {
      display: inline-block;
      margin-top: 20px;
      background-color: var(--primary);
      color: white;
      text-decoration: none;
      padding: 10px 25px;
      border-radius: 4px;
    }
    
    .btn-back:hover {
      background-color: #2980b9;
    }
  </style>
  <script src="/script.js"></script>
</head>
<body>
  <!-- Sidebar Navigation - Updated with proper structure -->
  <div class="sidebar">
    <div class="logo-details">
      <i class='bx bxs-dumbbell'></i> <!-- Added icon -->
      <span class="logo_name">Body Master</span>
    </div>
    <ul class="nav-links">
      <li>
        <a href="index.jsp" >
          <i class='bx bx-grid-alt'></i>
          <span class="links_name">Dashboard</span>
        </a>
      </li>
      <li>
        <a href="index.jsp">
          <i class='bx bx-user'></i>
          <span class="links_name">Members</span>
        </a>
      </li>
      <li>
        <a href="index.jsp">
          <i class='bx bx-user-plus'></i>
          <span class="links_name">Add Trainers</span>
        </a>
      </li>
      <li>
        <a href="index.jsp">
          <i class='bx bx-calendar-check' class="active"></i>
          <span class="links_name">Attendance</span>
        </a>
      </li>
      <li>
        <a href="index.jsp">
          <i class='bx bx-list-ul'></i>
          <span class="links_name">View Trainers</span>
        </a>
      </li>
    </ul>
  </div>

  <!-- Top Navigation Bar -->
  <div class="top-nav">
    
    </div>
  </div>

  <!-- Main Content Area -->
  <section class="home-section">
    <div class="confirmation-container">
      <div class="confirmation-box">
        <div class="confirmation-icon">✓</div>
        <h1 class="confirmation-title">Check-out Confirmation</h1>
        
        <div class="member-details">
          <div class="member-detail">
            <span class="detail-label">Name:</span>
            <span>${not empty param.name ? param.name : 'N/A'}</span>
          </div>
          <div class="member-detail">
            <span class="detail-label">Phone:</span>
            <span>${not empty param.phone ? param.phone : 'N/A'}</span>
          </div>
          <div class="member-detail">
            <span class="detail-label">Membership Start:</span>
            <span>${not empty param.startDate ? param.startDate : 'N/A'}</span>
          </div>
          <div class="member-detail">
            <span class="detail-label">Membership End:</span>
            <span>${not empty param.endDate ? param.endDate : 'N/A'}</span>
          </div>
         
        </div>
        
        <p>Are you sure you want to check out this member?</p>
        
        <div class="action-buttons">
          <form action="CheckOutServlet" method="post">
            <input type="hidden" name="phone" value="${param.phone}">
            <input type="hidden" name="name" value="${param.name}">
            <button type="submit" class="btn btn-confirm">Confirm Check-Out</button>
          </form>
          <a href="index.jsp" class="btn btn-cancel">Cancel</a>
        </div>
        
        <a href="index.jsp" class="btn-back">Back to Member List</a>
      </div>
    </div>
  </section>
</body>
</html>