let pool = require('../../database/connection');
const Manager = require('../../models/manager/manager');

async function getMostOrderItems(request,response){
    try {
        const res = await Manager.getMostOrderItems();
        const result = JSON.parse(JSON.stringify(res[0]));
        response.render('manager/items_with_most_orders',{result: result , req:request});
        
    } catch (error) {
        response.send(error.message);
        
    }
}
  



exports.getMostOrderItems=getMostOrderItems;