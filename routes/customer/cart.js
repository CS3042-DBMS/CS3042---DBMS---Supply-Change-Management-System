const express = require('express');
const {getCart,removeCartItem,createOrder,getRoutes} = require('../../controllers/customer/cart')
const router = express.Router();


router.get('/view',getCart );
router.post('/view', removeCartItem);
router.get('/order',getRoutes);
router.post('/order',createOrder);

module.exports = router;