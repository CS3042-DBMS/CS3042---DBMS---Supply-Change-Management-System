const express = require('express');
const router = express.Router();
const {requireAuthCustomer,requireAuthManager,requireAuthEmployee,requireAuthDriver,requireAuthAssistantDriver} = require('../middleware/authMiddleware') // add this middle ware to authenticate without login

// protect customer routes - add requireAuthCustomer middleware
// protect manager routes - add requireAuthManager middleware
// protect emplyee routes - add requireAuthEmployee middleware


const customerFunctions = require('./customer');

const driverFunctions = require('./driver');
const assistantdriverFunctions = require('./assistantdriver');
const authRoutes = require('./authroutes/authroute')

// customer routes
router.use('/customer_func', requireAuthCustomer,customerFunctions);
// driver routes
router.use('/driver_func',driverFunctions);
router.use('/assistant_driver_func',assistantdriverFunctions);
// autentication routes
router.use('/',authRoutes)
//ssd
module.exports = router