let pool = require('../../database/connection');
const {decodeToken} = require('../../middleware/authMiddleware') // add this middle ware to authenticate without login

module.exports= class Driver {
    static gettruckschedule(request) {
        const decodedToken = decodeToken(request)

    
            console.log(decodedToken);
            
            // extract the email
            const email = decodedToken.email;
        return new Promise((resolve, reject) => {
            pool.query("CALL getDrivertruckschedule(?)",
            [
                email,
               

            ],
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
     
    }

    
    
   
    
    

}