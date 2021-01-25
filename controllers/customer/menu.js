let pool = require('../../database/connection');
const bcrypt = require('bcrypt');
const Customer = require('../../models/customer/customer');

async function getMenu(request,response){
    try {
        const res = await Customer.getmenu();
        const result = JSON.parse(JSON.stringify(res[0]))
        response.render('customer/menu',{result: result});
        
    } catch (error) {
        response.send(error.message);
        
    }
}
    async function addToCart(request,response) {
        // 1 means cart
        try {
            if(request.body.method_type ==1){
                await Customer.add_to_cartAddition(request);
            }
    
            else if(request.body.method_type ==2){
                await Customer.add_to_cart();
    
    
            }
            
        } catch (error) {
            console.log(error);
        }
        response.redirect('back');
    }
    



exports.getMenu = getMenu;
exports.addToCart=addToCart;