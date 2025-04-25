
// Function to load content dynamically
function loadContent(url) {
    // Create a container for dynamic content if it doesn't exist
    let contentContainer = document.getElementById('dynamic-content-container');
    
    if (!contentContainer) {
        contentContainer = document.createElement('div');
        contentContainer.id = 'dynamic-content-container';
        contentContainer.style.position = 'fixed';
        contentContainer.style.top = '80px';
        contentContainer.style.right = '20px';
        contentContainer.style.width = 'calc(100% - 280px)';
        contentContainer.style.height = 'calc(100vh - 100px)';
        contentContainer.style.backgroundColor = 'white';
        contentContainer.style.borderRadius = '8px';
        contentContainer.style.boxShadow = '0 4px 8px rgba(0,0,0,0.1)';
        contentContainer.style.zIndex = '1000';
        contentContainer.style.overflow = 'auto';
        contentContainer.style.padding = '20px';
        
        // Add close button
        const closeBtn = document.createElement('button');
        closeBtn.innerHTML = '&times;';
        closeBtn.style.position = 'absolute';
        closeBtn.style.top = '10px';
        closeBtn.style.right = '10px';
        closeBtn.style.background = 'none';
        closeBtn.style.border = 'none';
        closeBtn.style.fontSize = '20px';
        closeBtn.style.cursor = 'pointer';
        closeBtn.onclick = function() {
            document.body.removeChild(contentContainer);
        };
        contentContainer.appendChild(closeBtn);
        
        document.body.appendChild(contentContainer);
    }
    
    // Show loading indicator
    contentContainer.innerHTML = '<div style="text-align: center; padding: 50px;">Loading...</div>';
    
    // Load the content
    fetch(url)
        .then(response => response.text())
        .then(data => {
            contentContainer.innerHTML = data;
            const closeBtn = document.createElement('button');
            closeBtn.innerHTML = '&times;';
            closeBtn.style.position = 'absolute';
            closeBtn.style.top = '10px';
            closeBtn.style.right = '10px';
            closeBtn.style.background = 'none';
            closeBtn.style.border = 'none';
            closeBtn.style.fontSize = '20px';
            closeBtn.style.cursor = 'pointer';
            closeBtn.onclick = function() {
                document.body.removeChild(contentContainer);
            };
            contentContainer.insertBefore(closeBtn, contentContainer.firstChild);
        })
        .catch(error => {
            contentContainer.innerHTML = '<div style="padding: 20px; color: red;">Error loading content: ' + error + '</div>';
        });


// Update your navigation links to use this function
document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.nav-links a');
    navLinks.forEach(link => {
        if (link.getAttribute('href') === '#') {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const span = this.querySelector('.links_name');
                if (span && span.textContent === 'Members') {
                    loadContent('Member.jsp');
                }
                // Add other pages as needed
            });
        }
    });
});
