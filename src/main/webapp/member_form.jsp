<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gymdesk - Member Registration</title>
    <style>
        /* Your existing CSS styles here */
        :root {
            --primary-color: #3498db;
            --border-color: #ddd;
            --required-color: #e74c3c;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
        }
        
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .success {
            background-color: #e8f8f5;
            color: var(--success-color);
            border: 1px solid var(--success-color);
        }
        
        .error {
            background-color: #fdedec;
            color: var(--error-color);
            border: 1px solid var(--error-color);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Member Registration</h1>
        
        <%-- Display success/error message --%>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message ${messageType}">
                ${message}
            </div>
        <% } %>
        
        <form action="Members_reg" method="POST">
            <div class="form-group">
                <label for="name">Full Name *</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email">
            </div>
            
            <div class="form-group">
                <label for="phone">Phone Number *</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            
            <div class="radio-group">
                <div class="radio-option">
                    <input type="radio" id="visitor" name="memberType" value="visitor" checked>
                    <label for="visitor">Visitor</label>
                </div>
                <div class="radio-option">
                    <input type="radio" id="member" name="memberType" value="member">
                    <label for="member">Member</label>
                </div>
            </div>
            
            <div class="form-group">
                <label for="membership_start_date">Membership Start Date</label>
                <input type="date" id="membership_start_date" name="membership_start_date">
            </div>
            
            <div class="form-group">
                <label for="membership_end_date">Membership End Date</label>
                <input type="date" id="membership_end_date" name="membership_end_date">
            </div>
            
            <button type="submit" class="btn-submit">Register</button>
        </form>
    </div>
</body>
</html>