import 'package:flutter/material.dart';

class CreatTrip extends StatefulWidget {
  @override
  _CreatTripState createState() => _CreatTripState();
}

class _CreatTripState extends State<CreatTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   title: Text(
      //     'Sign In',
      //     style: TextStyle(fontSize: 25, color: Colors.black),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/travel.png',
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CREATE ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text('TRIP',
                      style: TextStyle(
                        fontSize: 30,
                      )),
                ],
              ),

              SizedBox(height: 20),
              // email textfield
              Column(
                children: [
                  Container(
                    width: 310,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                        prefixIcon:
                            Icon(Icons.location_pin, color: Colors.lightBlue),
                        hintText: 'Start Place',
                        hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // password textfield
              Container(
                width: 310,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    prefixIcon:
                        Icon(Icons.location_pin, color: Colors.lightBlue),
                    hintText: 'End Place',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 310,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    prefixIcon: Icon(Icons.timelapse, color: Colors.lightBlue),
                    hintText: 'Time (hour)',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 310,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    prefixIcon: Icon(Icons.money, color: Colors.lightBlue),
                    hintText: 'Budget (baht)',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'CREATE',
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                ),
              ),
              // log in with google butto                // not a user?
            ],
          ),
        ),
      ),
    );
  }
}
