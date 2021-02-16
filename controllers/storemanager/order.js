let pool = require('../../database/connection');
const StoreManager = require('../../models/storemanager/storemanager');

async function getOrders(request,response){
    try {
        const orders = await StoreManager.getorders(request)
        const result = JSON.parse(JSON.stringify(orders[0]))
        response.render('storemanager/orderList',{result: result});
    } catch (e) {

    }
}

async function getOrder(request,response){
    try{
         const order = await StoreManager.getorder(request.params.id)
         const result = JSON.parse(JSON.stringify(order[0]))
         response.render('storemanager/editTruckSchedule',{result: result});
        //  response.send(result)
    } catch (e) {

    }
}

// exports.getOrders = getOrders;
module.exports = {
    getOrders,
    getOrder
}