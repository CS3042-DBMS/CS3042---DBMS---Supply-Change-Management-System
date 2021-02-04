const express = require('express');
const {viewOrders} = require('../../controllers/manager/menu');
const router = express.Router();

router.get('/view',viewOrders );

module.exports = router;