const mongoose = require('mongoose');
const { productSchema} = require('./product');




// like a class 
const userScehma = mongoose.Schema({
    name:{
        required:true,
        type:String,
        trim: true // removing extra spaces

    },
    email:{
        required:true,
        type:String,
        trim:true,
        validate:{
            validator:(value)=>{
                //regex email validation
                const re =/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);

            },
            message:'Please Enter a valid email address'
        }
    },
    password:{
        required:true,
        type:String,
        validate:{
            validator :(value)=>{
                return value.length>6;
            },
            message:"Length not match up"
        }
    },
    address:{
        type:String,
        default:''
    },
    type:{
        type:String,
        default:'user',
    },
    // cart property is an array consisting of the product schema as well as 
    cart:[
        {
            product: productSchema,
            quantity:{
                type:Number,
                required :true
            }
        }

    ]
    
})


// sedning the data to other file 
const User = mongoose.model("User",userScehma);
module.exports = User;