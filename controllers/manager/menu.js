let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewOrders(request,response){
    try {
        const res = await Manager.viewOrders;
        const result = JSON.parse(JSON.stringify(res[0]))
        console.log(request);
        response.render('manager/menu',{result: result});
        
    } catch (error) {
        response.send(error.message);
        
    }
}

exports.viewOrders = viewOrders;