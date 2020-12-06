import 'package:flutter/material.dart';

class FavoritePlane extends StatefulWidget {
  @override
  _FavoritePlaneState createState() => _FavoritePlaneState();
}

class _FavoritePlaneState extends State<FavoritePlane> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/LOGO.png',
                width: 170,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print('Card tapped.');
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/temple.jpg',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'แอ่วกิ๋นฟิน West',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('297 บาท 10 ชั่วโมง 7 แหล่งสถานที่ท่องเที่ยว '),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
