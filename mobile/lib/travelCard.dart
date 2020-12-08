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
    return data.length == 0
        ? MyStyle().circleProgress()
        : Container(
            height: size.height/1.42,
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
                    print(data);
                    Navigator.pushNamed(
                      context,
                      '/Meaning',
                      arguments: data[index],
                    );
                  },
                );
                //  ListTile(
                //   title: Text(data[index]['title']),
                //   // subtitle: Text(data[index]['subtitle']),
                //   // trailing: SizedBox(
                //   //   child: Image.asset(data[index]['image']),
                //   //   height: 50,
                //   //   width: 50,
                //   // ),
                // );
              },
            ),
          );
    // Column(
    //   children: [
    //     Card(
    //       child: InkWell(
    //         splashColor: Colors.blue.withAlpha(30),
    //         onTap: () {
    //           print('Card tapped.');
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Image.asset(
    //                 'assets/images/'+_image
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 _tripName,
    //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //               ),
    //               Text(_description),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
