import 'package:flutter/material.dart';
import 'package:rentogo/createTrip.dart';
import 'package:rentogo/home.dart';
import 'package:rentogo/login.dart';
import 'package:rentogo/map.dart';
import 'package:rentogo/profile.dart';
import 'package:rentogo/register.dart';

void main() {
  runApp(
    MaterialApp(
      // home: TravelMap(),
      initialRoute: '/login',
      routes: {
        '/login':(context)=>Login(),
        '/register':(context)=>Register(),
        '/home':(context)=>Homepage(),
        '/map':(context)=>TravelMap(),
      },
      // theme: ThemeData(
      //   // primaryColor: Colors.blue[900],
      //   scaffoldBackgroundColor: Colors.grey[900],
      //   accentColor: Colors.red[900],
      //   // fontFamily: 'Lobster',
      //   textTheme: TextTheme(
      //     headline4: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     headline5: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    ),
  );
}
