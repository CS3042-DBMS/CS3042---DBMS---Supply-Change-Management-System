const express = require('express');
const router = express.Router();
const {requireAuthCustomer,requireAuthManager,requireAuthStoreManager,requireAuthDriver,requireAuthAssistant} = require('../middleware/authMiddleware') // add this middle ware to authenticate without login


// protect customer routes - add requireAuthCustomer middleware
// protect manager routes - add requireAuthManager middleware
// protect assistant routes - add requireAuthAssistant middleware
// protect store manager routes - add requireAuthStoreManager middleware
// protect driver routes - add requireAuthDriver middleware


const customerFunctions = require('./customer');
const driverFunctions = require('./driver');
const storeManagerFunctions = require('./storemanager');
const ManagerFunctions = require('./manager');
const assistantdriverFunctions = require('./assistantdriver');

// manager routes
router.use('/manager_func',requireAuthManager,managerFunctions);
// customer routes
router.use('/customer_func', requireAuthCustomer,customerFunctions);
//store manager routes
router.use('/storemanager',requireAuthStoreManager,storeManagerFunctions); 
//manager routes
router.use('/manager_func',requireAuthManager,ManagerFunctions);
// autentication routes
router.use('/',authRoutes)

module.exports = router
