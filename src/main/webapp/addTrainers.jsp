<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gymdesk - Member Registration</title>
    <style>
        :root {
            --primary: #3498db;
            --success: #2ecc71;
            --error: #e74c3c;
            --gray: #f8f9fa;
            --white: #ffffff;
            --border: #ddd;
        }
        #body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: var(--gray);
            margin: 0;
            padding: 2rem;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: var(--white);
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .message {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 4px;
            display: none;
        }
        .success { background: #e8f8f5; color: var(--success); border: 1px solid var(--success); }
        .error { background: #fdedec; color: var(--error); border: 1px solid var(--error); }
        .form-group { margin-bottom: 1.25rem; }
        label { display: block; margin-bottom: 0.5rem; font-weight: 500; }
        input, select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border);
            border-radius: 4px;
            font-size: 1rem;
        }
        button {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            width: 100%;
            margin-top: 1.5rem;
        }
        button:hover { background: #2980b9; }
        .required::after { content: " *"; color: var(--error); }
    </style>
</head>
<body id="body">
    <div class="container">
        <h1>Member Registration</h1>
        <div id="message" class="message"></div>
        
        <form id="memberForm" action="Members_reg" method="POST">
            <div class="form-group">
                <label for="name" class="required">Full Name</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="phone" class="required">Phone Number</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email">
            </div>
                        <div class="form-group">
                <label for="email">Training type</label>
                <input type="email" id="email" name="email">
            </div>
            
            <div class="form-group">
                <label for="membership_start_date">Registration date </label>
                <input type="date" id="membership_start_date" name="membership_start_date">
            </div>
            
            <button type="submit">Register Trainer</button>
        </form>
    </div>

</body>
</html>