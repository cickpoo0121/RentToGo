const express = require('express');
const bycypt = require('bcrypt');
const app = express();
const config = require('./configDB.js');
const mysql = require('mysql');
const path = require("path");
const body_parser = require("body-parser");



const con = mysql.createConnection(config);

//========== Middleware ============
app.use(express.json());
app.use(express.urlencoded({ extended: true }))
app.use(express.static(path.join(__dirname, "public")));
app.use("/img", express.static(path.join(__dirname, '/assets/images/')));


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

app.get('/getUserID/:email', function (req, res) {
    const email = req.params.email;
    const sql = 'SELECT * FROM user WHERE UserEmail=?';
    con.query(sql, [email], function (err, result) {
        if (err) {
            console.log(err)
            res.status(500).send('Server error');
        }
        else {
            res.status(200).send(result);
            console.log(result);
        }
    });
})

//----------- Home Infomation ----------------

app.get('/trip', function (req, res) {
    const sql = 'SELECT * FROM trip';
    con.query(sql, function (err, result) {
        if (err) {
            console.log(err)
            res.status(500).send('Server error');
        }
        else {
            res.status(200).send(result);
        }
    });
})

//----------- Home Infomation ----------------

app.get('/tripInfo/:tripID', function (req, res) {
    tripid = req.params.tripID
    const sql = 'SELECT * FROM `tripinfo` WHERE TripID=?';
    con.query(sql, [tripid], function (err, result) {
        if (err) {
            console.log(err)
            res.status(500).send('Server error');
        }
        else {
            res.status(200).send(result);
        }
    });
})

//--------------- Trip Name --------------------
app.get("/tripName", function (req, res) {
    const Tripid = req.params.Tripid;
    const sql = "SELECT * FROM `trip`"
    con.query(sql, function (err, result, fields) {
        if (err) {
            res.status(503).send("เซิร์ฟเวอร์ไม่ตอบสนอง");
        } else {
            res.json(result)
        }
    })
});

//----------------- Trip Detail -----------------
app.get("/tripDetail/:Tripid", function (req, res) {
    const Tripid = req.params.Tripid;
    const sql = "SELECT * FROM tripinfo latlng,trip trip WHERE latlng.TripID=trip.TripID and latlng.TripID=?"
    con.query(sql, [Tripid], function (err, result, fields) {
        if (err) {
            res.status(503).send("เซิร์ฟเวอร์ไม่ตอบสนอง");
        } else {
            res.json(result)
        }
    })
})

//--------------- Car --------------------
app.get("/Car", function (req, res) {
    const sql = "SELECT * FROM `car`"
    con.query(sql, function (err, result, fields) {
        if (err) {
            res.status(503).send("เซิร์ฟเวอร์ไม่ตอบสนอง");
        } else {
            res.json(result)
        }
    })
});

app.get("/Car/:CarID", function (req, res) {
    const CarID = req.params.CarID;
    const sql = "SELECT * FROM `car` WHERE CarID=?"
    con.query(sql, [CarID], function (err, result, fields) {
        if (err) {
            res.status(503).send("เซิร์ฟเวอร์ไม่ตอบสนอง");
        } else {
            res.json(result)
        }
    })
});

app.get("/resInfo/:UserID", function (req, res) {
    const UserID = req.params.UserID;
    const sql = "SELECT res.resID, cars.CarName,cars.CarPic,cars.CarDescription,res.Price,res.PayMent,res.DateRent,res.DateReturn,usr.NameOfUser FROM reservations res ,car cars,user usr WHERE res.CarID=cars.CarID AND res.RenterID=usr.UserID AND res.RenterID=? ORDER BY res.resID DESC"
    con.query(sql, [UserID], function (err, result, fields) {
        if (err) {
            res.status(503).send("เซิร์ฟเวอร์ไม่ตอบสนอง");
        } else {
            res.json(result)
        }
    })
});

//-------------- update Payment -----------------
app.put("/updatePayment", function (req, res) {
    const resID = req.body.resID
    console.log(res)
    const sql = "UPDATE reservations SET PayMent = 1 WHERE resID = ?"
    con.query(sql, [resID], function (err, result) {
        if (err) {
            res.status(500).send('serverError');
        }
        else {
            res.status(200).send('ok')
        }
    })
})

// --------------- add car -----------------
app.post("/addCar", function (req, res) {
    const { CarName, CarDescription, CarPrice, ReturnDate } = req.body
    const sql = "INSERT INTO `car` (`CarName`, `CarPic`, `CarDescription`, `CarPrice`, `CarStatus`, `CarDisable`, `ReturnDate`, `CarOwner`) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
    con.query(sql, [CarName, 'G70.jpg', CarDescription, CarPrice, 0, 0, ReturnDate, 3], function (err, result) {
        if (err) {
            res.status(500).send('serverError');
        }
        else {
            res.status(200).send('ok')
        }
    })
})

app.post("/reservations", function (req, res) {
    const { CarID, RenterID, DateRent, DateReturn, Price } = req.body
    const sql = "INSERT INTO `reservations` (`CarID`, `RenterID`, `PayMent`, `DateRent`, `DateReturn`, `Price`) VALUES (?, ?, ?, ?, ?,?);"
    con.query(sql, [CarID, RenterID, 0, DateRent, DateReturn, Price], function (err, result) {
        if (err) {
            res.status(500).send('serverError');
        }
        else {
            res.status(200).send('ok')
        }
    })
})

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "/views/selectTrip.html"));
    // res.render("home.ejs", {user: req.user});
});

//Return tripinfor page
app.get("/tripinformation", function (req, res) {
    res.sendFile(path.join(__dirname, "/views/tripInfor.html"))
});

app.get("/carShop", function (req, res) {
    res.sendFile(path.join(__dirname, "/views/carshop.html"))
});



//========== Starting Server ============
app.listen(3000, function () {
    console.log("Server is starting at 3000");
});
