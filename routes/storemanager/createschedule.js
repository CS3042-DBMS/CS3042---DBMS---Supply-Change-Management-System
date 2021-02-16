/* eslint-disable linebreak-style */
const { Router } = require('express');
const router = Router();
const createschedule = require('../../controllers/storemanager/createschedule')


// get all eligible assistants for new job
/**
 * route - http://localhost:5000/storemanager/createschedule/getassistants
 */
router.post('/getassistants',createschedule.get_assistants)


// get all eligible drivers for new job
/**
 * route - http://localhost:5000/storemanager/createschedule/getdrivers
 */
router.post('/getdrivers', createschedule.get_drivers)


// view all truck schedules - schuold initiate first
/**
 * route - http://localhost:5000/storemanager/createschedule
 */
router.get('/', createschedule.get_truck_schedules)


// creating a new schedule route
/**
 * route - http://localhost:5000/storemanager/createschedule/createnewschedule
 */
router.post('/createnewschedule', createschedule.create_new_schedule_post)

// get view of creating a new schedule route
/**
 * route - http://localhost:5000/storemanager/createschedule/createnewschedule
 */
router.get('/createnewschedule', createschedule.create_new_schedule_get)


module.exports = router;