let pool = require('../../database/connection');
const bcrypt = require('bcrypt');
const Customer = require('../../models/customer/customer');
const {validateCutomerOrder} = require('../../validation/validate_cutomer_order');

async function getCart(request,response){
    try {
        const res = await Customer.getCart(request);
        const res2 = await Customer.getTotalPrice(request);
        const result = JSON.parse(JSON.stringify(res[0]));
        const total = JSON.parse(JSON.stringify(res2[0]));
        response.render('customer/cart',{result: result, req:request ,total:total});
        
    } catch (error) {
        response.send(error.message);
        
    }
}
async function removeCartItem(request,response){
    try {
         await Customer.removeCartItem(request);
        
       
        
    } catch (error) {
        response.send(error.message);
        
    }
    response.redirect('back');
    
    
}
async function createOrder(request,response){
    const {error} = validateCutomerOrder(request.body);
    if(error){
        return response.status(400).send(error.message);
    }

    try {
        await Customer.createOrder(request);
        
    } catch (error) {
       return  response.status(400).send(error.message);
    }

    response.redirect('view');

}
async function getRoutes(request,response){
    try {
        const res = await Customer.getRoutes();
        const result = JSON.parse(JSON.stringify(res[0]))
        response.render('customer/order',{result: result });
        
    } catch (error) {
        response.send(error.message);
        
    }
}

exports.getCart = getCart;
exports.removeCartItem=removeCartItem;
exports.createOrder=createOrder;
exports.getRoutes=getRoutes;