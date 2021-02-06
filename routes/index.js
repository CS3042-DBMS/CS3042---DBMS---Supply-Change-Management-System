const express = require('express');
const router = express.Router();
const {requireAuthCustomer,requireAuthManager,requireAuthEmployee} = require('../middleware/authMiddleware') // add this middle ware to authenticate without login

// protect customer routes - add requireAuthCustomer middleware
// protect manager routes - add requireAuthManager middleware
// protect emplyee routes - add requireAuthEmployee middleware


const customerFunctions = require('./customer');
const storeManagerFunctions = require('./storemanager');
const authRoutes = require('./authroutes/authroute')

// customer routes
router.use('/customer_func', requireAuthCustomer,customerFunctions);
//store manager routes
router.use('/storemanager',storeManagerFunctions);  // parameter 2 and 3 should be changed
// autentication routes
router.use('/',authRoutes)

module.exports = router