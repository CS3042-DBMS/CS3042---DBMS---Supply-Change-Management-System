const express = require('express');
const {getOrders, getOrder, updateOrder} = require('../../controllers/storemanager/order') // 
const router = express.Router();


router.get('/getorders',getOrders );
// router.put('/getorders/:id',updateOrder)

router.get('/editorder/:id',getOrder);
// router.put('/getorders/:id',updateOrder)

// router.post('/editorder/',(req,res) => {
//     console.log(req)
//     res.send(req.body)
// });
router.post('/editorder/',updateOrder);
// router.put('/getorders/:id',updateOrder)

module.exports = router;