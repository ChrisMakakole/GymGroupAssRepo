<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gymdesk - Members</title>
    <style>
        :root {
            --primary-color: #3498db;
            --dark-color: #2c3e50;
            --darker-color: #34495e;
            --light-gray: #f8f9fa;
            --medium-gray: #7f8c8d;
            --border-gray: #ddd;
        }
        
        * {
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-gray);
            margin: 0;
            padding: 0;
            color: #333;
            line-height: 1.5;
        }
        
        .container {
            padding: 15px;
            max-width: 1400px;
            margin: 0 auto;
        }
        
        /* Top Navigation */
        .top-nav {
            display: flex;
            background-color: var(--dark-color);
            border-radius: 8px;
            margin-bottom: 20px;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            scrollbar-width: none;
        }
        
        .top-nav::-webkit-scrollbar {
            display: none;
        }
        
        .nav-item {
            padding: 12px 15px;
            color: white;
            cursor: pointer;
            text-align: center;
            white-space: nowrap;
            flex-shrink: 0;
        }
        
        .nav-item.active {
            background-color: var(--darker-color);
            border-bottom: 3px solid var(--primary-color);
        }
        
        /* Header */
        .header {
            margin-bottom: 20px;
        }
        
        .page-title {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
        }
        
        .member-name {
            font-size: 16px;
            color: var(--medium-gray);
            margin: 5px 0 0 0;
        }
        
        /* Search and Action Buttons */
        .search-bar {
            display: flex;
            margin-bottom: 15px;
        }
        
        .search-input {
            flex: 1;
            padding: 10px 15px;
            border: 1px solid var(--border-gray);
            border-radius: 4px;
            font-size: 14px;
            min-width: 0;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 8px 12px;
            border-radius: 4px;
            border: 1px solid var(--border-gray);
            background-color: white;
            cursor: pointer;
            font-size: 14px;
            white-space: nowrap;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            border: none;
        }
        
        /* Members Container */
        .members-container {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .members-header {
            margin-bottom: 20px;
        }
        
        .members-title {
            font-size: 18px;
            font-weight: 500;
            margin: 0;
        }
        
        /* Help Card */
        .help-card {
            background-color: var(--light-gray);
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
            border-left: 4px solid var(--primary-color);
        }
        
        .help-title {
            font-weight: 500;
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 18px;
        }
        
        .help-options {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 15px;
        }
        
        @media (min-width: 768px) {
            .help-options {
                flex-direction: row;
            }
        }
        
        .help-option {
            flex: 1;
            min-width: 0;
        }
        
        .help-option-title {
            font-weight: 500;
            margin-bottom: 5px;
        }
        
        .help-option-desc {
            color: var(--medium-gray);
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        /* Responsive adjustments */
        @media (max-width: 600px) {
            .container {
                padding: 10px;
            }
            
            .nav-item {
                padding: 10px 12px;
                font-size: 14px;
            }
            
            .page-title {
                font-size: 20px;
            }
            
            .member-name {
                font-size: 14px;
            }
            
            .action-buttons .btn {
                flex: 1 0 calc(50% - 5px);
                padding: 8px 5px;
                font-size: 13px;
            }
            
            .members-container {
                padding: 15px;
            }
            
            .help-card {
                padding: 15px;
            }
        }
        
        @media (max-width: 400px) {
            .action-buttons .btn {
                flex: 1 0 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Top Navigation -->
        <div class="top-nav">
            <div class="nav-item active">Members</div>
            <div class="nav-item">Check-In</div>
            <div class="nav-item">Attendance</div>
            <div class="nav-item">Memberships</div>
            <div class="nav-item">Rosters</div>
            <div class="nav-item">Documents</div>
            <div class="nav-item">Content</div>
            <div class="nav-item">Growth</div>
            <div class="nav-item">Settings</div>
        </div>
        
        <!-- Header with Member Name -->
        <div class="header">
            <div>
                <h1 class="page-title">Members</h1>
                <p class="member-name">Monabeng Phakoana</p>
            </div>
        </div>
        
        <!-- Search and Action Buttons -->
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Search first or last name...">
        </div>
        
        <div class="action-buttons">
            <button class="btn">FILTER</button>
            <button class="btn">ADD MEMBER</button>
            <button class="btn">INVITE</button>
            <button class="btn">PRINT</button>
            <button class="btn">EXPORT</button>
        </div>
        
        <!-- Members Container -->
        <div class="members-container">
            <div class="members-header">
                <h2 class="members-title">Members</h2>
            </div>
            
            <!-- Help Card -->
            <div class="help-card">
                <h3 class="help-title">How To Add Members</h3>
                <p>You can add members in a couple of different ways:</p>
                
                <div class="help-options">
                    <div class="help-option">
                        <div class="help-option-title">Enter member information through your account</div>
                        <div class="help-option-desc">Have them fill out their information at your front desk</div>
                        <button class="btn btn-primary">ADD A MEMBER</button>
                    </div>
                    
                    <div class="help-option">
                        <div class="help-option-title">Import existing members using a spreadsheet file</div>
                        <div class="help-option-desc">Invite members via Email to sign-up online</div>
                        <button class="btn btn-primary">LEARN MORE</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>