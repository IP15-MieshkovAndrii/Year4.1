const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const JWT_SECRET = '23hbhb23ybdundjwnsjdnk,a.c,i2mbu3n2m,lsjdhn8fi2,qpc2tu3w';

const users = [
    { login: 'Login', password: 'Password', username: 'Username' },
    { login: 'Login1', password: 'Password1', username: 'Username1' }
];

const authenticateJWT = (req, res, next) => {
    const authHeader = req.get('Authorization');
    if (authHeader) {
        const token = authHeader.split(' ')[1]; 
        jwt.verify(token, JWT_SECRET, (err, user) => {
            if (err) {
                return res.status(403).json({ error: 'Invalid token' });
            }
            req.user = user; 
            next();
        });
    } else {
        res.status(401).json({ error: 'Authorization header missing' });
    }
};


app.get('/', authenticateJWT, (req, res) => {
    console.log(req.session);
    if (req.session.username) {
        res.json({
            message: `Hello, ${req.user.username}!`,
            logout: 'http://localhost:3000/logout'
        });
    }
    res.sendFile(path.join(__dirname+'/index.html'));
});


app.post('/api/login', (req, res) => {
    const { login, password } = req.body;

    const user = users.find(u => u.login === login && u.password === password);
    if (user) {
        const token = jwt.sign(
            { username: user.username, login: user.login },
            JWT_SECRET,
            { expiresIn: '1h' } 
        );

        res.json({ token });
    } else {
        res.status(401).json({ error: 'Invalid login or password' });
    }
});

app.get('/logout', (req, res) => {
    res.json({ message: 'To logout, simply delete your token on the client side.' });
});


app.listen(port, () => {
    console.log(`Example app listening on http://localhost:${port}`);
});
