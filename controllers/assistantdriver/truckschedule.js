let pool = require('../../database/connection');
const bcrypt = require('bcrypt');
const AssistantDriver = require('../../models/assistantdriver/assistantdriver');

async function gettruckschedule(request,response){
    try {
        const res = await AssistantDriver.gettruckschedule(request);
        const result = JSON.parse(JSON.stringify(res[0]))
        

        response.render('assistantdriver/truckschedule',{result: result});
        
    } catch (error) {
        
        response.send(error.message);
        
    }
}
    
    



exports.gettruckschedule = gettruckschedule;
