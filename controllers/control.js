/* eslint-disable linebreak-style */


// boliler plate for executing queries
const pool = require('./models/connection');

pool.getConnection(function(err, connection) {
  if (err) {throw err;} // not connected!

  let Id = 99; // field that we want 

  // Use the connection
  connection.query('SELECT something FROM crud_app WHERE id=?',[Id], function (error, results, fields) {
    console.log(results);
    console.log(fields);

    // When done with the connection, release it.
    connection.release();

    // Handle error after the release.
    if (error) {throw error;}

    // Don't use the connection here, it has been returned to the pool.
  });
});
