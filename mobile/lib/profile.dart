import 'package:flutter/material.dart';
import 'package:rentogo/auth.dart';
import 'package:rentogo/constance.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void signOut() {
    signOutGoogle();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future showAlert() async {
    String answer = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to log out ?',
            style: TextStyle(fontSize: 16),
          ),
          // content: Image.asset('assets/images/google.png'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                signOut();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 80,
              backgroundColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            width: 150,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () => showAlert(),
              child: Text(
                'LOGOUT',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
