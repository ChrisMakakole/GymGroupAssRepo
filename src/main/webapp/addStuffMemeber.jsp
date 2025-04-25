<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gymdesk - Add Staff Member</title>
    <style>
        :root {
            --primary-color: #3498db;
            --border-color: #e0e0e0;
            --light-gray: #f8f9fa;
            --text-gray: #7f8c8d;
            --white: #ffffff;
        }
        
        /** {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }*/
        
        body {
            background-color: var(--light-gray);
            color: #333;
            line-height: 1.5;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .form-card {
            background-color: var(--white);
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .page-title {
            font-size: 20px;
            font-weight: 500;
            margin-bottom: 30px;
            color: #2c3e50;
        }
        
        .form-section {
            margin-bottom: 30px;
        }
        
        .section-title {
            font-weight: 500;
            margin-bottom: 15px;
            font-size: 16px;
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
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
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
        
        .submit-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            margin-top: 10px;
        }
        
        .access-section {
            margin-top: 40px;
        }
        
        .access-category {
            margin-bottom: 25px;
        }
        
        .access-category-title {
            font-weight: 500;
            margin-bottom: 15px;
            font-size: 15px;
        }
        
        .permissions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .permission-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .radio-group {
                flex-direction: column;
                gap: 10px;
            }
            
            .permissions-grid {
                grid-template-columns: 1fr 1fr;
            }
        }
        
        @media (max-width: 480px) {
            .permissions-grid {
                grid-template-columns: 1fr;
            }
            
            .form-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-card">
            <h1 class="page-title">Add Staff Member</h1>
            
            <div class="form-section">
                <div class="section-title">TYPE</div>
                <div class="radio-group">
                    <div class="radio-option">
                        <input type="radio" id="manager" name="staffType" value="manager" checked>
                        <label for="manager">Manager</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="instructor" name="staffType" value="instructor">
                        <label for="instructor">Instructor</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="frontdesk" name="staffType" value="frontdesk">
                        <label for="frontdesk">Front-Desk</label>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">NAME</label>
                        <input type="text" id="name" placeholder="Staff name">
                    </div>
                    <div class="form-group">
                        <label for="email">EMAIL</label>
                        <input type="email" id="email" placeholder="name@email.com">
                    </div>
                    <div class="form-group">
                        <label for="phone">PHONE</label>
                        <input type="tel" id="phone" placeholder="(***) *******">
                    </div>
                </div>
                
                <button type="submit" class="submit-btn">SEND INVITATION</button>
            </div>
            
            <div class="access-section">
                <h2 class="section-title">Account Access</h2>
                <p style="margin-bottom: 20px;">Access to the gym account on Gymdesk</p>
                
                <div class="access-category">
                    <h3 class="access-category-title">MEMBERS</h3>
                    <div class="permissions-grid">
                        <div class="permission-item">
                            <input type="checkbox" id="viewMembers" checked>
                            <label for="viewMembers">View Members</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="viewInvoices">
                            <label for="viewInvoices">View Invoices</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="editMembers">
                            <label for="editMembers">Edit Members</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="memberCheckin" checked>
                            <label for="memberCheckin">Member Check-in</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="memberSettings">
                            <label for="memberSettings">Member Settings</label>
                        </div>
                    </div>
                </div>
                
                <div class="access-category">
                    <h3 class="access-category-title">BILLING</h3>
                    <div class="permissions-grid">
                        <div class="permission-item">
                            <input type="checkbox" id="paymentList">
                            <label for="paymentList">Payment List</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="modifyPayments">
                            <label for="modifyPayments">Modify Payments</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="billingSettings">
                            <label for="billingSettings">Billing Settings</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="paymentProcessor">
                            <label for="paymentProcessor">Payment Processor</label>
                        </div>
                    </div>
                </div>
                
                <div class="access-category">
                    <h3 class="access-category-title">POINT-OF-SALE</h3>
                    <div class="permissions-grid">
                        <div class="permission-item">
                            <input type="checkbox" id="createSale" checked>
                            <label for="createSale">Create Sale</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="manageProducts">
                            <label for="manageProducts">Manage Products</label>
                        </div>
                        <div class="permission-item">
                            <input type="checkbox" id="salesSettings">
                            <label for="salesSettings">Sales Settings</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>