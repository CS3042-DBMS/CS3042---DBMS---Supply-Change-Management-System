const express = require('express');
const {viewSalesReport} = require('../../controllers/manager/sales_report_by_city_route') 
const router = express.Router();


router.get('/view',viewSalesReport );

module.exports = router;