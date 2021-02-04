


const jwt = require('jsonwebtoken');

// auth customer
function requireAuthCustomer(req,res,next){

    // get the token from cookie
    const token = req.cookies.jwt;

    // token exist then deocde it
    if(token){
        const decodedToken = jwt.verify(token,'secret',(err,decodedToken) => {
            if(err){

                // any error redirect to login
                res.redirect('/')
                return
            }

            // return decoded token
            return decodedToken
        })
        if(decodedToken.type === 'customer'){

            // customer authenticate by middle ware and excute next function
            console.log(decodedToken)
            next();
        }
        else{

            res.redirect('/')
        }
    }
    else{
        res.redirect('/')
    }
}

// auth manager
function requireAuthManager(req,res,next){

    const token = req.cookies.jwt;
    if(token){
        const decodedToken = jwt.verify(token,'secret',(err,decodedToken) => {
            if(err){
                res.redirect('/')
                return
            }
            return decodedToken
        })
        if(decodedToken.type === 'manager'){
            console.log(decodedToken)
            next();
        }
        else{
            res.redirect('/')
        }
    }
    else{
        res.redirect('/')
    }
}
// auth employee
function requireAuthEmployee(req,res,next){

    const token = req.cookies.jwt;
    if(token){
        const decodedToken = jwt.verify(token,'secret',(err,decodedToken) => {
            if(err){
                res.redirect('/')
                return
            }
            return decodedToken
        })

        if(decodedToken.type === 'employee'){
            console.log(decodedToken)
            next();
        }
        else{
            res.redirect('/')
        }
    }
    else{
        res.redirect('/')
    }
}

module.exports = {requireAuthCustomer,requireAuthManager,requireAuthEmployee};