

let pool = require('../database/connection');
const bcrypt = require('bcrypt');
const AuthCustomer = require('../models/authentication/customer/authCustomer').getAuthCustomerInstance();
const LogInUser = require('../models/authentication/user/loginUser').getLoginUserInstance();
const jwt = require('jsonwebtoken');

// password compare with hash
async function checkPassword(hash,password) {
 
        return new Promise((resolve, reject) => {
            try {
                const match = bcrypt.compare(password, hash); // compare hash
                resolve(match);
            } catch (error) {
                reject(error)
            }
        }
        )
}

// redirecting function
function redirect(res,userType){
    switch (userType) {
                case 'customer':
                    // redirect to cutomer home page
                    res.status(201).json({
                        message:'login success',
                        error:false,
                        redirect:"/customer_func/menu/view"
                })
                    break;
                
                case 'Manager':
                    // redirect to Manager home page
                    res.status(201).json({
                        message:'login success',
                        error:false,
                        redirect:"/customer_func/menu/view"
                })
                break;

                case 'employee':
                    // redirect to employee home page
                    res.status(201).json({
                        message:'login success',
                        error:false,
                        redirect:"/customer_func/menu/view"
                })
                break;
            
                default:
                    break;
            }
}

// creating token function
const expire = 3 * 24 * 60 * 60
function createToken(email,type){
    return jwt.sign({email,type}, 'secret',{
        expiresIn: expire
    })
}

module.exports.signup_get = (req,res) => {
    res.render('signup-customer/index')
}

module.exports.login_get = (req,res) => {




    
    const token = req.cookies.jwt;
    if(token){
        const decodedToken = jwt.verify(token,'secret',(err,decodedToken) => {
            if(err){
                //if anny error occured then redirect to login
                res.redirect('/')

            }

            if(decodedToken.type === "customer"){

                res.redirect("/customer_func/menu/view")
                
            }else if (decodedToken.type === "manager"){

                // <=================== TODO =======================>
                // redircet to manager original

            }else if(decodedToken.type === "employee"){

                // <=================== TODO =======================>
                // redirdect to employee original
                
            }else{
                res.render('login/index')
            }
        })
    }
    
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
 *  - need to validate request data
 *  - check if user exist
 *  - if user exist then get type of the user
 *  - error handling
 */

module.exports.login_post = (req,res) => {
    const {
        email,
        password
    } = req.body;

    

    // *************** TODO - Validating ************* //

    // check if user exist
    LogInUser.getUserInfo(pool,res,req,{email})
    .then(data => {

        // user exist , type and password arrived

        let userType = data[0][0].type;
        let hash = data[0][0].password;

        checkPassword(hash,password)
        .then(matched => {

            console.log('hash compare done ' + matched)

            if(matched){

                // creatting token
                const token = createToken(email,userType)

                // httpOnly means this token cannot change by frontend javascript code
                res.cookie('jwt', token , { httpOnly : true,maxAge:expire * 1000})


                // redirection
                redirect(res,userType)
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
            console.log('[error] - invalid login attempt - contoller/authcontroller '+err.sqlMessage);
    })
}