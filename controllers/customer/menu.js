let pool = require('../../database/connection');
const {validateAddToCart} = require('../../validation/add_to_cart');
const bcrypt = require('bcrypt');
const Customer = require('../../models/customer/customer');

async function getMenu(request,response){
    try {
        const res = await Customer.getmenu();
        const result = JSON.parse(JSON.stringify(res[0]))

        response.render('customer/itemList',{result: result });

        
    } catch (error) {
        
        response.send(error.message);
        
    }
}
    async function addToCart(request,response) {
        // 1 means cart
        const {error} = validateAddToCart(request.body);
        // if(error){
        //     return response.status(400).send(error.message);
        //     }
        try {
                if(request.body.method_type ==1){
                if(error){
                     return response.status(400).send(error.message);}
                    
                else{ await Customer.add_to_cart(request);}
               
            
        
             }
            }
    
            
         catch (error) {
            console.log(error);
        }
        response.redirect('back');
    }
    



exports.getMenu = getMenu;
exports.addToCart=addToCart;