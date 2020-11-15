const express = require('express');
const router = express.Router();
const UserAPI = require('../utils/user-api');

// Model
const User = require('../models/User');

// Passport Auth
const passport = require('passport');
require('../config/passport-config')(passport);



//------------ Active User Routes -----------

// Get Active User profile
// Protected
// Check authentication logic to be added
router.get('/me', passport.authenticate('jwt', {session: false}), async (req, res, next) => {
    try {
        const user = req.user;
        
        if (!user) {
            return res.status(400).json({
                success: false,
                error: 'GU10101',
                message: 'Bad Request'
            });
        }

        const profile = await UserAPI.retrieveActiveUserProfile(user);
        
        res.status(200).json(profile);
        
    } catch (err) {
        console.log(err);
        res.status(400).json({
            success: false,
            error: 'GE10101',
            message: 'Internal Server Error'
        });
    }
});

// Update User Profile
// Protected
// Check authentication logic to be added
router.patch('/me', passport.authenticate('jwt', {session: false}), async (req, res, next) => {
    try {
        const user = req.user;
        if (!user) {
            return res.status(400).json({
                success: false,
                error: 'UU10101',
                message: 'Bad Request'
            });
        }

        const updatedProfile = await UserAPI.updateUserProfile(req);
        
        res.status(200).json(updatedProfile);
        
    } catch (err) {
        console.log(err);
        res.status(400).json({
            success: false,
            error: 'UE10101',
            message: 'Internal Server Error'
        });
    }
});

// Delete User Profile
// Protected
// Check authentication logic to be added
router.delete('/me', passport.authenticate('jwt', {session: false}), async (req, res, next) => {
    try {
        const user = req.user;
        if (!user) {
            return res.status(400).json({
                success: false,
                error: 'DU10101',
                message: 'Bad Request'
            });
        }

        const deletedProfile = await UserAPI.deleteUserProfile(user);
        
        res.status(200).json(deletedProfile);
        
    } catch (err) {
        console.log(err);
        res.status(400).json({
            success: false,
            error: 'DE10101',
            message: 'Internal Server Error'
        });
    }
});


module.exports = router;