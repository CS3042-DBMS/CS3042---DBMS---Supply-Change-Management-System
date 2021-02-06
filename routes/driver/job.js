const express = require('express');
const {getJoblist,removeJob} = require('../../controllers/driver/joblist')
const router = express.Router();


router.get('/view',getJoblist);
router.post('/view', removeJob);

module.exports = router;