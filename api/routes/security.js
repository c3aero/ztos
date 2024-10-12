const express = require('express');
const router = express.Router();

// Placeholder for security status API
router.get('/status', (req, res) => {
    res.json({ macsec: "Enabled", wireguard: "Running" });
});

module.exports = router;

