import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentogo/constance.dart';
import 'package:rentogo/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarInfo extends StatefulWidget {
  @override
  _CarInfoState createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  List data;
  var carId;
  String img = 'dd';
  String carname = 'Loading';
  String desc = 'Loading';
  String price = 'Loading';
  String returnDate = 'Loading';

  String _textstart = '';
  String _textend = '';
  DateTime selectdate1 = new DateTime.now();
  DateTime selectdate2 = new DateTime.now();
  DateTime startCalGap = new DateTime.now();
  DateTime endCalGap = new DateTime.now();
  String gapDay = '';
  String userId;

  Future confirmRent() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('กรุณาตรวจสอบข้อมูลให้ครบถ้วน'),
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
              onPressed: () {
                load();
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Homepage(2)));
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  Future showAlert() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('เลือกวันที่'),
            content: Container(
              height: 200,
              child: Column(
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () async {
                      DateTime dt = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2120, 12, 31),
                      );

                      if (dt != null) {
                        setState(() {
                          _textstart = '${dt.day}/${dt.month}/${dt.year}';
                          selectdate2 = dt;
                          startCalGap = DateTime(dt.year, dt.month, dt.day);
                          gapDay =
                              "${endCalGap.difference(startCalGap).inDays}";
                          print(gapDay);
                        });
                      }
                    },
                    child: Text(
                      'วันรับรถ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(_textstart),
                  Spacer(),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () async {
                      DateTime dt = await showDatePicker(
                        context: context,
                        initialDate: selectdate2,
                        firstDate: selectdate2,
                        lastDate: DateTime(2120, 12, 31),
                      );

                      if (dt != null) {
                        setState(() {
                          _textend = '${dt.day}/${dt.month}/${dt.year}';
                          endCalGap = DateTime(dt.year, dt.month, dt.day);

                          selectdate2 = dt;
                          gapDay =
                              "${endCalGap.difference(startCalGap).inDays}";

                          print(gapDay);
                        });
                      }
                    },
                    child: Text(
                      'วันคืนรถ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(_textend),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  gapDay == '' ? '' : callSetstate();
                  // Navigator.of(context).pop();
                },
                child: Text('ตกลง'),
              ),
              // FlatButton(
              //   onPressed: () {
              //     // Navigator.pop(context);
              //     callSetstate();
              //     Navigator.of(context).pop('Collect');
              //   },
              //   child: Text('Yes'),
              // ),
            ],
          );
        });
      },
    );
  }

  void getDB() async {
    http.Response response = await http.get(url + '/Car/' + carId.toString());
    if (response.statusCode == 200) {
      // data = json.decode(response.body);
      setState(() {
        data = json.decode(response.body);
        img = data[0]['CarPic'];
        carname = data[0]['CarName'];
        desc = data[0]['CarDescription'];
        price = data[0]['CarPrice'].toString();
        returnDate = data[0]['ReturnDate'];

        print(data);
      });
    }
    print('$img  $carname  $desc');
  }

  void load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String json = pref.getString('kuserData');
    if (json != null) {
      Map data = jsonDecode(json);
      setState(() {
        // print(data['UserID']);
        userId = data['UserID'].toString();
        postToDB(userId);
        print(userId);
      });
    }
  }

  void postToDB(id) async {
    http.Response response = await http.post(url + '/reservations', body:
        {
      'CarID': carId.toString(),
      'RenterID': id,
      'DateRent': _textstart,
      'DateReturn': _textend,
      'Price': gapDay
    });
    if (response.statusCode == 200) {
      // Navigator.push(
      // context, MaterialPageRoute(builder: (context) => Homepage(2)));
      Navigator.pushNamed(context, '/res');
      print('successed');
    } else {
      print(response.body.toString());
    }
  }

  void callSetstate() {
    setState(() {
      gapDay = (int.parse(gapDay) * int.parse(price)).toString();
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        carId = ModalRoute.of(context).settings.arguments;
        getDB();
      });
      print(carId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Information'.toUpperCase()),
      ),
      body: img == 'dd'
          ? MyStyle().circleProgress()
          : Container(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: 500,
                    child: Image.asset(
                      'assets/images/' + img,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'ชื่อรุ่นรถ  ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              carname.toUpperCase(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'รายละเอียด  ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Text(
                                desc,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'ราคาต่อวัน',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Text(
                                '$price บาท',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'วันที่คืนรถ  ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Flexible(
                              child: Text(
                                _textend,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ราคารวม  ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Text(
                                '$gapDay บาท',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              showAlert();
            },
            child: Text(
              'เลือกวันที่',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Colors.blue,
          ),
          SizedBox(
            width: 30,
          ),
          RaisedButton(
            onPressed: () {
              confirmRent();
            },
            child: Text(
              'จอง',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Colors.green,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
