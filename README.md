# CS3042-DBMS - Supply Chain Management System

database importing order
remotemysql
functions
views
procedures
data
triggers

# Accessing user information in the session



------------


- import 'jsonwebtoken'

























































































```javascript
const jwt = require('jsonwebtoken');
```
- add below code block to function
```javascript
const token = req.cookies.jwt;
    if(token){
        const decodedToken = jwt.verify(token,'secret',(err,decodedToken) => {
            if(err){
                res.redirect('/')
            }
			return decodedToken
        })
    }
```
- access logged in user information from 'decodedToken'
```javascript
const email = decodedToken.email;
const userType = decodedToken.type;
```

