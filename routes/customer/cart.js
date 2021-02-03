const express = require('express');
const {getCart,removeCartItem} = require('../../controllers/customer/cart')
const router = express.Router();


router.get('/view',getCart );
router.post('/view', removeCartItem);

module.exports = router;