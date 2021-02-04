let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewOrders(request,response){
    try {
        const res = await Manager.viewOrders();
        const result = JSON.parse(JSON.stringify(res[0]))
        //console.log(result[0].order_id);
        response.render('manager/vieworders',{result: result});
        
    } catch (error) {
        response.send(error.message);
        
    }
}

exports.viewOrders = viewOrders;