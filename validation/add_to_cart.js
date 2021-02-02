const Joi = require('joi');

function validateAddToCart(num){
  

    const schema = Joi.object({
        'quantity'          : Joi.number().integer().positive().required(),
        'prod'              :Joi.required(),
        'method_type'       :Joi.required()
        
    });

    return schema.validate(num);
}

exports.validateAddToCart = validateAddToCart;