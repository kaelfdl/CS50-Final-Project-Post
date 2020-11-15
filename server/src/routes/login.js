const express = require('express');
const User = require('../models/User');
const router = express.Router();

// Include the User Api for login functionality
const UserAPI = require('../utils/user-api');

// User Login
// Check authentication logic to be added
router.post('/', async (req, res, next) => {
    try {

        if (!req.body) {
            return res.status(400).json({
                success: false,
                error: 'PL30101',
                message: 'Bad Request'
            });
        }

        if (!req.body.email || !req.body.password) {
            return res.status(400).json({
                success: false,
                message: 'Please Enter a Valid Username and Password'
            });
        }

        const login = await UserAPI.loginUser(req);
        
        res.status(200).json(login);
        
    } catch (err) {
        console.log(err);
        res.status(400).json({
            success: false,
            error: 'PE30101',
            message: 'Internal Server Error'
        });
    }
});

module.exports = router;