let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewQuarterlySalesReport(request,response){

    const result = await Manager.viewQuarterlySalesReport();
    const jsresult = JSON.parse(JSON.stringify(result[0]));
}

exports.viewQuarterlySalesReport = viewQuarterlySalesReport;