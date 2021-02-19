let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewAssistantWorkingHoursReport(request,response){

    try {
        const result = await Manager.viewAssistantWorkingHoursReport(request);
        const jsresult = JSON.parse(JSON.stringify(result[0]));
        response.render('manager/assistant_workinghours_report',{report: jsresult });
    }
    catch(error){
        response.send(error.message);
    }
}

exports.viewAssistantWorkingHoursReport = viewAssistantWorkingHoursReport;