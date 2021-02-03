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

    static add_to_cartAddition(request){
        return new Promise((resolve,reject) =>{
            pool.query("CALL add_to_cartAddition(?,?)",
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
    static add_to_cart(){
        return new Promise((resolve,reject) =>{
            pool.query("CALL add_to_cart()",
            [
            
            ],
            (error, results, fields) => {
                if (error) {
                    reject(error);
                };
                resolve(console.log('cart created'));
            }
        )

        })
        
    }
    

}