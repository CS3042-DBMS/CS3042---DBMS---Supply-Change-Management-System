

const StoreManager = require('../../models/storemanager/storemanager').getStoreManagerInstance();
let pool = require('../../database/connection');
const jwt = require('jsonwebtoken');
const {decodeToken} = require('../../middleware/authMiddleware') // add this middle ware to authenticate without login


/****
 * TODO
 *  - need to validate request data
 *  - check user exist prior to create new entry in db 
 *  - error handling
 *  - login function
 */

module.exports.get_assistants = (req,res) => {

    let {route_id,departure_time} = req.body;
    const decodedToken = decodeToken(req);

    // extract the email
    const store_id = decodedToken.store_id;

        StoreManager.get_assistants(pool,res,route_id,departure_time,store_id)
        .then((result) => {
            
            console.log(result)
            res.status(200).json({assistants:result})

        })
}
/****
 * TODO
 *  - need to validate request data
 *  - check if user exist
 *  - if user exist then get type of the user
 *  - error handling
 */

module.exports.get_drivers = (req,res) => {
    const decodedToken = decodeToken(req)
    let {route_id,departure_time} = req.body;

        // extract the store_id
        const store_id = decodedToken.store_id;

        StoreManager.get_drivers(pool,res,route_id,departure_time,store_id)
        .then((result) => {
            
            console.log(result)
            res.status(200).json({drivers:result})

        })
        
}

// get truck schedule function
module.exports.get_truck_schedules = (req,res) => {
    const decodedToken = decodeToken(req);

    // extract the store_id
    const store_id = decodedToken.store_id;

    // getting all schedules
    StoreManager.get_truck_schedules(pool,res,store_id)
    .then(result => {

        // render view
    res.render('storemanager/viewtruckschedules', {result:result});

    }).catch(err => {
        res.status(400).json({error:'error occured while getting schedule list'})
        console.log('[error] - getting schedule list [database] - contoller/createschedule '+ err.sqlMessage);
})
}

module.exports.create_new_schedule_post = (req,res) => {
    const decodedToken = decodeToken(req)
    const schedule_infromation_to_send_to_the_database = req.body;
    
    // extract the store_id
    const store_id = decodedToken.store_id;
    console.log(store_id)
    StoreManager.create_new_schedule_post(pool,res,store_id,schedule_infromation_to_send_to_the_database)
    .then((routes_info) => {

        // redirect to the viw schedules
        res.status(302).json({
                        message:'schedule creation success',
                        error:false,
                        redirect:"/storemanager/createschedule/viewschedules"
                })

    })
    .catch(err => {

        // error occured while getting routes list
        res.status(400).json({error:'error occured while creating schedule'})
        console.log('[error] - error occured while creating schedule [database] - controller/createschedule'+err.sqlMessage)
    })
}

module.exports.create_new_schedule_get = async (req,res) => {
    const decodedToken = decodeToken(req);
    var trucks;
    var routes;

    // extract the store_id
    const store_id = decodedToken.store_id;
    
    // get trucks that able to deploy
    await StoreManager.get_trucks(pool,res,store_id)
    .then((trucks_info) => {

        // truck list arrived
        trucks = trucks_info;

    }).catch(err => {

        // error occured while getting truck list
        res.status(400).json({error:'error occured while getting truck list'})
        console.log('[error] - error occured while getting truck list [database] - controller/createschedule'+err.sqlMessage)
    })

    // get routes that need to assign
    await StoreManager.get_routes(pool,res,store_id)
    .then((routes_info) => {

        // routes list arrived
        routes = routes_info;

    }).catch(err => {

        // error occured while getting routes list
        res.status(400).json({error:'error occured while getting truck list'})
        console.log('[error] - error occured while getting truck list [database] - controller/createschedule'+err.sqlMessage)
    })

    // send view
    res.render('storemanager/createtruckschedule',{trucks:trucks, routes:routes})
}