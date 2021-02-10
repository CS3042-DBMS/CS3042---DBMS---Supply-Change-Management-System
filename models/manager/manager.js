let pool = require('../../database/connection');

module.exports = class Manager{
    static viewOrders(){
        return new Promise((resolve, reject) => {
            pool.query("CALL viewOrders()",
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };

                    //console.log(results);
                    resolve(results);

                }
            )
        })
    }

    static viewTrainSchedule(){
        return new Promise((resolve,reject) => {
            pool.query("CALL viewTrain()", (error,results, fields) => {
                if(error){
                    reject(error);
                };
                resolve(results);
            })
        })
    }

    static assignOrders(request){
        return new Promise((resolve,reject) => {
            // console.log(request.body.train_name,
            //     request.body.time_schedule,
            //     request.body.order_id);
            // pool.query("INSERT INTO order_assign VALUES(?,?,?)",[
            //     request.body.order_id,
            //     request.body.train_name,
            //     request.body.time_schedule
               
            // ], (error,results, fields) => {
            //     if(error){
            //         reject(error);
            //     };
            //     resolve(results);
            // })
            pool.query("CALL assignOrders(?,?,?)",[
                request.body.order_id,
                request.body.train_name,
                request.body.time_schedule
               
            ], (error,results, fields) => {
                if(error){
                    reject(error);
                };
                resolve(results);
            })
        })        
    }
}