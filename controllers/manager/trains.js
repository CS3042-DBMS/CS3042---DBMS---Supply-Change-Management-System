let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewTrainSchedule(request,response){
    try {
        const res = await Manager.viewTrainSchedule();
        const result = JSON.parse(JSON.stringify(res[0]))
        //console.log(res[0][0].train_name);
        response.render('manager/trainschedule',{result: result});
        
    } catch (error) {
        response.send(error.message);
        
    }
}

exports.viewTrainSchedule = viewTrainSchedule;