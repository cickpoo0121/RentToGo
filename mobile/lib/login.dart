import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          children: <Widget>[
            // logo and words
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/travel.png',
                  height: 250,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Travel',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Plan',
                        style: TextStyle(
                          fontSize: 30,
                        )),
                  ],
                ),

                SizedBox(height: 40),
                // email textfield
                Column(
                  children: [
                    Container(
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.email, color: Colors.lightBlue),
                          hintText: 'Email address',
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
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
                SizedBox(
                  height: 40,
                ),
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
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
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
                // forgot password
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: FlatButton(
                    onPressed: () => print('Forgot Password Button pressed'),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 17),
                    ),
                  ),
                ),
                // Sign in button
                Container(
                  width: 350,
                  padding: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                // log in with google button
                Container(
                  width: 350,
                  padding: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/google.png',
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text("Login with Google",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // not a user?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Not a User?',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.lightBlue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
