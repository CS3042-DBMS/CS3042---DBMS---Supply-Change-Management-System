let authCustomerInstance = null;

class AuthCustomer{

    static getAuthCustomerInstance(){
        return authCustomerInstance ? authCustomerInstance : new AuthCustomer();
    }

    /**
     * 
     * @param {mysql.pool} pool - connection pool to database
     * @param {response} res - response to the after signed up
     * @param {request} req - request that containg customer details
     * @param {cusDetails} req - details of the customer including hashed password
     * 
     */
    async registerCustomer(pool,req,res,...cusDetails){

        
            return new Promise((resolve, reject) => {
                pool.getConnection(function(err, connection) {

                let { name,address,city,hash,email } = cusDetails[0];

                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!
                
                // Use the connection
                connection.query(`INSERT INTO customer (customer_name,customer_address,city,password,email) VALUES (?,?,?,?,?)`,[name,address,city,hash,email], function (error, results, fields) {
                    // console.log(results);
                    // console.log(fields);

                // When done with the connection, release it.
                    connection.release();

                // Handle error after the release.
                    if (error) {
                        reject(error)
                        throw error;
                    }

                    resolve(results) ;

                // Don't use the connection here, it has been returned to the pool.
                });
            });
        })
    }
}
        module.exports = AuthCustomer;