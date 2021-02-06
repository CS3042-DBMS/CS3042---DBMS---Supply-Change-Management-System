let pool = require('../../database/connection');
const bcrypt = require('bcrypt');
const Driver = require('../../models/driver/driver');

async function getTruckShedule(request,response){
    try {
        const res = await Driver.getTruckShedule();
        const result = JSON.parse(JSON.stringify(res[0]))
        response.render('driver/truck_shedule',{result: result});
        
    } catch (error) {
        response.send(error.message);
        
    }
}
    async function addToJob(request,response) {
        // 1 means cart
        // if(error){
        //     return response.status(400).send(error.message);
        //     }
        try {
                if(request.body.method_type ==1){
                if(error){
                     return response.status(400).send(error.message);}
                    
                else{ await Driver.addToJob(request);}
               
            
        
             }
            }
    
            
         catch (error) {
            console.log(error);
        }
        response.redirect('back');
    }
    



exports.getTruckShedule = getTruckShedule;
exports.addToJob=addToJob;