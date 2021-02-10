let pool = require('../../database/connection');



module.exports= class Manager {
    static getcustomerOrderReport(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL getcustomer_order_report()",   
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
    }

    static getMostOrderItems(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL items_with_most_orders()",   
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