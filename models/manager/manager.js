let pool = require('../../database/connection');

module.exports = class Manager{
    static viewOrders(){
        return new Promise((resolve, reject) => {
            pool.query("CALL viewOrders()",
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };

                    console.log(results);
                    resolve(results);

                }
            )
        })
    }
}