const express = require('express');
const {getMenu,addToCart} = require('../../controllers/customer/menu')
const router = express.Router();
// const {pool} = require('../../startup/mysql_database');
// const _ = require('lodash');
// const path = require('path');


router.get('/view',getMenu );

router.post('/view',addToCart );


module.exports = router;