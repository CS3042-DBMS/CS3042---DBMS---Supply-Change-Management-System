/* eslint-disable linebreak-style */
const express = require('express');
const app = express();
const cors = require('cors');
const dotenv = require('dotenv');
const pool = require('./models/connection');
dotenv.config();

app.use(express.json());//send data with json format

app.use(express.urlencoded({extended:false}));//not sending any dorm data

app.use(cors()); // when we are having api call this will not block it and send data to backend


app.listen(process.env.PORT || 5000, () => {
  console.log('app is running on port:' + process.env.PORT || 5000);
});