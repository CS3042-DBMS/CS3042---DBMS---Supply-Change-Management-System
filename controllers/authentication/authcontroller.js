

let pool = require('../../database/connection');
const bcrypt = require('bcrypt');
const AuthCustomer = require('../../models/authentication/customer/authCustomer').getAuthCustomerInstance();
const LogInUser = require('../../models/authentication/user/loginUser').getLoginUserInstance();
const AuthServices = require('./functions').getAuthServicesInstance();
const jwt = require('jsonwebtoken');


module.exports.signup_get = (req,res) => {
    res.render('signup-customer/index')
}

module.exports.login_get = (req,res) => {

    const token = req.cookies.jwt;
    if(token){
        jwt.verify(token,'secret',(err,decodedToken) => {
            if(err){
                //if anny error occured then redirect to login
                res.redirect('/')
            }else{
                // redirect to login
                AuthServices.redirect(res,decodedToken.type,true);
            }
        })
    }
    res.render('login/index')
}


/****
 * TODO
 *  - need to validate request data - done
 *  - check user exist prior to create new entry in db  - done
 *  - error handling- done
 *  - login function - done
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
                res,
                req,
                {
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
                    console.log('[error] - sigining in user [email is laready used] - contoller/authcontroller '+ err);
            })
        })
    })
}
/****
 * TODO
 *  - need to validate request data - done
 *  - check if user exist - done
 *  - if user exist then get type of the user - done
 *  - error handling - done
 */

module.exports.login_post = (req,res) => {
    const {
        email,
        password
    } = req.body;
        console.log(email)

    // *************** TODO - Validating ************* //

    // check if user exist
    LogInUser.getUserInfo(pool,res,req,{email})
    .then(data => {

        // user exist , type and hashed password arrived from database
        let userType = data[0][0].type;
        let hash = data[0][0].password;
        let user = AuthServices.extractData(userType,data);

        AuthServices.checkPassword(hash,password)
        .then(matched => {

            console.log('hash compare done -' + matched)

            if(matched){

                // creatting token
                const token = AuthServices.createToken(user)

                // httpOnly means this token cannot change by frontend javascript code
                res.cookie('jwt', token , { httpOnly : true,maxAge:AuthServices.expire * 1000})


                // redirection
                AuthServices.redirect(res,userType,false)
            }

        }).catch(err => {

            console.log('[error] - checking password - contoller/authcontroller '+err)
            // error occured while hash comparing
            res.status(500).send('Internal Server Error')

        })
    })
    .catch(err => {

        // if user not in the database db throws INVALID_LOGIN exception
        if(err.sqlMessage === 'INVALID_LOGIN')
            res.status(400).json({error:'check password or email again'})
            console.log('[error] - invalid login attempt - contoller/authcontroller '+err);
    })
}

// logout route
module.exports.logout_get = (req,res) => {
    // delete auth jwt cookie to logout
    res.cookie('jwt','',{ maxAge:99})
    res.status(201).json({
                        message:'logout success',
                        error:false,
                        redirect:"/"
                })
}