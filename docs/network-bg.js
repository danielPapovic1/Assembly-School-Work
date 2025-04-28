// Interactive Network Background
document.addEventListener('DOMContentLoaded', function() {
    // Create canvas element for the interactive background
    const canvas = document.createElement('canvas');
    canvas.id = 'interactive-bg';
    
    // Insert canvas as the first child of the hero element
    const hero = document.querySelector('.hero');
    if (hero) {
        hero.insertBefore(canvas, hero.firstChild);
        
        // Initialize the network animation
        initNetworkAnimation(canvas);
    }
});

function initNetworkAnimation(canvas) {
    const ctx = canvas.getContext('2d');
    let width = canvas.width = canvas.offsetWidth;
    let height = canvas.height = canvas.offsetHeight;
    
    // Mouse position
    let mouseX = width / 2;
    let mouseY = height / 2;
    
    // Network configuration
    const config = {
        nodeCount: 60,           // Number of nodes
        nodeSize: 1,             // Size of nodes
        connectionDistance: 150, // Maximum distance to draw connections
        connectionWidth: 0.3,    // Line width
        nodeSpeed: 0.3,          // Movement speed
        interactionRadius: 200,  // How far the mouse influence reaches
        interactionStrength: 2,  // Strength of mouse influence
        color: '#405ad5',        // Base color (purple)
        pointColor: '#fff',      // Node color
        backgroundColor: '#202535', // Background color
    };
    
    // Create nodes
    const nodes = [];
    for (let i = 0; i < config.nodeCount; i++) {
        nodes.push({
            x: Math.random() * width,
            y: Math.random() * height,
            vx: (Math.random() - 0.5) * config.nodeSpeed,
            vy: (Math.random() - 0.5) * config.nodeSpeed,
        });
    }
    
    // Mouse move event listener
    document.addEventListener('mousemove', function(e) {
        const rect = canvas.getBoundingClientRect();
        mouseX = e.clientX - rect.left;
        mouseY = e.clientY - rect.top;
    });
    
    // Resize event listener
    window.addEventListener('resize', function() {
        width = canvas.width = canvas.offsetWidth;
        height = canvas.height = canvas.offsetHeight;
    });
    
    // Animation loop
    function animate() {
        // Clear canvas
        ctx.fillStyle = config.backgroundColor;
        ctx.fillRect(0, 0, width, height);
        
        // Update and draw nodes
        for (let i = 0; i < nodes.length; i++) {
            const node = nodes[i];
            
            // Update position
            node.x += node.vx;
            node.y += node.vy;
            
            // Bounce off edges
            if (node.x < 0 || node.x > width) node.vx = -node.vx;
            if (node.y < 0 || node.y > height) node.vy = -node.vy;
            
            // Keep nodes within bounds
            node.x = Math.max(0, Math.min(width, node.x));
            node.y = Math.max(0, Math.min(height, node.y));
            
            // Mouse interaction (gentle push)
            const dx = mouseX - node.x;
            const dy = mouseY - node.y;
            const distance = Math.sqrt(dx * dx + dy * dy);
            
            if (distance < config.interactionRadius) {
                const force = (config.interactionRadius - distance) / config.interactionRadius;
                node.vx -= dx * force * 0.01 * config.interactionStrength;
                node.vy -= dy * force * 0.01 * config.interactionStrength;
            }
            
            // Speed limit
            const speed = Math.sqrt(node.vx * node.vx + node.vy * node.vy);
            if (speed > config.nodeSpeed) {
                node.vx = (node.vx / speed) * config.nodeSpeed;
                node.vy = (node.vy / speed) * config.nodeSpeed;
            }
            
            // Draw connections to other nodes
            for (let j = i + 1; j < nodes.length; j++) {
                const otherNode = nodes[j];
                const dx = otherNode.x - node.x;
                const dy = otherNode.y - node.y;
                const distance = Math.sqrt(dx * dx + dy * dy);
                
                if (distance < config.connectionDistance) {
                    // Calculate opacity based on distance
                    const opacity = 1 - (distance / config.connectionDistance);
                    
                    // Draw line
                    ctx.beginPath();
                    ctx.moveTo(node.x, node.y);
                    ctx.lineTo(otherNode.x, otherNode.y);
                    ctx.strokeStyle = `rgba(64, 90, 213, ${opacity * 0.5})`;
                    ctx.lineWidth = config.connectionWidth;
                    ctx.stroke();
                }
            }
            
            // Draw node
            ctx.beginPath();
            ctx.arc(node.x, node.y, config.nodeSize, 0, Math.PI * 2);
            ctx.fillStyle = config.pointColor;
            ctx.fill();
        }
        
        requestAnimationFrame(animate);
    }
    
    // Start animation
    animate();
}