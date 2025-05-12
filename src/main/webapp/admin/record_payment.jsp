<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.gymproject.model.User" %>
<%@ page import="com.example.gymproject.model.Package" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Record New Payment</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    #body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 20px;
    }

    .container {
      max-width: 600px;
      margin: 0 auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
      color: #333;
      text-align: center;
      margin-bottom: 20px;
    }

    .form-group {
      margin-bottom: 15px;
    }

    label {
      display: block;
      margin-bottom: 5px;
      color: #555;
      font-weight: bold;
    }

    select,
    input[type="text"],
    input[type="number"],
    input[type="month"],
    input[type="checkbox"] {
      width: calc(100% - 12px);
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 16px;
    }

    button[type="submit"] {
      background-color: #28a745;
      color: white;
      padding: 12px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      transition: background-color 0.3s ease;
      width: 100%;
    }

    button[type="submit"]:hover {
      background-color: #1e7e34;
    }

    .button-container {
      margin-top: 20px;
      text-align: center;
    }

    .back-button {
      display: inline-block;
      padding: 10px 15px;
      text-decoration: none;
      background-color: #6c757d;
      color: white;
      border-radius: 4px;
      transition: background-color 0.3s ease;
      margin-right: 10px;
    }

    .back-button:hover {
      background-color: #5a6268;
    }

    .error-message {
      color: red;
      margin-top: 10px;
      text-align: center;
    }

    /* Payment Method Styles */
    .payment-method-tabs {
      display: flex;
      margin-bottom: 20px;
      border-bottom: 1px solid #ddd;
    }

    .payment-tab {
      padding: 10px 20px;
      cursor: pointer;
      background-color: #f1f1f1;
      border: 1px solid #ddd;
      border-bottom: none;
      margin-right: 5px;
      border-radius: 5px 5px 0 0;
    }

    .payment-tab.active {
      background-color: #fff;
      border-bottom: 1px solid #fff;
      margin-bottom: -1px;
    }

    .payment-content {
      display: none;
    }

    .payment-content.active {
      display: block;
    }

    .card-icons {
      margin: 10px 0;
      text-align: center;
    }

    .card-icons img {
      margin: 0 5px;
      height: 30px;
    }

    .card-form-group {
      margin-bottom: 15px;
    }

    small {
      color: #666;
      font-size: 0.8em;
    }
  </style>
</head>
<body id="body">
<div class="container">
  <h1>Record New Payment</h1>

  <% if (request.getAttribute("errorMessage") != null) { %>
  <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
  <% } %>

  <form action="${pageContext.request.contextPath}/admin/payments" method="post" onsubmit="preparePaymentData()">
    <input type="hidden" name="action" value="recordPayment">
    <input type="hidden" id="hiddenUserName" name="userName">
    <input type="hidden" id="hiddenPackageName" name="packageName">
    <input type="hidden" id="hiddenPackagePrice" name="packagePrice">
    <input type="hidden" id="hiddenPaymentMethod" name="paymentMethod" value="credit_card">

    <div class="form-group">
      <label for="userId">User:</label>
      <select id="userId" name="userId" required onchange="updateHiddenUser()">
        <option value="">Select User</option>
        <%
          List<User> users = (List<User>) request.getAttribute("users");
          if (users != null) {
            for (User user : users) {
        %>
        <option value="<%= user.getId() %>"><%= user.getName() %></option>
        <%
            }
          }
        %>
      </select>
    </div>

    <div class="form-group">
      <label for="packageId">Package:</label>
      <select id="packageId" name="packageId" required onchange="updateHiddenPackage()">
        <option value="">Select Package</option>
        <%
          List<Package> packages = (List<Package>) request.getAttribute("packages");
          if (packages != null) {
            for (Package pkg : packages) {
        %>
        <option value="<%= pkg.getId() %>"><%= pkg.getName() %> (<%= pkg.getPrice() %>)</option>
        <%
            }
          }
        %>
      </select>
    </div>

    <div class="form-group">
      <label for="paymentDate">Payment Date:</label>
      <% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
      <input type="text" id="paymentDate" name="paymentDate" value="<%= sdf.format(new Date()) %>" required>
      <small>Format:<\ctrl3348>-MM-dd HH:mm:ss</small>
    </div>

    <div class="form-group">
      <label for="amount">Amount Paid:</label>
      <input type="number" id="amount" name="amount" step="0.01" required>
    </div>

    <div class="form-group">
      <label>Payment Method:</label>
      <div class="payment-method-tabs">
        <div class="payment-tab active" onclick="showPaymentTab('card'); document.getElementById('hiddenPaymentMethod').value = 'credit_card'">Credit/Debit Card</div>
        <div class="payment-tab" onclick="showPaymentTab('other'); document.getElementById('hiddenPaymentMethod').value = 'other'">Other</div>
      </div>
    </div>

    <div id="cardPayment" class="payment-content active">
      <div class="card-form-group">
        <label for="cardNumber">Card Number:</label>
        <input type="text" id="cardNumber" name="cardNumber" pattern="\d{16}" maxlength="16"
               placeholder="1200003334320000">
        <div class="card-icons">
          <img src="${pageContext.request.contextPath}/images/Amex1.png" alt="American Express">
          <img src="${pageContext.request.contextPath}/images/masterM.png" alt="Mastercard">
          <img src="${pageContext.request.contextPath}/images/visa.png" alt="Visa">
        </div>
      </div>

      <div class="card-form-group">
        <label for="expiryDate">Expiry Month & Year:</label>
        <input type="month" id="expiryDate" name="expiryDate" min="<%= new SimpleDateFormat("yyyy-MM").format(new Date()) %>">
      </div>

      <div class="card-form-group">
        <label for="cardholderName">Cardholder Name:</label>
        <input type="text" id="cardholderName" name="cardholderName" pattern="[A-Za-z\s]+" placeholder="Name">
      </div>

      <div class="card-form-group">
        <label for="cvv">CVV:</label>
        <input type="number" id="cvv" name="cvv" min="100" max="999" placeholder="849">
      </div>
    </div>

    <div id="otherPayment" class="payment-content">
      <div class="form-group">
        <label for="paymentType">Payment Type:</label>
        <input type="text" id="paymentType" name="paymentType" placeholder="e.g., Bank Transfer, Cash" required>
      </div>
    </div>

    <div class="form-group">
      <label for="recurring">Recurring Payment:</label>
      <input type="checkbox" id="recurring" name="recurring" value="true"> Yes
    </div>

    <div class="button-container">
      <button type="submit">Record Payment</button>
      <a href="${pageContext.request.contextPath}/admin/payments" class="back-button">Back to Payments</a>
    </div>
  </form>
</div>

<script>
  function showPaymentTab(tabName) {
    // Hide all payment content sections
    document.querySelectorAll('.payment-content').forEach(content => {
      content.classList.remove('active');
    });

    // Show the selected payment content
    document.getElementById(tabName + 'Payment').classList.add('active');

    // Update tab styling
    document.querySelectorAll('.payment-tab').forEach(tab => {
      tab.classList.remove('active');
    });
    event.currentTarget.classList.add('active');

    // Update hidden payment method
    document.getElementById('hiddenPaymentMethod').value = tabName;

    // Toggle required attributes based on the active tab
    const cardNumberInput = document.getElementById('cardNumber');
    const expiryDateInput = document.getElementById('expiryDate');
    const cardholderNameInput = document.getElementById('cardholderName');
    const cvvInput = document.getElementById('cvv');
    const otherPaymentTypeInput = document.getElementById('paymentType');

    if (tabName === 'card') {
      cardNumberInput.setAttribute('required', 'required');
      expiryDateInput.setAttribute('required', 'required');
      cardholderNameInput.setAttribute('required', 'required');
      cvvInput.setAttribute('required', 'required');
      otherPaymentTypeInput.removeAttribute('required');
    } else if (tabName === 'other') {
      cardNumberInput.removeAttribute('required');
      expiryDateInput.removeAttribute('required');
      cardholderNameInput.removeAttribute('required');
      cvvInput.removeAttribute('required');
      otherPaymentTypeInput.setAttribute('required', 'required');
    }
  }

  function updateHiddenUser() {
    const selectElement = document.getElementById('userId');
    document.getElementById('hiddenUserName').value = selectElement.options[selectElement.selectedIndex].text;
  }

  function updateHiddenPackage() {
    const selectElement = document.getElementById('packageId');
    const selectedText = selectElement.options[selectElement.selectedIndex].text;
    const packageNameMatch = selectedText.match(/^([^ (]+)/); // Extract name before the first space or parenthesis
    const priceMatch = selectedText.match(/\(([^)]+)\)/);

    if (packageNameMatch) {
      document.getElementById('hiddenPackageName').value = packageNameMatch[1].trim();
    }
    if (priceMatch) {
      document.getElementById('hiddenPackagePrice').value = parseFloat(priceMatch[1].replace(/[^\d.]/g, ''));
    }
  }

  function preparePaymentData() {
    updateHiddenUser();
    updateHiddenPackage();
    // The paymentMethod is already set when the tab is clicked
  }

  // Auto-fill amount when package is selected
  document.getElementById('packageId').addEventListener('change', function() {
    const selectedOption = this.options[this.selectedIndex];
    if (selectedOption.text.includes('(')) {
      const price = selectedOption.text.match(/\(([^)]+)\)/)[1];
      document.getElementById('amount').value = parseFloat(price.replace(/[^\d.]/g, ''));
    } else {
      document.getElementById('amount').value = ''; // Clear amount if no price in package name
    }
  });

  // Initialize the 'card' tab as active on page load
  document.addEventListener('DOMContentLoaded', function() {
    showPaymentTab('card');
  });
</script>
</body>
</html>