const router = require('express').Router();
const order = require('./order');
const createschedule = require('./createschedule');
const cart = require('./schedule');

router.use('/createschedule',createschedule); // creating truck schedules
router.use('/order',order);

module.exports = router