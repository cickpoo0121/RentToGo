import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentogo/auth.dart';
import 'package:rentogo/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarCard extends StatefulWidget {
  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  List data;
  List userData;

  void getTrip() async {
    http.Response response = await http.get(url + '/Carmobile');

    if (response.statusCode == 200) {
      // data = json.decode(response.body);
      setState(() {
        data = json.decode(response.body);
      });
    }
  }

  void getUserID() async {
    http.Response response =
        await http.get(url + '/getUserID/' + email.toString());

    if (response.statusCode == 200) {
      // data = json.decode(response.body);
      setState(() {
        userData = json.decode(response.body);
      });
      print(userData);
      save();
    }
  }

  void save() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> userDataSave = {
      'UserID': userData[0]['UserID'],
      'UserEmail': userData[0]['UserEmail'],
      'NameOfUser': userData[0]['NameOfUser']
    };
    String json = jsonEncode(userDataSave);
    pref.setString('kuserData', json);
  }

  @override
  void initState() {
    super.initState();
    getTrip();
    getUserID();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return data == null
        ? MyStyle().circleProgress()
        : SingleChildScrollView(
            child: Container(
              height: size.height / 1.42,
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
                                'assets/images/' + data[index]['CarPic']),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${data[index]['CarName']}'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(data[index]['CarDescription']),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // print(data[index]['TripID']);
                      Navigator.pushNamed(
                        context,
                        '/carCard',
                        arguments: data[index]['CarID'],
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
