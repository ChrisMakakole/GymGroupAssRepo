
function loadContent(pageUrl) {
  // Show loading state
  mainContainer.innerHTML = `
    <div class="content-loader">
      <div class="loading-spinner"></div>
      <p>Loading page...</p>
    </div>
  `;
  
  // Fetch the page content
  fetch(pageUrl)
    .then(response => {
      if (!response.ok) throw new Error('Network response was not ok');
      return response.text();
    })
    .then(html => {
      // Create a temporary container to parse the HTML
      const tempDiv = document.createElement('div');
      tempDiv.innerHTML = html;
      
      // Extract the main content (assuming your JSPs have a div with class 'page-content')
      const pageContent = tempDiv.querySelector('.page-content') || tempDiv;
      
      // Create new content container
      const contentDiv = document.createElement('div');
      contentDiv.className = 'home-content';
      contentDiv.innerHTML = pageContent.innerHTML;
      
      // Replace loading indicator with the new content
      mainContainer.innerHTML = '';
      mainContainer.appendChild(contentDiv);
      
      // Update active menu item based on the loaded page
      setActiveMenuItem(pageUrl.replace('.jsp', ''));
    })
    .catch(error => {
      mainContainer.innerHTML = `
        <div class="error-message">
          <h3>Error Loading Content</h3>
          <p>${error.message}</p>
          <button onclick="loadDashboardContent()">Return to Dashboard</button>
        </div>
      `;
    });
}

function setActiveMenuItem(pageName) {
  // Remove active class from all menu items
  document.querySelectorAll('.nav-links li a').forEach(item => {
    item.classList.remove('active');
  });
  
  // Find and activate the current menu item
  const menuItems = document.querySelectorAll('.nav-links li a');
  for (let item of menuItems) {
    if (item.textContent.includes(pageName) || 
        (pageName === 'Dashboard' && item.textContent.includes('Dashboard'))) {
      item.classList.add('active');
      break;
    }
  }
}




// Initialize dashboard
document.addEventListener('DOMContentLoaded', function() {
  // Set click handlers for all nav links
  document.querySelectorAll('.nav-links li a').forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
    });
  });
});
