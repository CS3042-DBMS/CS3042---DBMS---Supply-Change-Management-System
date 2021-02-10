let pool = require('../../database/connection');
const StoreManager = require('../../models/storemanager/storemanager');

async function getOrders(request,response){
    try {
        const orders = await StoreManager.getorders()
        response.send(orders)
    } catch (e) {

    }
}

exports.getOrders = getOrders;