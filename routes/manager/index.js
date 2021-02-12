const router = require('express').Router();

const viewQuarterlySalesReport = require('./quarterly_sales_report');
const customerOrderReport = require('./customer_order_report');
const mostOrderItems = require('./most_order_items');

const orders = require('./orders');
const trainshed = require('./trains');

router.use('/customer_order_report',customerOrderReport);
router.use('/most_order_items',mostOrderItems);

router.use('/orders',orders);
router.use('/trainschedule',trainshed);
router.use('/sales_reports',viewQuarterlySalesReport)

module.exports = router