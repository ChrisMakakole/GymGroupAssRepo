<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }
    
    body {
      background: #f5f5f5;
    }
    
    .dashboard-container {
      max-width: 1200px;
      margin: 20px auto;
      padding: 20px;
    }
    
    h1 {
      font-size: 24px;
      margin-bottom: 20px;
      color: #333;
    }
    
    .stats-container {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 30px;
    }
    
    .stat-card {
      background: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .stat-card h2 {
      font-size: 16px;
      color: #666;
      margin-bottom: 10px;
    }
    
    .stat-card .value {
      font-size: 28px;
      font-weight: bold;
      margin-bottom: 10px;
      color: #333;
    }
    
    .stat-card .trend {
      display: flex;
      align-items: center;
      font-size: 14px;
      color: #666;
    }
    
    .trend.up {
      color: #4CAF50;
    }
    
    .trend.down {
      color: #F44336;
    }
    
    .recent-sales {
      background: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .recent-sales h2 {
      font-size: 20px;
      margin-bottom: 20px;
      color: #333;
    }
    
    table {
      width: 100%;
      border-collapse: collapse;
    }
    
    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }
    
    th {
      background-color: #f8f9fa;
      font-weight: 600;
      color: #333;
    }
    
    tr:hover {
      background-color: #f5f5f5;
    }
    
    .status {
      padding: 5px 10px;
      border-radius: 4px;
      font-size: 12px;
      font-weight: 500;
    }
    
    .status.delivered {
      background-color: #E8F5E9;
      color: #4CAF50;
    }
    
    .status.pending {
      background-color: #FFF8E1;
      color: #FFA000;
    }
    
    .status.returned {
      background-color: #FFEBEE;
      color: #F44336;
    }
    
    .check-icon {
      color: #4CAF50;
    }
    
    hr {
      border: 0;
      height: 1px;
      background-color: #eee;
      margin: 20px 0;
    }
  </style>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
  <div class="dashboard-container">
    <h1>Dashboard</h1>
    
    <div class="stats-container">
      <div class="stat-card">
        <h2>Total Order</h2>
        <div class="value">40,876</div>
        <div class="trend up">
          <i class="fas fa-arrow-up"></i>
          <span>Up from yesterday</span>
        </div>
      </div>
      
      <div class="stat-card">
        <h2>Total Sales</h2>
        <div class="value">38,876</div>
        <div class="trend up">
          <i class="fas fa-arrow-up"></i>
          <span>Up from yesterday</span>
        </div>
      </div>
      
      <div class="stat-card">
        <h2>Total Profit</h2>
        <div class="value">$12,876</div>
        <div class="trend up">
          <i class="fas fa-arrow-up"></i>
          <span>Up from yesterday</span>
        </div>
      </div>
      
      <div class="stat-card">
        <h2>Total Return</h2>
        <div class="value">11,086</div>
        <div class="trend down">
          <i class="fas fa-arrow-down"></i>
          <span>Down From Today</span>
        </div>
      </div>
    </div>
    
    <hr>
    
    <div class="recent-sales">
      <h2>Recent Sales</h2>
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Customer</th>
            <th>Sales</th>
            <th>Total</th>
            <th>Top Selling Product</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>02 Jan 2021</td>
            <td>Alex Doe</td>
            <td><span class="status delivered">Delivered</span></td>
            <td>$204.98</td>
            <td><i class="fas fa-check check-icon"></i> Vuitton Sunglasses</td>
          </tr>
          <tr>
            <td>02 Jan 2021</td>
            <td>David Mart</td>
            <td><span class="status pending">Pending</span></td>
            <td>$24.55</td>
            <td><i class="fas fa-check check-icon"></i> Hourglass Jeans</td>
          </tr>
          <tr>
            <td>02 Jan 2021</td>
            <td>Roe Porter</td>
            <td><span class="status returned">Returned</span></td>
            <td>$25.88</td>
            <td><i class="fas fa-check check-icon"></i> Nike Sport Shoe</td>
          </tr>
          <tr>
            <td>02 Jan 2021</td>
            <td>Diana Penty</td>
            <td><span class="status delivered">Delivered</span></td>
            <td>$170.66</td>
            <td><i class="fas fa-check check-icon"></i> Hermes Silk Scarves.</td>
          </tr>
          <tr>
            <td>02 Jan 2021</td>
            <td>Martin Paw</td>
            <td><span class="status pending">Pending</span></td>
            <td>$56.56</td>
            <td><i class="fas fa-check check-icon"></i> Succi Ladies Bag</td>
          </tr>
          <tr>
            <td>02 Jan 2021</td>
            <td>Doe Alex</td>
            <td><span class="status returned">Returned</span></td>
            <td>$44.95</td>
            <td><i class="fas fa-check check-icon"></i> Gucci Womens's Bags</td>
          </tr>
          <tr>
            <td>02 Jan 2021</td>
            <td>Aiana Lexa</td>
            <td><span class="status delivered">Delivered</span></td>
            <td>$67.33</td>
            <td><i class="fas fa-check check-icon"></i> Addidas Running Shoe</td>
          </tr>
          <tr>
            <td>02 Jan 2021</td>
            <td>Revel Mags</td>
            <td><span class="status pending">Pending</span></td>
            <td>$23.53</td>
            <td><i class="fas fa-check check-icon"></i> Bilack Wear's Shirt</td>
          </tr>
          <tr>
            <td></td>
            <td>Tiana Loths</td>
            <td><span class="status delivered">Delivered</span></td>
            <td>$46.52</td>
            <td><i class="fas fa-check check-icon"></i></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>