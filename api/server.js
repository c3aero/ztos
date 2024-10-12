const express = require('express');
const app = express();

app.use(express.json());

// Import and use routes
const networkRoutes = require('./routes/network');
const securityRoutes = require('./routes/security');

app.use('/api/v1/network', networkRoutes);
app.use('/api/v1/security', securityRoutes);

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`ZTOS API Server running on port ${PORT}`);
});

