const express = require('express');
const bycypt = require('bcrypt');
const app = express();
const config = require('./configDB.js');
const mysql = require('mysql');

const con = mysql.createConnection(config);

//========== Middleware ============
app.use(express.json());
app.use(express.urlencoded({ extended: true }))

//========== Outer routes ============

// app.get('/welcome', function (req, res) {
//     res.send('<My name is Jojo>');
// });

//--------- Hash password ----------

app.get('/password/:pass', function (req, res) {
    const raw = req.params.pass;
    bycypt.hash(raw, 10, function (err, hash) {
        if (err) {
            console.log(err);
            res.status(500).send('Hashing error');
        } else {
            res.send(hash);
        }
    })
})

//----------- Login ----------------
app.post('/login', function (req, res) {
    const username = req.body.username;
    const rawPassword = req.body.password;

    const sql = 'SELECT password FROM user WHERE username=?';
    con.query(sql, [username], function (err, result) {
        if (err) {
            console.log(err);
            res.status(500).send('Server error');
        } else {
            //user found?
            if (result.length != 1) {
                res.status(400).send('Username is wrong');
            }
            else {
                //check password
                bycypt.compare(rawPassword, result[0].password, function (err, same) {
                    if (err) {
                        console.log(err)
                        res.status(500).send('Authen server error');
                    }
                    else {
                        if (same) {
                            res.status(200).send('Login Ok');
                        }
                        else {
                            res.status(400).send('Wrong password');
                        }
                    }
                });
            }
        }
    });


});

//========== Starting Server ============
app.listen(3000, function () {
    console.log("Server is starting at 3000");
});
