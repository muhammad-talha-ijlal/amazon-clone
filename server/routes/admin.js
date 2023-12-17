//  contains all the functions of the admin

const express= require('express');
const adminRoute = express.Router();
const {product} = require('../model/product');
const Order = require('../model/order');


// creating api for adding route
// post 
adminRoute.post('/admin/add-product',async (req,res)=>{
    try {
        // taking input from the admin
        const {name,description,images,quantity,price,category}=req.body;
        //  let allow us to change 
        let Product=product({
            name,description,images,quantity,price,category
        });
        Product = await Product.save();  // Product get saved
        res.json(Product);
        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});


// to get all  the product 
adminRoute.get("/admin/get-product",async (req,res)=>{
    try {
        const products= await product.find({}); //list of documnet to find particular item pass id inside ""
        res.json(products);
        
    } catch (error) {
        res.status(500).json({error:error.message});
    }

});

// to delete the product through aadmin panel
 adminRoute.post("/admin/delete-product",async (req,res)=>{
    try {
        const {id}=req.body;
        const products= await product.findByIdAndDelete(id); // particular will get deleted 
        res.json(products);
        

        
    } catch (error) {
        res.status(500).json({error:error.message});

        
    }
 });

 adminRoute.get("/admin/get-order-product",async (req,res)=>{
    try {
        const orders= await Order.find({}); //list of documnet to find particular item pass id inside ""
        res.json(orders);
        
    } catch (error) {
        res.status(500).json({error:error.message});
    }

});

adminRoute.post("/admin/update-order",async (req,res)=>{
    try {
        const {id,status}=req.body
        let orders= await Order.findById(id);
         //list of documnet to find particular item pass id inside ""
         orders.status =status;
         orders = await orders.save();

        res.json(orders);
        
    } catch (error) {
        res.status(500).json({error:error.message});
    }

});

adminRoute.get('/admin/analytics',async(req,res)=>{
    try {
        const orders=await Order.find();
        let totalEarning =0;

        for (let i = 0; i < orders.length; i++) {
            if (!orders[i].products || !Array.isArray(orders[i].products)) {
                continue; // Skip this iteration if products array is not defined or not an array
            }

            for (let j = 0; j < orders[i].products.length; j++) {
                const product = orders[i].products[j];

                if (!product || !product.quantity || !product.product || !product.product.price) {
                    continue; // Skip this iteration if required properties are not defined
                }

                totalEarning += product.quantity * product.product.price;
            }
        }

        // category wise product
        let MobilesEarning =await fetchCategoryWiseProduct('Mobiles');
        let EssentialsEarning =await fetchCategoryWiseProduct('Essentials');

        let AppliancesEarning =await fetchCategoryWiseProduct('Appliances');
        let BooksEarning =await fetchCategoryWiseProduct('Books');
        let FashionEarning =await fetchCategoryWiseProduct('Fashion');

        let earning ={
            totalEarning,
            MobilesEarning,
            EssentialsEarning,
            AppliancesEarning,
            BooksEarning,
            FashionEarning
        };

        res.json(earning);


        

        
    } catch (error) {
        res.status(500).json({error:error.message});

        
    }
})

async function fetchCategoryWiseProduct(category) {
    let earning = 0;
    let categoryOrders = await Order.find({
        'products.product.category': category,
    });

    for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; j < categoryOrders[i].products.length; j++) {
            earning += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
        }
    }

    return earning;
}


// connect to index file
module.exports = adminRoute;
