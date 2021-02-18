let pool = require('../../database/connection');
const StoreManager = require('../../models/storemanager/storemanager');
 const {decodeToken} = require('../../middleware/authMiddleware') // add this middle ware to authenticate without login   


async function getOrders(request,response){
    const decodedToken = decodeToken(request);

    // extract the email
    const email = decodedToken.email;
    try {
        const orders = await StoreManager.getorders(request,email)
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

async function updateOrder(request,response){
    const decodedToken = decodeToken(request);

    // extract the email
    const email = decodedToken.email;
    try{
         const order = await StoreManager.updateorder(request)
         const orders = await StoreManager.getorders(request,email)
         const result = JSON.parse(JSON.stringify(orders[0]))
         response.render('storemanager/orderList',{result: result});
    } catch (e) {

    }
}

// exports.getOrders = getOrders;
module.exports = {
    getOrders,
    getOrder,
    updateOrder
}