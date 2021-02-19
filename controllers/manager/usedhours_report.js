let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewUsedHoursReport(request,response){

    try {
        const result = await Manager.viewUsedHoursReport(request);
        const jsresult = JSON.parse(JSON.stringify(result[0]));
        response.render('manager/usedhours_report',{report: jsresult, year: request.body.selectyear});
    }
    catch(error){
        response.send(error.message);
    }
}

exports.viewUsedHoursReport = viewUsedHoursReport;