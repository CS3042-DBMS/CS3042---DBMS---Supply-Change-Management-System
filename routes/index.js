const express = require('express');
const router = express.Router();

const customerFunctions = require('./customer');

router.use('/customer_func',customerFunctions);

module.exports = router