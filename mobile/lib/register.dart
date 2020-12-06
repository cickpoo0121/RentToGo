import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Register',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          children: [
            // logo
            Column(
              children: [
                Image.asset(
                  'assets/images/travel.png',
                  height: 250,
                ),
              ],
            ),
            // travel plan word
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign up',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
                // Text('up',
                //     style: TextStyle(
                //       fontSize: 30,
                //     )),
              ],
            ),
            SizedBox(height: 40),
            // name textfield
            Column(
              children: [
                Container(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people, color: Colors.lightBlue),
                      hintText: 'Name',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // email textfield
            Column(
              children: [
                Container(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.lightBlue),
                      hintText: 'Email address',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // password textfield
            Column(
              children: [
                Container(
                  width: 400,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.lightBlue),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Confirm pass textfield
            Column(
              children: [
                Container(
                  width: 400,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.lightBlue),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            // Sign up button
            Column(
              children: [
                Container(
                  width: 350,
                  padding: EdgeInsets.only(top: 80),
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () {},
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
