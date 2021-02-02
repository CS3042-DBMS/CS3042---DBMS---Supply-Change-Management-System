

let pool = require('../database/connection');
const bcrypt = require('bcrypt');
const AuthCustomer = require('../models/authentication/customer/authCustomer').getAuthCustomerInstance();


module.exports.signup_get = (req,res) => {
    res.render('signup-customer/index')
}

module.exports.login_get = (req,res) => {
    res.render('login/index')
}
/****
 * TODO
 *  - need to validate request data
 *  - check user exist prior to create new entry in db 
 *  - error handling
 *  - login function
 */
module.exports.signup_post = (req,res) => {
    const {
        email,
        name,
        type,
        password,
        contact_no
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
                console.error('[error] - hashing password - contoller/authcontroller '+err)
                res.status(500).send('Internal Server Error')
                return 
            }

            // store in database
            AuthCustomer.registerCustomer(
                pool,
                req,
                res,{
                    email:email,
                    name:name,
                    type:type,
                    contact_no:contact_no,
                    hash:hash
                })
            .then(data => {
                // if success redirect to the login page
                res.status(400).json({error:0})
                console.log(data[0])
            })
            .catch(err => {
                // if email already used send bad reqeyuest
                if(err.code === 'ER_DUP_ENTRY')
                    res.status(400).json({error:'this email alredy used'})
                    console.log(err);
            })
        })
    })
}

module.exports.login_post = (req,res) => {

    res.send('logged in')
}