// no listening required as already done in index
const express = require("express");
const User=require("../model/user");
const bycryptjs=require('bcryptjs');// used for encryption and decryption for passwrod hasing
const jst = require('jsonwebtoken');
const authRouter=express.Router();




// sign up api 
authRouter.post('/api/signup',async(req,res)=>{
    // get the data from the client 
    // post the data in the database 
    // return data to the user 

    try{
        
    // get data from req.body
    req.body;// data will be in map
    const {name ,email,password}=req.body;

    const exhistUser=await User.findOne({email});
    if (exhistUser) {
        return res.status(400).json({msg:"User already exhist"});
        
    }

    // creating an instance for user 
// for passwrod encryption
    const hashpass=await bycryptjs.hash(password,8); // hashing 8 is salt 
    let user =new User({
        email,
        password:hashpass,
        name
    })

    // saving a new account 
    // id unique ide
    // _v number of files edited
    user = await user.save();
    // it will post data
    res.json(user);
    }catch(e){
        res.status(500).json({error: e.message});

    }


    // post data in database need to connect with db
})

// sign in api 
// jsonwebtoken 
// have to use hashing dycrypt the daa 
authRouter.post('/api/signin',async (req,res)=>{

    try {
        // taking inout from the user 
        const {email,password} =req.body;

        // user exhist 
        const user_rec= await User.findOne({email});

        // user is  null here 
        if (!user_rec) {
            return res.status(400).json({msg: "User with this email dont exhist!"})
        }

        // user exhist checking the data 
        const isMatch=await bycryptjs.compare(password,user_rec.password); // password comparision
        if (!isMatch) {
           return  res.status(400).json({msg: "Incorrect Password"});            
        }

        const token=jst.sign({id:user_rec._id},"passwordKey");
        res.json({token,...user_rec._doc});// object destructuring ... like {"name":"user_rec.name"}
        
    } catch (error) {
        res.status(500).json({error : error.message});
        
    }
})


authRouter.post('/api/userdetails',async (req,res)=>{
    try {
        const {email,password} =req.body;
        const user_rec= await User.findOne({email});
        res.json({...user_rec._doc});

        
    } catch (error) {
        
    }

})





// to access variable outside the file 
module.exports = authRouter;