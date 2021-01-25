const router = require('express').Router();
const menu = require('./menu');

router.use('/menu',menu);

module.exports = router