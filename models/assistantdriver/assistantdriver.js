let pool = require('../../database/connection');

module.exports= class AssistantDriver {
    static gettruckschedule() {
        return new Promise((resolve, reject) => {
            pool.query("CALL gettruckschedule()",
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