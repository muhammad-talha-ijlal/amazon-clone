const express= require('express');
const userRouter = express.Router();
const User=require("../model/user");
const {product} = require('../model/product');
const Order = require('../model/order');



userRouter.post('/user/add-to-cart',async (req,res)=>{
    try {
        const {id,user_id}=req.body;
        let products =await product.findById(id);
        // cart is in user model hence we can store in the provider instead of requesting it again
        let user=await User.findById(user_id);
//   mongodb have rray of object and object have propert of product: and then it have _id
        // // checking the user cart 
        if (user.cart.length == 0) { 
            // length is zero hence we can say that no product is added
            user.cart.push({product:products,quantity:1});

        }else{
            // product is already added
            let productFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(products._id)) {
                    // _id given by moggose id
                    productFound = true;

                    
                }
                
            }
            // product found hence quantity need to be increased
            if (productFound) {
                let producttt = user.cart.find((productt) =>
                   productt.product._id.equals(products._id)
            );
            producttt.quantity += 1;
                
            }else{
            // product not found hence push operations 
            user.cart.push({product:products,quantity:1});
                
 
            }

        }
        user = await user.save();
        res.json(user);



        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});


userRouter.delete('/user/remove-from-cart',async (req,res)=>{
    try {
        const {id,user_id}=req.body;
        let products =await product.findById(id);
        let user=await User.findById(user_id);

            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(products._id)) {
                    // _id given by moggose id
                    if (user.cart[i].quantity == 1) {
                    user.cart.splice(i,1);// delete the product
                        
                    }else{
                        user.cart[i].quantity -=1;// delet the product

                    }
                }
            }
        user = await user.save();
        res.json(user);



        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});

userRouter.post('/user/save-user-address',async (req,res)=>{
    try {
        const {address,user_id}=req.body;
        let user=await User.findById(user_id);
        user.address=address;

            

        user = await user.save();
        res.json(user);



        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});

// order product
userRouter.post('/user/order-product',async (req,res)=>{
    try {
        const {cart,totalPrice,address,user_id}=req.body;
        let user=await User.findById(user_id);
        let products = [];
        for (let i = 0; i < cart.length; i++) {
            let Product=await product.findById(cart[i].product._id); // getting the product
            if (Product.quantity >= cart[i].quantity) {
                Product.quantity -= cart[i].quantity;
                products.push({product:Product,quantity:cart[i].quantity});
                await Product.save();
            }else{
                return res.status(400).json({msg:'Some Items are of Out Of stock'});

            }
            
        }

        user.cart=[]; // empty the cart
        user =user.save();

        let order=new Order({
            products:products,
            totalPrice:totalPrice,
            address:address,
            userId:user_id,
            orderedAt: new Date().getTime(),
        })

        order=await order.save();

            

        res.json(order);



        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});

userRouter.post('/api/orders/me',async (req,res)=>{
    try {
        const {userId}=req.body;
        let orders= await Order.find({userId});
        res.json(orders);

        

        


        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});

userRouter.post('/user/turn-seller',async (req,res)=>{
    try {
        const {userId}=req.body;
        let user=await User.findById(userId);

        user.type="admin";
        user = user.save();
        res.json(user);
        
        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});

userRouter.post('/user/turn-user',async (req,res)=>{
    try {
        const {userId}=req.body;
        let user=await User.findById(userId);

        user.type="user";
        user = user.save();
        res.json(user);

        

        


        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});







module.exports = userRouter;
