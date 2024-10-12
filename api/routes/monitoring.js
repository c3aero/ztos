const express = require('express');
const router = express.Router();
const os = require('os');
const { exec } = require('child_process');

// Route to get basic system info (CPU, memory, uptime)
router.get('/system-info', (req, res) => {
  const systemInfo = {
    platform: os.platform(),
    release: os.release(),
    uptime: os.uptime(),
    memory: {
      total: os.totalmem(),
      free: os.freemem()
    },
    cpu: os.cpus(),
  };
  res.json(systemInfo);
});

// Route to get container stats (using Docker stats)
router.get('/container-stats', (req, res) => {
  exec('docker stats --no-stream --format "{{json .}}"', (error, stdout, stderr) => {
    if (error) {
      return res.status(500).json({ error: 'Error retrieving container stats', details: stderr });
    }

    // Split the stdout by new lines and parse each line as JSON
    const stats = stdout.split('\n').filter(line => line).map(line => JSON.parse(line));
    res.json(stats);
  });
});

// Route to check the health status of a specific container
router.get('/container-health/:containerId', (req, res) => {
  const containerId = req.params.containerId;
  exec(`docker inspect --format='{{json .State.Health.Status}}' ${containerId}`, (error, stdout, stderr) => {
    if (error) {
      return res.status(500).json({ error: `Error retrieving health for container ${containerId}`, details: stderr });
    }

    res.json({ containerId, health: stdout.trim() });
  });
});

// Route to get Docker service status
router.get('/docker-status', (req, res) => {
  exec('systemctl is-active docker', (error, stdout, stderr) => {
    if (error) {
      return res.status(500).json({ error: 'Error retrieving Docker status', details: stderr });
    }
    res.json({ status: stdout.trim() });
  });
});

module.exports = router;
