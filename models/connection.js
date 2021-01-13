const mysql = require('mysql');
const dotenv = require('dotenv');
dotenv.config();
var pool  = mysql.createPool({
  connectionLimit : process.env.CONNECTIONLIMIT,
  host            : process.env.HOST,
  user            : process.env.USER,
  password        : process.env.PASSWORD,
  database        : process.env.DATABASE
});

module.exports = pool;