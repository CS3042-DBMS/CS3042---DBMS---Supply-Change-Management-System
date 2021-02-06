let pool = require('../../database/connection');

module.exports= class Customer {
    static getmenu() {
        return new Promise((resolve, reject) => {
            pool.query("CALL getMenu()",
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
    static createOrder(request) {
        return new Promise((resolve, reject) => {
            pool.query("CALL create_order (?,?)",
                [
                    request.body.route_id,
                    request.body.address
                    
    
                ],
                function (error, results, fields) {
                    if (error) {
                        reject(error);
                    };
                    resolve(console.log("entered sucessfully"));
                }
            )
        })
    
      
    }
    static getRoutes() {
        return new Promise((resolve, reject) => {
            pool.query("CALL getRoutes()",
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