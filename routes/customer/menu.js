const express = require('express');
const {getMenu,addToCart} = require('../../controllers/customer/menu')
const router = express.Router();


router.get('/view',getMenu );

router.post('/view',addToCart );


module.exports = router;