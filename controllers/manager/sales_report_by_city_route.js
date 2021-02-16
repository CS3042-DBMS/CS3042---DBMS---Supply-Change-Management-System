let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewSalesReport(request,response){

    try {
        const result = await Manager.viewSalesReport();
        const res = await Manager.viewSalesReportCity();
        const jsresult = JSON.parse(JSON.stringify(result[0]));

        const city_result = JSON.parse(JSON.stringify(res[0]));


        response.render('manager/sales_report_by_city_route',{report: jsresult, city_result: city_result});
        
        
    }
    catch(error){
        response.send(error.message);
    }
}


exports.viewSalesReport = viewSalesReport;