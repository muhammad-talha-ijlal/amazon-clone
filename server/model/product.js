const mongoose=require("mongoose");
const ratingSchema = require("./rating");

const productSchema=mongoose.Schema({
    name:{
        type:String,
        required:true,
        trim:true,
    },
    description:{
        type:String,
        required:true,
        trim:true,
    },
    images : [{// arrray of images having these property
        type:String,
        required:true,
    }],
    quantity:{
        type:Number,
        required:true
    },
    price:{
        type:Number,
        required:true
    },
    category:{
        type:String,
        required:true
    },
    // ratings
    ratings:[ratingSchema],


});




// creating model on the data base 
const product = mongoose.model('Product_info',productSchema); // name on mongo db is product_info
module.exports={product,productSchema};