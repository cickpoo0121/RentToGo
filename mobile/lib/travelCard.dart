import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentogo/constance.dart';

class TravelCard extends StatefulWidget {
  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  List data;

  void getTrip() async {
    http.Response response = await http.get(url + '/trip');

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      setState(() {
        data = json.decode(response.body);
      });
      print(data[0]['TripPrice']);
    }
  }

  @override
  void initState() {
    super.initState();
    getTrip();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Plan'.toUpperCase()),
      ),
      body: data == null
          ? MyStyle().circleProgress()
          : Container(
              height: size.height / 1.2,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                                'assets/images/' + data[index]['TripPic']),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data[index]['TripName'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(data[index]['TripDescription']),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // print(data[index]['TripID']);
                      Navigator.pushNamed(
                        context,
                        '/map',
                        arguments: data[index]['TripID'],
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
