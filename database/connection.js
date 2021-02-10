const mysql = require('mysql');
const dotenv = require('dotenv');
dotenv.config();
var pool  = mysql.createPool({
  connectionLimit : process.env.CONNECTIONLIMIT,
  host            : process.env.HOST,
  user            : process.env.USER,
  password        : process.env.PASSWORD,
  database        : process.env.DATABASE,
  waitForConnections:true,
  queueLimit:900
});

pool.on('acquire', function (connection) {
  //console.log('Connection %d acquired', connection.threadId);
});

pool.on('connection', function (connection) {
  console.log('connected')
});

pool.on('enqueue', function () {
  console.log('Waiting for available connection slot');
});
module.exports = pool;