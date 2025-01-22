const uuid = require('uuid');
const express = require('express');
const onFinished = require('on-finished');
const bodyParser = require('body-parser');
const path = require('path');
const port = 3000;
const fs = require('fs');
const axios = require('axios'); 

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const SESSION_KEY = 'Authorization';

const AUTH0_DOMAIN = 'dev-6sww0yh4s3mew71l.us.auth0.com';
const CLIENT_ID = 'bpgWdV1Dlbin2T2VYq3J0nmsRe7zrZ5G';
const CLIENT_SECRET = '1eJqaL3x_EKq-_682T6vY5KEKWKLWMK77l5R1WAc02CYvbAI7oUia49C02gRWiFf';
const AUDIENCE = 'https://dev-6sww0yh4s3mew71l.us.auth0.com/api/v2/';
const TOKEN_URL = `https://${AUTH0_DOMAIN}/oauth/token`;


class Session {
    #sessions = {}

    constructor() {
        try {
            this.#sessions = fs.readFileSync('./sessions.json', 'utf8');
            this.#sessions = JSON.parse(this.#sessions.trim());
        } catch (e) {
            this.#sessions = {};
        }
    }
    #storeSessions() {
        fs.writeFileSync('./sessions.json', JSON.stringify(this.#sessions), 'utf-8');
    }

    set(key, value) {
        if (!value) {
            value = {};
        }
        this.#sessions[key] = value;
        this.#storeSessions();
    }

    get(key) {
        return this.#sessions[key];
    }

    init(res) {
        const sessionId = uuid.v4();
        this.set(sessionId); 
        return sessionId;
    }

    destroy(req, res) {
        let sessionId = this.findSessionByAccessToken(req.session.access_token);
        while(sessionId){
            console.log("hi", sessionId);
            delete this.#sessions[sessionId];
            sessionId = this.findSessionByAccessToken(req.session.access_token);
        }

        this.#storeSessions();
    }

    findSessionByAccessToken(accessToken) {
        for (const sessionId in this.#sessions) {
            if (this.#sessions[sessionId].access_token === accessToken) {
                return this.#sessions[sessionId];
            }
        }
        return null;
    }

    getSessionFromAccessTokenOrCreate(accessToken, res) {
        let currentSession = this.findSessionByAccessToken(accessToken);
        let sessionId;

        if (currentSession) {
            sessionId = currentSession.sessionId;
        }

        return { currentSession, sessionId };
    }
}

const sessions = new Session();

app.use((req, res, next) => {
    let currentSession = {};
    const accessToken = req.get(SESSION_KEY);
    let sessionId = req.sessionId;

    if (accessToken) {
        console.log("Trying to find session by access_token");
        const { currentSession, sessionId } = sessions.getSessionFromAccessTokenOrCreate(accessToken, res);
        req.session = currentSession;
        req.sessionId = sessionId;
    } else {

        if (sessionId) {
            currentSession = sessions.get(sessionId);
        } else {
            sessionId = sessions.init(res);
        }

        req.session = currentSession;
        req.sessionId = sessionId;
    }

    onFinished(req, () => {
        const currentSession = req.session;
        const sessionId = req.sessionId;
        sessions.set(sessionId, currentSession);
    });

    next();
});


app.get('/', (req, res) => {
    if (req.session.username) {
        return res.json({
            username: req.session.username,
            logout: 'http://localhost:3000/logout'
        });
    }
    res.sendFile(path.join(__dirname + '/index.html'));
});

app.get('/logout', (req, res) => {
    sessions.destroy(req, res);
    res.redirect('/');
});

app.post('/api/login', async (req, res) => {
    const { login, password } = req.body;

    try {
        const response = await axios.post(TOKEN_URL, {
            grant_type: 'password',
            username: login,
            password: password,
            audience: AUDIENCE,
            client_id: CLIENT_ID,
            client_secret: CLIENT_SECRET,
        });

        const { access_token} = response.data;

        req.session.username = login; 
        req.session.access_token = access_token;


        return res.json({ 
            message: 'Login successful',
            access_token: access_token,
        });
    } catch (error) {
        console.error('Error during Auth0 login:', error.response?.data || error.message);
        res.status(401).json({
            error: 'Invalid login credentials or unauthorized.'
        });
    }
});

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});
