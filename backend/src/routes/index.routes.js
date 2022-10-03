const express = require('express');
const router = express.Router();


router.use('/', require('./vitals.routes'));
router.use('/api/v1/panel', require('./panel.routes'));

module.exports = router;
