

let pool = require('../database/connection');
const bcrypt = require('bcrypt');
const AuthCustomer = require('../models/authentication/customer/authCustomer').getAuthCustomerInstance();
/****
 * TODO
 *  - need to validate request data
 *  - check user exist prior to create new entry in db 
 *  - error handling
 *  - login function
 */

module.exports.signup_get = (req,res) => {
    res.render('signup-customer/index')
}

module.exports.login_get = (req,res) => {
    res.render('login-customer/index')
}

module.exports.signup_post = (req,res) => {
    const {
        email,
        address,
        name,
        city,
        password
    } = req.body;

    // ************ to-do - validating ********** //


    // hashing the password
    bcrypt.genSalt(10, (err, salt) => {
        if(err){
            console.log(salt)
            res.status(500).send('Internal Server Error')
        }
        bcrypt.hash(password,salt,(err,hash) => {

            if(err){
                console.log(err)
                res.status(500).send('Internal Server Error')
                return 
            }

            // store in database
            AuthCustomer.registerCustomer(pool,req,res,{email:email,address:address,name:name,city:city,hash:hash})
            .then(data => {
                // if success redirect to the login page
                res.redirect('http://localhost:5000/login')
                console.log(data)
            })
            .catch(err => {
                res.status(500).send('Internal Server Error')
                throw new Error(err);
            })
        })
    })
}

module.exports.login_post = (req,res) => {

    res.send('logged in')
}