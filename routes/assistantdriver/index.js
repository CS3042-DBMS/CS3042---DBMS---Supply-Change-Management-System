const router = require('express').Router();
const truckschedule = require('./truckschedule');

router.use('/truckschedule',truckschedule);

module.exports = router