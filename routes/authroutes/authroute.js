/* eslint-disable linebreak-style */
const { Router } = require('express');
const router = Router();
const authController = require('../../controllers/authcontroller')

// sign up view access route
router.get('/signup',authController.signup_get)

// sign up route
router.post('/signup', authController.signup_post)

// log in view access route
router.get('/login', authController.login_get)

// login route
router.post('/login', authController.login_post)

module.exports = router;