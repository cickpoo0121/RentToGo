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

// app.get('/password/:pass', function (req, res) {
//     const raw = req.params.pass;
//     bycypt.hash(raw, 10, function (err, hash) {
//         if (err) {
//             console.log(err);
//             res.status(500).send('Hashing error');
//         } else {
//             res.send(hash);
//         }
//     })
// })

//----------- Login ----------------
app.post('/login', function (req, res) {
    const userEmail = req.body.userEmail;
    const nameOfUser = req.body.nameOfUser;

    const sql = 'SELECT NameOfUser FROM user WHERE userEmail=?';
    con.query(sql, [userEmail], function (err, result) {
        if (err) {
            console.log(err);
            res.status(500).send('Server error');
        } else {
            //user found?
            if (result.length != 1) {
                const sql = 'INSERT INTO user (UserEmail, NameOfUser) VALUES (?, ?)';

                con.query(sql, [userEmail, nameOfUser], function (err, result) {
                    if (err) {
                        console.log(err);
                        res.status.send('Server error add user fail')
                    }
                    else {
                        res.status(200).send('Login Ok, add user')
                    }
                })

            }
            else {
                res.status(200).send('Login Ok')

            }
        }
    });

});

//----------- Home Infomation ----------------

app.get('/trip',function(req,res){
    const sql ='SELECT * FROM trip';
    con.query(sql,function(err,result){
        if(err){
            console.log(err)
            res.status(500).send('Server error');
        }
        else{
            res.status(200).send(result);
        }
    });
})

//----------- Home Infomation ----------------

app.get('/tripInfo/:tripID',function(req,res){
    tripid=req.params.tripID
    const sql ='SELECT * FROM `tripinfo` WHERE TripID=?';
    con.query(sql,[tripid],function(err,result){
        if(err){
            console.log(err)
            res.status(500).send('Server error');
        }
        else{
            res.status(200).send(result);
        }
    });
})


//========== Starting Server ============
app.listen(3000, function () {
    console.log("Server is starting at 3000");
});
