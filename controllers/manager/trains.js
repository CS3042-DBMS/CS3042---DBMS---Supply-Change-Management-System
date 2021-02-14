let pool = require('../../database/connection');
const bcrypt = require('bcrypt');

const Manager = require('../../models/manager/manager');

async function viewTrainSchedule(request,response){
    try {
        const res = await Manager.viewTrainSchedule();
        const result = JSON.parse(JSON.stringify(res[0]))

        const order_res = await Manager.viewOrders();
        const order_result = JSON.parse(JSON.stringify(order_res[0]))

        var realDate = new Date(result[0].time_schedule);
        var month = (realDate.getMonth()+1).toString();
        var date = realDate.getDate().toString();
        if(month.length == 1){
            month = "0"+month;
        }
        if(date.length == 1){
            date = "0"+date;
        }
        var d = realDate.getFullYear()+"-"+month+"-"+date+" "+realDate.toLocaleTimeString('en-US', { hour12: false });
        result[0].time_schedule = d;
        response.render('manager/trainschedule',{result: result, order_list: order_result});
        
    } catch (error) {
        response.send(error.message);
        
    }
}

exports.viewTrainSchedule = viewTrainSchedule;