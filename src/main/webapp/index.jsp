<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gymdesk - Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            color: #333;
        }
        
        .container {
            display: flex;
            min-height: 100vh;
        }
        
        .left-panel {
            width: 40%;
            background-color: #ffffff;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .right-panel {
            width: 60%;
            background-color: #f5f7fa;
            padding: 40px;
            display: flex;
            flex-direction: column;
        }
        
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 40px;
        }
        
        h1 {
            font-size: 28px;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        h2 {
            font-size: 18px;
            color: #7f8c8d;
            margin-bottom: 30px;
            font-weight: normal;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        
        .btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            width: 100%;
            margin-top: 10px;
        }
        
        .btn:hover {
            background-color: #2980b9;
        }
        
        .forgot-password {
            text-align: right;
            margin-top: 10px;
        }
        
        .forgot-password a {
            color: #7f8c8d;
            text-decoration: none;
        }
        
        .dashboard-section {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .dashboard-section h3 {
            margin-top: 0;
            color: #2c3e50;
        }
        
        .dashboard-section p {
            color: #7f8c8d;
            margin-bottom: 0;
        }
        
        .resource-links {
            list-style-type: none;
            padding: 0;
        }
        
        .resource-links li {
            margin-bottom: 10px;
        }
        
        .resource-links a {
            color: #3498db;
            text-decoration: none;
        }
        
        .divider {
            border-top: 1px solid #eee;
            margin: 30px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left-panel">
            <div class="logo">Gymdesk</div>
            <h1>Welcome back!</h1>
            <h2>Sign in to your Gymdesk account</h2>
            
            <form action="login" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="text" id="email" name="email" placeholder="Enter your email">
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password">
                </div>
                
                <div class="forgot-password">
                    <a href="#">Forgot password?</a>
                </div>
                
                <button type="submit" class="btn">Sign In</button>
            </form>
        </div>
        
        <div class="right-panel">
            <h1>Dashboard</h1>
            <h2>Monitoring Phakosana</h2>
            
            <div class="dashboard-section">
                <h3>Welcome to Gymdesk!</h3>
                <p>Let's get your account set up</p>
            </div>
            
            <div class="divider"></div>
            
            <div class="dashboard-section">
                <h3>Memberships and gym access</h3>
                <p>Set up your gym programs and memberships.</p>
            </div>
            
            <div class="dashboard-section">
                <h3>Marketing and lead generation</h3>
                <p>Set up lead capture forms, referral programs and marketing automations.</p>
            </div>
            
            <div class="dashboard-section">
                <h3>Resource Links</h3>
                <ul class="resource-links">
                    <li><a href="#">Getting Started Guide</a></li>
                    <li><a href="#">Video Tutorial Library</a></li>
                </ul>
            </div>
            
            <div class="dashboard-section">
                <h3>Add or import member data</h3>
                <p>Import member data and set up the sign-up flow.</p>
            </div>
        </div>
    </div>
</body>
</html>