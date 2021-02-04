let loginUserInstance = null;

class LogInUser{

    // get this class object
    static getLoginUserInstance(){
        return loginUserInstance ? loginUserInstance : new LogInUser();
    }

    // get type of the user before login to redirect correctly
    async getUserInfo(pool,res,req,...cusDetails){

        return new Promise((resolve, reject) => {
                pool.getConnection(function(err, connection) {

                let { email } = cusDetails[0];

                if (err) {
                    res.status(500).send('Internal Server Error')
                    res.end();
                    throw err;
                } // not connected!
                
                // Use the connection
                connection.query(`CALL User(?)`,[email], function (error, results, fields) {
                    

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

module.exports = LogInUser;