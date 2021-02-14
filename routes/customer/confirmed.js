const express = require('express');
const {getConfirmedOrders} = require('../../controllers/customer/confirmed')
const router = express.Router();


router.get('/view',getConfirmedOrders );



module.exports = router;