const router = require('express').Router();
const orders = require('./orders');
const trainshed = require('./trains');
router.use('/orders',orders);
router.use('/trainschedule',trainshed);

module.exports = router