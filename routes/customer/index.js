const router = require('express').Router();
const menu = require('./menu');
const cart = require('./cart');
const confirmed = require('./confirmed');
router.use('/menu',menu);
router.use('/cart',cart);
router.use('/confirmed',confirmed);
module.exports = router