const express = require('express');
const {viewDriverWorkingHoursReport} = require('../../controllers/manager/driver_workinghours_report') 
const router = express.Router();


router.get('/view',viewDriverWorkingHoursReport );

module.exports = router;