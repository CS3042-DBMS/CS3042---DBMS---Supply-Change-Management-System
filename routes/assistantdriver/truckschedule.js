const express = require('express');
const {gettruckschedule} = require('../../controllers/assistantdriver/truckschedule')
const   router = express.Router();


router.get('/view',gettruckschedule );

    


module.exports = router;