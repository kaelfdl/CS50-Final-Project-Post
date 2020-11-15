const jwt = require('jsonwebtoken');
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcrypt');

// Models
const User = require('../models/User');

// Get the private key
const pathToPriv = path.join(__dirname, process.env.PATHTOPRIVATEKEY);
const PRIV_KEY = fs.readFileSync(pathToPriv, 'utf8');

class UserAPI {

    //------------ Active User Interaction Methods -----------

    // Retrieve Active User's Profile
    static async retrieveActiveUserProfile(user) {
        
        try {
            const id = user._id;

            if (!id) {
                return {
                    success: false,
                    message: 'User not found'
                };
            }

            if (!user) {
                return {
                    success: false,
                    message: 'User not found'
                };
            }

            return {
                success: true,
                user: {
                    id: user.id,
                    username: user.username,
                    email: user.email,
                    first_name: user.first_name,
                    last_name: user.last_name
                }
            };
        } catch (err) {
            console.log(err);
        }
    }


    // Issue JWT on login
    static async issueJWT(user) {
        const _id = user.id;
        const expiresIn = `${process.env.TOKENVALIDITY}`;

        const payload = {
            sub: _id,
            iat: Math.floor( Date.now() / 1000)
        };

        try {
            const signedToken = await jwt.sign(payload, PRIV_KEY, {expiresIn: expiresIn, algorithm: 'RS256'});
            
            return {
                token: 'Bearer ' + signedToken,
                expiresIn: expiresIn
            };

        } catch (err) {
            console.log(err);
        }
    }

    // User Login method
    static async loginUser(req) {
    
        try {
            const email = req.body.email;
            const password = req.body.password;

            const user = await User.findOne({email: email});

            if (!user) {
                return {
                    success: false,
                    message: 'Invalid Username or Password', 
                };
            }

            const decoded = await bcrypt.compare(password, user.password);
            
            if (!decoded) {
                return {
                    success: false,
                    message: 'Invalid Username or Password', 
                };
            }

            const token = await this.issueJWT(user);

            return {
                success: true,
                message: 'Login Successful',
                token: token
            };
            
        } catch (err) {
            console.log(err);
        }
    }


    // User Registration
    static async registerUser(req, callback) {

        try {
            const username = req.body.username;
            const password = req.body.password;
            const email = req.body.email;
            const firstName = req.body.first_name;
            const lastName = req.body.last_name;

            if (await User.findOne({username: username})) {
                return {
                    success: false,
                    message: 'Username already taken'
                };
            } else if (await User.findOne({email: email})) {
                return {
                    success: false,
                    message: 'Email already taken'
                };

            } else if (username && password && email && firstName && lastName) {
                const hashedPassword = await bcrypt.hash(password, 10);

                let newUser = new User({
                    username: username,
                    password: hashedPassword,
                    email: email,
                    first_name: firstName,
                    last_name: lastName,
                    display_photo: 'placeholder'
                });
                await newUser.save();

                const user = await User.findOne({username: username});

                const token = await this.issueJWT(user);

                return {
                    success: true,
                    message: 'Registration Successful',
                    token: token
                };

            } else {
                return {
                    success: false,
                    message: 'Please submit the required fields'
                };
            }
        } catch (err) {
            console.log(err);
        }
    }


    // Update User Information
    static async updateUserProfile(req) {
        try {
            const user = req.user;
            const firstName = req.body.first_name;
            const lastName = req.body.last_name;
        
            const updated = await User.updateOne({_id: user._id}, {
                $set:  {
                    first_name: firstName ? firstName : user.first_name,
                    last_name: lastName ? lastName : user.last_name
                }
            });

            const updatedUser = await User.findOne({_id: user.id});
            return {
                success: true,
                message: `User ${user.username}'s has been successfully updated`,
                updated_user: {
                    id: user.id,
                    username: user.username,
                    first_name: updatedUser.first_name,
                    last_name: updatedUser.last_name
                }
            };

        } catch (err) {
            console.log(err);
        }
    }

    // DELETE a USER profile
    // This also delete any Post and Photo created by the user
    static async deleteUserProfile(user) {
        try {
            // Delete Confirmation

            // Delete User
            const userID = user._id;
            const deletedUser = await User.deleteOne({_id: userID});

            return {
                success: true,
                message: `User ${user.username} has been successfully deleted`,
                deleted_user: {
                    id: user.id,
                    username: user.username
                }
            };
        } catch (err) {
            console.log(err);
        }
    }
}

module.exports = UserAPI;