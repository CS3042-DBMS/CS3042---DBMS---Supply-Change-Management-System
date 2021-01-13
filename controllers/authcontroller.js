const bcrypt = require('bcrypt');
const pool = require('../models/connection');

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
            pool.getConnection(function(err, connection) {
                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!
                
                // Use the connection
                connection.query(`INSERT INTO customer (customer_name,customer_address,city,password,email) VALUES (?,?,?,?,?)`,[name,address,city,hash,email], function (error, results, fields) {
                    console.log(results);
                    console.log(fields);

                // When done with the connection, release it.
                connection.release();

                // Handle error after the release.
                if (error) {throw error;}

                // Don't use the connection here, it has been returned to the pool.
                });
            });
        })
    })
}

module.exports.login_post = (req,res) => {

    res.send('logged in')
}