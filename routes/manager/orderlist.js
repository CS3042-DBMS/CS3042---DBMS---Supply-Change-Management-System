const express = require('express');
const {viewOrders} = require('../../controllers/manager/orders');
const router = express.Router();

router.get('/vieworders',viewOrders );

module.exports = router;