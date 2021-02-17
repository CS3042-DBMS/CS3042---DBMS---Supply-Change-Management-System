let pool = require('../../database/connection');
const bcrypt = require('bcrypt');
const Driver = require('../../models/driver/driver');

async function gettruckschedule(request,response){
    try {
        const res = await Driver.gettruckschedule();
        const result = JSON.parse(JSON.stringify(res[0]))
        

        response.render('driver/truckschedule',{result: result});
        
    } catch (error) {
        
        response.send(error.message);
        
    }
}
    
    



exports.gettruckschedule = gettruckschedule;
