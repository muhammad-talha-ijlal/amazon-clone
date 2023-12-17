const express= require('express');
const productRouter = express.Router();
const {product} = require('../model/product');


// api to get category product
// no post data but query the data 
// /api/cat-product?category=Essentials
// url?property 
productRouter.get("/api/cat-product",async (req,res)=>{
    try {
        console.log(req.query.category);// asking category from client 
        const products= await product.find({category:req.query.category}); //list of documnet to find particular item pass id inside ""
        res.json(products);
        
    } catch (error) {
        res.status(500).json({error:error.message});
    }

});

// api for searched product
// url/:parameter get passed
productRouter.get("/api/search-product/:name",async (req,res)=>{
    try {
        console.log(req.query.category);// asking category from client 
        const products= await product.find({name:{$regex:req.params.name,$options:"i"}});  // regex is used to find common pattern with i as The "i" stands for "ignore case". This means that the regular expression will match characters disregarding their case, so both uppercase and lowercase letters will be considered as equivalent.
        res.json(products);
        
    } catch (error) {
        res.status(500).json({error:error.message});
    }

});

//  create a post api to rate the product
productRouter.post("/api/rate-product",async (req,res)=>{
    try {
        // from dart file we are seending the data in jsonEncode
        const {id,rating,userId} =req.body;
        let products =await product.findById(id);
        // run the for loop for the rating products have
        //  if the product ave already been rated by the customer then you have to delete the previous rating of the user to that product
        // {
//            userid:"axz",
//            ratings:3.4    
        // }


        //  checking the user wheather it has given the rating already or not 
        for (let i = 0; i < products.ratings.length; i++) {
            if (products.ratings[i].userId == userId) {
                products.ratings.splice(i,1);// deleting from index of that rating 1 shows how many items want to delte
                break;
                
            }
            
        }
        //  creating a ratingSchema 
        const ratingSchema={
            userId:userId,
            rating,
        };
//  updating schema on the data base
        products.ratings.push(ratingSchema);
        products=products.save();
        res.json(products);

        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
})


// getting the deal of the day
//  product with the highest rating will be deal of the day
productRouter.get('/api/deal-of-day',async(req,res)=>{
    try {
        // getting all the products
        const products= await product.find({});
        // sort product on the basis of the ratng in decreasing order
        
          

        res.json(products);
        
    } catch (error) {
        res.status(500).json({error:error.message});

        
    }

});


module.exports = productRouter; // used to bind the file index
