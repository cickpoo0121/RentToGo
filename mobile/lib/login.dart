import 'package:flutter/material.dart';
import 'package:rentogo/auth.dart';
import 'package:rentogo/constance.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // String _url = 'http://10.0.2.2:3000/login';

  void addUser() async {
    http.Response response = await http.post(
      url + '/login',
      body: {'nameOfUser': name, 'userEmail': email},
    );

    if (response.statusCode == 200) {
      //OK
      print(response.body.toString());

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print(response.body.toString());
    }
  }

  void signIn() {
    signInWithGoogle().then(
      (result) {
        if (result != null) {
          addUser();
          // Navigator.pushReplacementNamed(context, '/home');
        } else {
          print('Error Auth from Firebase');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    MyStyle().circleProgress();
    signIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/images/travel.png',
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TRAVELPLAN',
                  // 'Signin',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(
                  width: 10,
                ),
                // Text(
                //   'Plan',
                //   style: TextStyle(
                //     fontSize: 30,
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 20, bottom: 20),
              child: Column(
                children: [
                  Text(
                    'Make your travel is better',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue[300],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' Convenience',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[300],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            // log in with google button
            Container(
              height: 60,
              width: 250,
              child: FlatButton(
                onPressed: () => signIn(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/google.png',
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text("Login with Google",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue[800],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                color: Colors.white,
                padding: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
