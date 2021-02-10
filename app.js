/* eslint-disable linebreak-style */
const express = require('express');
const app = express();
const cors = require('cors');
const dotenv = require('dotenv');
const authRoutes = require('./routes/authroutes/authroute');
const routes=require('./routes')
const cookiepass = require('cookie-parser');




dotenv.config();





// middlewares
app.use(express.json());//send data with json format
app.use(express.urlencoded({extended:false}));//not sending any dorm data
app.use(express.static(__dirname+'/public'));//send data with json format
app.use(cookiepass()); // middle ware for setting up cookies
app.use(cors()); // when we are having api call this will not block it and send data to backend


















// view engine
app.set('view engine','ejs')

// routes
app.use('/', routes);

app.listen(process.env.PORT || 5000, () => {
  console.log('app is running on port:' + process.env.PORT || 5000);
});
