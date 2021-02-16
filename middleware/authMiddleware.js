


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
//auth driver

function requireAuthDriver(req,res,next){

    // get the token from cookie
    const token = req.cookies.jwt;
 if(decodedtoken){
        console.log(decodedtoken)
        
        if(decodedtoken.type === 'Manager'){
            console.log(decodedtoken)

    
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


//auth assistant driver
function requireAuthAssistantDriver(req,res,next){

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
        if(decodedToken.type === 'assistantdriver'){

            // assistant driver authenticate by middle ware and excute next function
            console.log(decodedToken)

            next();
        }
        else{

            res.redirect('/')
        }
    }else{
        res.redirect('/')
    }
}







































// auth assistant
function requireAuthStoreManager(req,res,next){

    // get the token from cookie
    const decodedtoken = decodeToken(req);

    if(decodedtoken){
        console.log(decodedtoken)
        
        if(decodedtoken.type === 'S_Manager'){
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

// auth assistant
function requireAuthDriver(req,res,next){

    // get the token from cookie
    const decodedtoken = decodeToken(req);

    if(decodedtoken){
        console.log(decodedtoken)
        
        if(decodedtoken.type === 'driver'){
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
        
        if(decodedtoken.type === 'Manager'){
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

// auth assistant
function requireAuthAssistant(req,res,next){


    // get the token from cookie
    const decodedtoken = decodeToken(req);

    if(decodedtoken){
        console.log(decodedtoken)
        
        if(decodedtoken.type === 'assistant'){
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

module.exports = {requireAuthCustomer,requireAuthManager,requireAuthStoreManager,requireAuthDriver,requireAuthAssistant,decodeToken};

