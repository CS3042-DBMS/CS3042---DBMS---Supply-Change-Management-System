const express = require('express');
const {viewAssistantWorkingHoursReport} = require('../../controllers/manager/assistant_workinghours_report') 
const router = express.Router();


router.get('/view',viewAssistantWorkingHoursReport );

module.exports = router;