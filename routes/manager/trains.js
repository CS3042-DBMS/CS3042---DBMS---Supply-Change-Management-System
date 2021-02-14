const express = require('express');
const {viewTrainSchedule} = require('../../controllers/manager/trains');
const {assignOrders} = require('../../controllers/manager/assign');
const router = express.Router();

router.get('/trains', viewTrainSchedule );
router.post('/assign', assignOrders );

module.exports = router;