let pool = require('../../database/connection');

module.exports = class Manager{
    static viewQuarterlySalesReport(){
        return new Promise((resolve,reject) => {
            const query_code = "CREATE OR REPLACE VIEW quarterly_sales_report AS"+
            "SELECT ";
            

            pool.query(query_code,
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };

                    //console.log(results);
                    resolve(results);

                }
            )
        });
    }

    static viewOrders(){
        return new Promise((resolve, reject) => {
            pool.query("CALL viewOrdersList()",
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