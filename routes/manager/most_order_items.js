const express = require('express');
const {getMostOrderItems} = require('../../controllers/manager/most_order_items') 
const router = express.Router();


router.get('/view',getMostOrderItems );


module.exports = router;