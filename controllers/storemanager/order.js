let pool = require('../../database/connection');
const StoreManager = require('../../models/storemanager/storemanager');
 const {decodeToken} = require('../../middleware/authMiddleware') // add this middle ware to authenticate without login   


async function getOrders(request,response){
    const decodedToken = decodeToken(request);

    // extract the email
    const email = decodedToken.email;
    console.log(decodedToken.store_manager_name);
    try {
        const orders = await StoreManager.getorders(request,email)
        const result = JSON.parse(JSON.stringify(orders[0]))
        console.log(result)
        response.render('storemanager/orderList',{result: result});
    } catch (e) {

    }
}

async function getOrder(request,response){
    try{
         const order = await StoreManager.getorder(request.params.id)
         const result = JSON.parse(JSON.stringify(order[0]))

         const schedule_ids = await StoreManager.getschedules()
         const schedule_list = JSON.parse(JSON.stringify(schedule_ids[0]))

         response.render('storemanager/editTruckSchedule',{result: result, schedule_list: schedule_list});
        //  response.send(schedule_list)
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