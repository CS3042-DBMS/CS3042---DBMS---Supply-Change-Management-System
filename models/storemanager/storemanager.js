let pool = require('../../database/connection');

let SM;
module.exports= class StoreManager {
  static getStoreManagerInstance(){
        return SM ? SM : new StoreManager();
    }
  
    static getorders(request,email) {
        return new Promise((resolve, reject) => {
            pool.query("CALL view_orders(?)",[email],
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
    }

    static getorder(request) {  // request is the integer value of order_id
        return new Promise((resolve, reject) => {
            pool.query("CALL view_order("+request+")",
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
    }

    static updateorder(request) {  // request is the integer value of order_id
        return new Promise((resolve, reject) => {
            pool.query("CALL update_order("+request.body.order_id+","+request.body.schedule_id+")",
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve(results);
                }
            )
        })
      
    }



    static add_to_cart(request){
        return new Promise((resolve,reject) =>{
            pool.query("CALL add_to_cart(?,?)",
            [
                
                request.body.prod,
                request.body.quantity
            ],
            (error, results, fields) => {
                if (error) {
                    reject(error);
                };
                resolve(console.log('added to cart'));
            }
        )

        })
        
    }
    static getCart(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL getcart()",
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
    static getTotalPrice(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL totalPrice()",
                // [
                //     // request.userEmail,
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
    static removeCartItem(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL removeCartItem(?)",
                [
                 
                    request.body.prod
                ],
                (error, results, fields) => {
                    if (error) {
                        reject(error);
                    };
                    resolve("removed cart item");
                }
            )
        })
      
    }
    
    /**
     * 
     * @param {mysql.pool} pool - connection pool to database
     * @param {store_id} store_id - store id of the manager
     * @param {request} req - request that containg customer details
     * @param {response} res - response to the front end if error occured
     * state - done
     * 
     */
    async get_truck_schedules(pool,res,store_id){

        
            return new Promise((resolve, reject) => {
                pool.getConnection(function(err, connection) {


                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!
                
                // Use the connection
                connection.query(`SELECT schedule_id,date,departure_time,truck_id,assistant_name,driver_name,route_name,TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),TIMESTAMPADD(SECOND,SECOND (trip_time),departure_time))) AS trip_fullfill_time FROM truck_schedule NATURAL JOIN route LEFT OUTER JOIN driver USING (driver_id) LEFT OUTER JOIN driver_assistant USING (assistant_id) WHERE truck_schedule.store_id = ?;`,[store_id], function (error, results, fields) {
                    console.log(results);
                    console.log(fields);

                // When done with the connection, release it.
                    connection.release();

                // Handle error after the release.
                    if (error) {
                        reject(error)
                    }

                    resolve(results) ;
                // Don't use the connection here, it has been returned to the pool.
                });
            });
        })
    }














    /**
     * 
     * @param {mysql.pool} pool - connection pool to database
     * @param {store_id} store_id - store id of the manager
     * @param {request} req - request that containg customer details
     * @param {response} res - response to the front end if error occured
     * @param {route_id} route_id - to identify eligible assistants to tht route id
     * @param {departure_time} departure_time - to identify eligible assitants to this departure_time
     * state - done
     * 
     */
    async get_assistants(pool,res,route_id,departure_time,store_id){

        
            return new Promise((resolve, reject) => {
                pool.getConnection(function(err, connection) {


                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!
                
                // Use the connection
                connection.query(`CALL get_assistants(?,?,?)`,[route_id,departure_time,store_id], function (error, results, fields) {
                    console.log(results);
                    console.log(fields);

                // When done with the connection, release it.
                    connection.release();

                // Handle error after the release.
                    if (error) {
                        reject(error)
                    }

                    resolve(results) ;
                // Don't use the connection here, it has been returned to the pool.
                });
            });
        })
    }

    /**
     * 
     * @param {mysql.pool} pool - connection pool to database
     * @param {store_id} store_id - store id of the manager
     * @param {request} req - request that containg customer details
     * @param {response} res - response to the front end if error occured
     * state - implementing
     * 
     */
    async get_drivers(pool,res,route_id,departure_time,store_id){

        
            return new Promise((resolve, reject) => {
                pool.getConnection(function(err, connection) {


                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!
                
                // Use the connection
                connection.query(`CALL get_drivers(?,?,?)`,[route_id,departure_time,store_id], function (error, results, fields) {
                    console.log(results);
                    console.log(fields);

                // When done with the connection, release it.
                    connection.release();

                // Handle error after the release.
                    if (error) {
                        reject(error)
                    }

                    resolve(results) ;
                // Don't use the connection here, it has been returned to the pool.
                });
            });
        })
    }



























































    /**
     * 
     * @param {mysql.pool} pool - connection pool to database
     * @param {store_id} store_id - store id of the manager
     * @param {request} req - request that containg customer details
     * @param {response} res - response to the front end if error occured
     * @param {info} info - information about new schedule
     * state - done
     * 
     */
    async create_new_schedule_post(pool,res,store_id,...info){

        const {route_id,departure_time,date,truck_id,assistant_id,driver_id} = info[0];
        console.log(info);
        var schedule_id;
        
            return new Promise((resolve, reject) => {
                pool.getConnection(function(err, connection) {


                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!

                // Use the connection for get schedule id tob created and create schedule
                connection.query(`SHOW TABLE STATUS LIKE 'truck_schedule'`,[],function(error, results, fields){
                    // schedule id tobe created
                    schedule_id = results[0].Auto_increment;
                    console.log(schedule_id);

                // Use the connection for create schedule
                connection.query(`CALL assign_driver_and_assistant(?,?,?,now(),?,?,?,?)`,[schedule_id,route_id,departure_time,truck_id,assistant_id,driver_id,store_id], function (error, results, fields) {
                    console.log(results);
                    console.log(fields);

                // When done with the connection, release it.
                    connection.release();

                // Handle error after the release.
                    if (error) {
                        reject(error);
                    }

                    resolve(results) ;
                // Don't use the connection here, it has been returned to the pool.
                });
                })
                
                
            });
        })
    }

    /**
     * 
     * @param {mysql.pool} pool - connection pool to database
     * @param {store_id} store_id - store id of the manager
     * @param {request} req - request that containg customer details
     * @param {response} res - response to the front end if error occured
     * state - done
     * 
     */
    async get_routes(pool,res,store_id){

        
            return new Promise((resolve, reject) => {
                pool.getConnection(function(err, connection) {


                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!
                
                // Use the connection
                connection.query(`SELECT * FROM route WHERE store_id=?`,[store_id], function (error, results, fields) {
                    console.log(results);
                    console.log(fields);

                // When done with the connection, release it.
                    connection.release();

                // Handle error after the release.
                    if (error) {
                        reject(error)
                    }

                    resolve(results) ;
                // Don't use the connection here, it has been returned to the pool.
                });
            });
        })
    }

    /**
     * 
     * @param {mysql.pool} pool - connection pool to database
     * @param {store_id} store_id - store id of the manager
     * @param {request} req - request that containg customer details
     * @param {response} res - response to the front end if error occured
     * state - done
     * 
     */
    async get_trucks(pool,res,store_id){

        
            return new Promise((resolve, reject) => {
                pool.getConnection(function(err, connection) {


                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!
                
                // Use the connection
                connection.query(`SELECT * FROM truck WHERE store_id=?`,[store_id], function (error, results, fields) {
                    console.log(results);
                    // console.log(fields);

                // When done with the connection, release it.
                    connection.release();

                // Handle error after the release.
                    if (error) {
                        reject(error)
                    }

                    resolve(results) ;
                // Don't use the connection here, it has been returned to the pool.
                });
            });
        })
    }


    

}