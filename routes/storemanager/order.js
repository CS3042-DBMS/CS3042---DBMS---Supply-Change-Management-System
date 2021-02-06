const express = require('express');
const {getOrders} = require('../../controllers/storemanager/order') // 
const router = express.Router();


router.get('/getorders',getOrders );
// router.put('/getorders/:id',updateOrder)

module.exports = router;