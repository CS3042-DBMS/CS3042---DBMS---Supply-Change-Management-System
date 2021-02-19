const express = require('express');
const {viewUsedHoursReport} = require('../../controllers/manager/usedhours_report.js') 
const router = express.Router();


router.get('/view',viewUsedHoursReport );
router.post('/view',viewUsedHoursReport );

module.exports = router;