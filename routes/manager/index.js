const router = require('express').Router();
const customerOrderReport = require('./customer_order_report');
const mostOrderItems = require('./most_order_items');

router.use('/customer_order_report',customerOrderReport);
router.use('/most_order_items',mostOrderItems);

module.exports = router