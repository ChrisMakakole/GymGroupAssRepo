<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html id="gymdesk-root">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gymdesk - Staff Management</title>
    <style>
        #gymdesk-root {
            --gymdesk-primary: #3498db;
            --gymdesk-dark: #2c3e50;
            --gymdesk-border: #e0e0e0;
            --gymdesk-light-gray: #f8f9fa;
            --gymdesk-text-gray: #7f8c8d;
            --gymdesk-white: #ffffff;
        }
        
        #gymdesk-body {
            background-color: var(--gymdesk-light-gray);
            color: #333;
            line-height: 1.5;
            padding: 20px;
        }
        
        .gymdesk-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .gymdesk-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .gymdesk-gym-info {
            display: flex;
            flex-direction: column;
        }
        
        .gymdesk-gym-name {
            font-size: 14px;
            color: var(--gymdesk-text-gray);
            margin-bottom: 5px;
        }
        
        .gymdesk-user-name {
            font-size: 18px;
            font-weight: 500;
        }
        
        .gymdesk-top-nav {
            display: flex;
            background-color: var(--gymdesk-white);
            border-radius: 6px;
            margin-bottom: 25px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .gymdesk-nav-section {
            padding: 12px 20px;
            background-color: var(--gymdesk-light-gray);
            font-weight: 500;
            color: var(--gymdesk-text-gray);
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }
        
        .gymdesk-nav-menu {
            display: flex;
            list-style: none;
            flex: 1;
        }
        
        .gymdesk-nav-item {
            padding: 12px 20px;
            cursor: pointer;
            text-align: center;
            border-bottom: 3px solid transparent;
            font-size: 14px;
            white-space: nowrap;
        }
        
        .gymdesk-nav-item.active {
            border-bottom: 3px solid var(--gymdesk-primary);
            font-weight: 500;
            color: var(--gymdesk-dark);
        }
        
        .gymdesk-content-card {
            background-color: var(--gymdesk-white);
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .gymdesk-page-title {
            font-size: 20px;
            font-weight: 500;
            margin-bottom: 25px;
            color: var(--gymdesk-dark);
        }
        
        .gymdesk-staff-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .gymdesk-staff-table th {
            text-align: left;
            padding: 12px 15px;
            background-color: var(--gymdesk-light-gray);
            font-weight: 500;
            color: var(--gymdesk-text-gray);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--gymdesk-border);
        }
        
        .gymdesk-staff-table td {
            padding: 15px;
            border-bottom: 1px solid var(--gymdesk-border);
            vertical-align: top;
        }
        
        .gymdesk-staff-info {
            display: flex;
            flex-direction: column;
        }
        
        .gymdesk-staff-name {
            font-weight: 500;
            margin-bottom: 3px;
        }
        
        .gymdesk-staff-email {
            color: var(--gymdesk-text-gray);
            font-size: 13px;
        }
        
        .gymdesk-staff-role {
            font-weight: 500;
            font-size: 14px;
        }
        
        .gymdesk-staff-permissions {
            color: var(--gymdesk-primary);
            font-weight: 500;
            font-size: 14px;
        }
        
        .gymdesk-staff-date {
            color: var(--gymdesk-text-gray);
            font-size: 13px;
        }
        
        .gymdesk-action-btn {
            color: var(--gymdesk-primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .gymdesk-action-btn i {
            font-size: 16px;
        }
        
        .gymdesk-add-staff-btn {
            background-color: var(--gymdesk-primary);
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin-top: 20px;
            font-size: 14px;
        }
        
        .gymdesk-add-staff-btn::before {
            content: "+";
            font-size: 18px;
        }
        
        .gymdesk-divider {
            border-top: 1px solid var(--gymdesk-border);
            margin: 20px 0;
        }
        
        @media (max-width: 768px) {
            .gymdesk-top-nav {
                flex-direction: column;
            }
            
            .gymdesk-nav-menu {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }
            
            .gymdesk-nav-item {
                flex-shrink: 0;
            }
            
            .gymdesk-staff-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body id="gymdesk-body">
    <div class="gymdesk-container">
        <!-- Header with Gym and User Info -->
        <div class="gymdesk-header">
            <div class="gymdesk-gym-info">
                <div class="gymdesk-gym-name">Gym</div>
                <div class="gymdesk-user-name">Monaheng Phakoana</div>
            </div>
        </div>
        
        <!-- Top Navigation -->
        <div class="gymdesk-top-nav">
            <div class="gymdesk-nav-section">MANAGERS & STAFF</div>
            <ul class="gymdesk-nav-menu">
                <li class="gymdesk-nav-item">Payroll</li>
                <li class="gymdesk-nav-item">Schedule</li>
                <li class="gymdesk-nav-item">Bookings</li>
                <li class="gymdesk-nav-item">Programs</li>
                <li class="gymdesk-nav-item active">Gym Staff</li>
            </ul>
        </div>
        
        <!-- Main Content Area -->
        <div class="gymdesk-content-card">
            <h1 class="gymdesk-page-title">Gym Staff</h1>
            
            <table class="gymdesk-staff-table">
                <thead>
                    <tr>
                        <th>NAME</th>
                        <th>ROLE</th>
                        <th>PERMISSIONS</th>
                        <th>LEARN MORE</th>
                        <th>ADDED</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="gymdesk-staff-info">
                                <div class="gymdesk-staff-name">Monaheng Phakoana</div>
                                <div class="gymdesk-staff-email">monahengphakoana692@gmail.com</div>
                            </div>
                        </td>
                        <td class="gymdesk-staff-role">Owner</td>
                        <td class="gymdesk-staff-permissions">All</td>
                        <td>
                            <a href="#" class="gymdesk-action-btn">
                                <i class="fas fa-pen"></i> EDIT
                            </a>
                        </td>
                        <td class="gymdesk-staff-date">Apr 24, 2025</td>
                    </tr>
                </tbody>
            </table>
            
            <div class="gymdesk-divider"></div>
            
            <button class="gymdesk-add-staff-btn">ADD STAFF MEMBER</button>
        </div>
    </div>
</body>
</html>