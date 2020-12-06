import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Title'),
      // ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/icon.png'),
              radius: 80,
              backgroundColor: Colors.white,
            ),
          ),
          Divider(
            height: 50,
          ),
          SizedBox(height: 50,width: 150,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {},
              child: Text(
                'LOGOUT',
                style: TextStyle(color: Colors.white,fontSize: 24),
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
