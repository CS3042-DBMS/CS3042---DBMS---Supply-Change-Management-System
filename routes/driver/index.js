const router = require('express').Router();
const truck_shedule = require('./truck_shedule');
const job = require('./job');

router.use('/truck_shedule',truck_shedule);
router.use('/job',job);

module.exports = router