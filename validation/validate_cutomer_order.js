const Joi = require('joi');

function validateCutomerOrder(order){
  

    const schema = Joi.object({
        'route_id'          : Joi.number().integer().positive().required(),
        'address'           :Joi.string().required()

        
    });

    return schema.validate(order);
}

exports.validateCutomerOrder = validateCutomerOrder;