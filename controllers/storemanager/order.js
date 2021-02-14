let pool = require('../../database/connection');
const StoreManager = require('../../models/storemanager/storemanager');

async function getOrders(request,response){
    try {
        const orders = await StoreManager.getorders(request)
        const result = JSON.parse(JSON.stringify(orders[0]))
        response.render('storemanager/orderList',{result: result});
        // response.send(orders)
    } catch (e) {

    }
}

exports.getOrders = getOrders;