import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentogo/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reservations extends StatefulWidget {
  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List data;
  String userId;
  String resID = '';

  void getRes(String id) async {
    print(userId);
    http.Response response = await http.get(url + '/resInfo/$userId');

    if (response.statusCode == 200) {
      // data = json.decode(response.body);
      setState(() {
        data = json.decode(response.body);
        print(data);
      });
    }
  }

  void load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String json = pref.getString('kuserData');
    if (json != null) {
      Map data = jsonDecode(json);
      setState(() {
        // print(data['UserID']);
        userId = data['UserID'].toString();
        getRes(userId);
        print(userId);
      });
    }
  }

  Future showCar(index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${data[index]['CarName']}".toUpperCase()),
          content: Container(
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset('assets/images/' + data[index]['CarPic']),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'วันที่รับรถ  ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Flexible(
                      child: Text(
                        data[index]['DateRent'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'วันที่คืนรถ  ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Flexible(
                      child: Text(
                        data[index]['DateReturn'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                data[index]['PayMent'] == 0
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'ยอดชำระ  ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Flexible(
                                child: Text(
                                  '${data[index]['Price']} บาท',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              confirmRent();
                            },
                            child: Text(
                              'ชำระ',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'ชำระเรียบร้อย',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                // postToDB();
                Navigator.pop(context);
                // Navigator.of(context).pop('Collect');
              },
              child: Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

  Future confirmRent() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('ยืนยันการชำระบริการ'),
            // content: Image.asset('assets/images/google.png'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.of(context).pop();
                },
                child: Text('ยกเลิก'),
              ),
              FlatButton(
                onPressed: () async {
                  // void updatePayMent() async {
                  print(resID);
                  http.Response response = await http
                      .put(url + '/updatePayment', body: {'resID': resID});

                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Future.delayed(Duration(seconds: 2), () {
                      load();
                    });
                  } else {
                    print(response.body.toString());
                  }
                  // }

                  // Navigator.pop(context);
                },
                child: Text('ตกลง'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      // setState(() {
      // userId = ModalRoute.of(context).settings.arguments;
      load();

      // });
      // print(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservations'.toUpperCase()),
      ),
      body: data == null
          ? MyStyle().circleProgress()
          : data.length == 0
              ? Center(
                  child: (Text(
                    'No Data',
                    style: TextStyle(fontSize: 25),
                  )),
                )
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
                                    'assets/images/' + data[index]['CarPic']),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${data[index]['CarName']}'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(data[index]['CarDescription']),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          showCar(index);
                          setState(() {
                            resID = data[index]['resID'].toString();
                            print(resID);
                          });
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
  }
}
