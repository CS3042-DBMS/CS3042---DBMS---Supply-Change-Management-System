let pool = require('../../database/connection');

module.exports= class Driver {
    static getTruckShedule() {
        return new Promise((resolve, reject) => {
            pool.query("CALL getTruckShedule()",
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
    }

    static addToJob(request){
        return new Promise((resolve,reject) =>{
            pool.query("CALL addToJob(?,?)",
            [
                
                request.body.prod,
                request.body.quantity
            ],
            (error, results, fields) => {
                if (error) {
                    reject(error);
                };
                resolve(console.log('added to job'));
            }
        )

        })
        
    }
    static getJoblist(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL getJoblist()",
                // [
                //     // request.userEmail
                // ],
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
    }
    
    static removeJob(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL removejob(?)",
                [
                 
                    request.body.prod
                ],
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve("removed job");
                }
            )
        })
      
    }
    

}