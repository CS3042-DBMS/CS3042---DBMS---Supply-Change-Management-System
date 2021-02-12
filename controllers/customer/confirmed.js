
const Customer = require('../../models/customer/customer');

async function getConfirmedOrders(request,response){
    try {
        const res = await Customer.getConfirmed(request);
        const order = JSON.parse(JSON.stringify(res[0]))
        response.render('customer/confirmed',{order:order});
        
    } catch (error) {
        response.send(error.message);
        
    }
}
    
    



exports.getConfirmedOrders=getConfirmedOrders;
