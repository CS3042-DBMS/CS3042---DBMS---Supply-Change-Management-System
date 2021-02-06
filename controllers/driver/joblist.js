let pool = require('../../database/connection');
const bcrypt = require('bcrypt');
const Driver = require('../../models/driver/driver');

async function getJoblist(request,response){
    try {
        const res = await Driver.getJoblist();
        const result = JSON.parse(JSON.stringify(res[0]));
        response.render('driver/joblist',{result: result, req:request });
        
    } catch (error) {
        response.send(error.message);
        
    }
}
async function removeJob(request,response){
    try {
         await Driver.removeJob(request);
        
       
        
    } catch (error) {
        response.send(error.message);
        
    }
    response.redirect('back');
    
    
}

exports.getJoblist = getJoblist;
exports.removeJob=removeJob;