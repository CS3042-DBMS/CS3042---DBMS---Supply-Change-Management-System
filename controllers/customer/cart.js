let pool = require('../../database/connection');
const bcrypt = require('bcrypt');
const Customer = require('../../models/customer/customer');

async function getCart(request,response){
    try {
        const res = await Customer.getCart();
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

exports.getCart = getCart;
exports.removeCartItem=removeCartItem;