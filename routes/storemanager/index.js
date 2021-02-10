const router = require('express').Router();
const order = require('./order');
const cart = require('./schedule');

router.use('/order',order);
//router.use('/schedule',schedule);

module.exports = router