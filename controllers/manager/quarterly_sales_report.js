let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewQuarterlySalesReport(request,response){

    try {
        const result = await Manager.viewQuarterlySalesReport();
        const jsresult = JSON.parse(JSON.stringify(result[0]));
        response.render('manager/quarterly_sales_report',{report: jsresult});
    }
    catch(error){
        response.send(error.message);
    }
}

exports.viewQuarterlySalesReport = viewQuarterlySalesReport;