const express = require('express');
const router = express.Router();
const UserAPI = require('../utils/user-api');

// Models
const User = require('../models/User');

// User Registration
// Check authentication logic to be added
router.post('/', async (req, res, next) => {

    try {
        if (!req.body) {
            return res.status(400).json({
                success: false,
                error: 'PR20101',
                message: 'Bad Request'
            });
        }

        if (!req.body.username || !req.body.password) {
            return res.status(200).json({
                success: false,
                message: 'Please Enter a Valid Username and Password'
            });
        }
        
        

        const register = await UserAPI.registerUser(req);
        
        if (!register.success) {
            return res.status(400).json(register);
        }

        return res.status(200).json(register).end();


    } catch (err) {
        console.log(err);
        res.status(400).json({
            success: false,
            error: 'PE20102',
            message: 'Internal Server Error'
        });
    }
});


module.exports = router;