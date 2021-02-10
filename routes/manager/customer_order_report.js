const express = require('express');
const {getcustomerOrderReport} = require('../../controllers/manager/customer_order_report') 
const router = express.Router();


router.get('/view',getcustomerOrderReport );


module.exports = router;