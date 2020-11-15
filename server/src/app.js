if (process.env.NODE_ENV !== 'production') {
    require('dotenv').config();
}
const PORT = process.env.PORT;
const DBURL = process.env.DBURL;

const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const passport = require('passport');

const app = express();

// Middlewares
app.use(bodyParser.json());
app.use(passport.initialize());

// Routes
const usersRoute = require('./routes/users');
const loginRoute = require('./routes/login');
const signupRoute = require('./routes/signup');

app.use('/signup', signupRoute);
app.use('/login', loginRoute);
app.use('/users', usersRoute);

require('./config/passport-config')(passport);

mongoose.connect(DBURL, {useNewUrlParser: true, useUnifiedTopology: true, useFindAndModify: false }, 
    () => console.log('🌱 Connected to database'));

app.get('/', (req, res, next) => {
    passport.authenticate('jwt', {session: false},
    function (err, user, info) {
        if (err || !user) {
            return res.status(403).json({success: false, message: "Unauthorized Access"});
        } else {
            return res.status(200).json({success: true, message: 'Welcome to Swirl'});
        }
    })(req, res, next);
})

app.listen(PORT, () => console.log(`🚀 Server online at http://localhost:${PORT}`));
