<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gymdesk - Visitor/Member Sign-up</title>
    <style>
        :root {
            --primary-color: #3498db;
            --border-color: #ddd;
            --required-color: #e74c3c;
            --section-border: #eee;
        }
        
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            color: #333;
            line-height: 1.5;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            font-size: 24px;
            margin-top: 0;
            color: #2c3e50;
        }
        
        h2 {
            font-size: 18px;
            margin: 25px 0 15px 0;
            color: #2c3e50;
        }
        
        .required-label {
            font-size: 14px;
            color: var(--required-color);
            margin-bottom: 15px;
            display: block;
        }
        
        .radio-group {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }
        
        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            font-size: 14px;
        }
        
        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 14px;
        }
        
        .add-option {
            color: var(--primary-color);
            font-size: 14px;
            margin-top: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .add-option::before {
            content: "+";
            font-weight: bold;
        }
        
        .check-in-code {
            font-size: 18px;
            font-weight: 500;
            margin-top: 10px;
        }
        
        .divider {
            border-top: 1px solid var(--section-border);
            margin: 30px 0;
        }
        
        .address-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .address-grid-2col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        @media (max-width: 600px) {
            .address-grid, .address-grid-2col {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Visitor / Member Sign-up</h1>
        
        <h2>Member Details</h2>
        <span class="required-label">Required field</span>
        
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
            <label for="firstName">FIRST NAME</label>
            <input type="text" id="firstName" placeholder="First name">
        </div>
        
        <div class="form-group">
            <label for="phone">PHONE NUMBER</label>
            <input type="tel" id="phone" placeholder="Phone number">
            <span class="add-option">ADD SECONDARY PHONE</span>
        </div>
        
        <div class="form-group">
            <label>PICK A CHECK IN CODE (4 DIGITS)</label>
            <div class="check-in-code">8757</div>
        </div>
        
        <div class="divider"></div>
        
        <div class="form-group">
            <label for="lastName">LAST NAME</label>
            <input type="text" id="lastName" placeholder="Last name">
        </div>
        
        <div class="form-group">
            <label for="email">EMAIL ADDRESS</label>
            <input type="email" id="email" placeholder="my@email.com">
            <span class="add-option">ADD SECONDARY EMAIL</span>
        </div>
        
        <div class="form-group">
            <label for="joinDate">JOIN DATE</label>
            <input type="text" id="joinDate" placeholder="04/25/2025">
        </div>
        
        <div class="divider"></div>
        
        <div class="form-group">
            <label for="gender">GENDER</label>
            <input type="text" id="gender" placeholder="--">
        </div>
        
        <div class="form-group">
            <label for="dob">DATE OF BIRTH</label>
            <input type="text" id="dob" placeholder="mm/dd/yyyy">
        </div>
        
        <div class="divider"></div>
        
        <h2>Address</h2>
        
        <div class="address-grid">
            <div class="form-group">
                <label for="street">STREET ADDRESS</label>
                <input type="text" id="street" placeholder="Street Address">
            </div>
            
            <div class="form-group">
                <label for="city">CITY</label>
                <input type="text" id="city" placeholder="City">
            </div>
            
            <div class="form-group">
                <label for="zip">ZIP / POSTAL CODE</label>
                <input type="text" id="zip" placeholder="*******">
            </div>
        </div>
        
        <div class="address-grid-2col">
            <div class="form-group">
                <label for="state">STATE</label>
                <input type="text" id="state" placeholder="State">
            </div>
            
            <div class="form-group">
                <label for="country">COUNTRY</label>
                <input type="text" id="country" placeholder="Lesotho">
            </div>
        </div>
    </div>
</body>
</html>