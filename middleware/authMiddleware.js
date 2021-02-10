


const jwt = require('jsonwebtoken');

function decodeToken(req){
     // get the token from cookie
    const token = req.cookies.jwt;

    // token exist then deocde it
    if(token){
        const decodedToken = jwt.verify(token,'secret',(err,decodedToken) => {
            if(err){
                return null
            }
            // return decoded token
            return decodedToken
        })
        return decodedToken
        
    }
    else{
        return null
    }
}

// auth customer
function requireAuthCustomer(req,res,next){

    // get the token from cookie
    const decodedtoken = decodeToken(req);

    if(decodedtoken){
        console.log(decodedtoken)
        
        if(decodedtoken.type === 'customer'){
            console.log(decodedtoken)
            next();
        }
        else{
            res.redirect('/')
        }
    }else{
        res.redirect('/')
    }
}

// auth manager
function requireAuthManager(req,res,next){

    // get the token from cookie
    const decodedtoken = decodeToken(req);

    if(decodedtoken){
        console.log(decodedtoken)
        
        if(decodedtoken.type === 'manager'){
            console.log(decodedtoken)
            next();
        }
        else{
            res.redirect('/')
        }
    }else{
        res.redirect('/')
    }
}
// auth employee
function requireAuthEmployee(req,res,next){

    // get the token from cookie
    const decodedtoken = decodeToken(req);

    if(decodedtoken){
        console.log(decodedtoken)
        
        if(decodedtoken.type === 'employee'){
            console.log(decodedtoken)
            next();
        }
        else{
            res.redirect('/')
        }
    }else{
        res.redirect('/')
    }
}

module.exports = {requireAuthCustomer,requireAuthManager,requireAuthEmployee,decodeToken};