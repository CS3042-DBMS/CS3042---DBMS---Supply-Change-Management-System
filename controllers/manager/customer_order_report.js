let pool = require('../../database/connection');
const Manager = require('../../models/manager/manager');

async function getcustomerOrderReport(request,response){
    try {
        const res = await Manager.getcustomerOrderReport();
        const order = JSON.parse(JSON.stringify(res[0]));
        response.render('manager/customer_order_report',{order: order, req:request});
        
    } catch (error) {
        response.send(error.message);
        
    }
}
  



exports.getcustomerOrderReport=getcustomerOrderReport;