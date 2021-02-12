const express = require('express');
const {viewQuarterlySalesReport} = require('../../controllers/manager/quarterly_sales_report') 
const router = express.Router();


router.get('/view',viewQuarterlySalesReport );


module.exports = router;