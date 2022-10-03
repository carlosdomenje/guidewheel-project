const express = require('express');
const router = express.Router();

const vitalsController = require('../controllers/vitals.controller');

router.get('/', vitalsController.welcome);
router.get('/api/v1/vitals/ping', vitalsController.alive);


module.exports = router;
