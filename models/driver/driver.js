let pool = require('../../database/connection');

module.exports= class Driver {
    static gettruckschedule() {
        return new Promise((resolve, reject) => {
            pool.query("CALL getDrivertruckschedule()",
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      //BEGIN SELECT  * FROM  Product;END
    }

    
    
   
    
    

}