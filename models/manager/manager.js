let pool = require('../../database/connection');

module.exports = class Manager{

    static viewSalesReportCity(){
        return new Promise((resolve, reject) => {
            pool.query("CALL viewSalesReportCity()",
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

    static viewSalesReport(){
        return new Promise((resolve, reject) => {
            pool.query("CALL viewSalesReport()",
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

    static viewQuarterlySalesReport(request){
        const select_year = 2020;
        return new Promise((resolve, reject) => {
            pool.query("CALL viewQuarterlySalesReport(?)",[request.body.selectyear],
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

    static viewDriverWorkingHoursReport(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL viewDriverWorkingHoursReport()",   
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
    }
    static viewAssistantWorkingHoursReport(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL viewAssistantWorkingHoursReport()",   
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
    }
    
    static viewUsedHoursReport(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL viewUsedHoursReport()",   
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
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