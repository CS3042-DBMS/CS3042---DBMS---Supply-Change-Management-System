const express = require('express');
const {getTruckShedule,addToJob} = require('../../controllers/driver/truck_shedule')
const router = express.Router();


router.get('/view',getTruckShedule );

router.post('/view',addToJob );


module.exports = router;