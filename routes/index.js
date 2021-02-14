const express = require('express');
const router = express.Router();
const {requireAuthCustomer,requireAuthManager,requireAuthEmployee,requireAuthDriver,requireAuthAssistantDriver} = require('../middleware/authMiddleware') // add this middle ware to authenticate without login

// protect customer routes - add requireAuthCustomer middleware
// protect manager routes - add requireAuthManager middleware
// protect emplyee routes - add requireAuthEmployee middleware


const customerFunctions = require('./customer');
const driverFunctions = require('./driver');
const assistantdriverFunctions = require('./assistantdriver');
const managerFunctions = require('./manager');
const storeManagerFunctions = require('./storemanager');
const authRoutes = require('./authroutes/authroute')

//manager routes
router.use('/manager_func',managerFunctions);
// customer routes
router.use('/customer_func', requireAuthCustomer,customerFunctions);
// driver routes
router.use('/driver_func',driverFunctions);
router.use('/assistant_driver_func',assistantdriverFunctions);


//store manager routes
router.use('/storemanager',storeManagerFunctions);  // parameter 2 and 3 should be changed

// autentication routes
router.use('/',authRoutes)



module.exports = router