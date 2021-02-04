const express = require('express');
const {viewTrainSchedule} = require('../../controllers/manager/trains');
const router = express.Router();

router.get('/trains', viewTrainSchedule );

module.exports = router;