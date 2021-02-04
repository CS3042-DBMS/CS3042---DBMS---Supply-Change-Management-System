const express = require('express');
const router = express.Router();

const customerFunctions = require('./customer');
const managerFunctions = require('./manager');

router.use('/customer_func',customerFunctions);
router.use('/manager_func',managerFunctions);

module.exports = router