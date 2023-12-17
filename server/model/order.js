const mongoose=require('mongoose');
const { productSchema } = require('./product');


const orderSchema=mongoose.Schema({
    products:[
        {
            product:productSchema,
            quantity :{
                type:Number,
                required : true
            }
        }
    ],
    totalPrice:{
        type:Number,
        required:true,
    },
    address:{
        type:String,
        required:true

    },
    userId:{
        type:String,
        requried: true
    },
    orderedAt:{
        type:Number,
        required:true
    },
    status:{
        type:Number,
        default:0 // 0 is pending 1 sent from the seller  2 user  recieved 3 both the party agreed
    }
});


const Order=mongoose.model('MyOrders',orderSchema);
module.exports=Order;