let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewDriverWorkingHoursReport(request,response){

    try {
        const result = await Manager.viewDriverWorkingHoursReport(request);
        const jsresult = JSON.parse(JSON.stringify(result[0]));
        response.render('manager/driver_workinghours_report',{report: jsresult });
    }
    catch(error){
        response.send(error.message);
    }
}

exports.viewDriverWorkingHoursReport = viewDriverWorkingHoursReport;