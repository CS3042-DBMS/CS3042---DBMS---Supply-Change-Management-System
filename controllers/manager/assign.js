let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function assignOrders(request,response){
    try {
        const res = await Manager.assignOrders(request);
        //const result = JSON.parse(JSON.stringify(res))
        //console.log(res[0][0].train_name);
        //response.render('manager/trainschedule');
        
    } catch (error) {
        console.log(error.code);
        response.redirect('/manager_func/trainschedule/trains?status='+error.code);
        // response.send(error.message);
        
    }
    response.redirect('/manager_func/trainschedule/trains?status=successful');
    // response.redirect('back');

}

exports.assignOrders = assignOrders;
