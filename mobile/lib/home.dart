import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentogo/auth.dart';
import 'package:rentogo/carCard.dart';
// import 'package:rentogo/carCard.dart';
import 'package:rentogo/constance.dart';
import 'package:rentogo/createTrip.dart';
import 'package:rentogo/profile.dart';
import 'package:rentogo/reservations.dart';
import 'package:rentogo/travelCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _search = TextEditingController();

  List data;
  List userData;

  void getTrip() async {
    http.Response response = await http.get(url + '/Carmobile');

    if (response.statusCode == 200) {
      // data = json.decode(response.body);
      setState(() {
        data = json.decode(response.body);
      });
      print(data);
    }
  }

  void searchTrip(keyword) async {
    http.Response response = await http.get(url + '/searching/$keyword');
    print(keyword);
    if (response.statusCode == 200) {
      // data = json.decode(response.body);
      setState(() {
        data = json.decode(response.body);
      });
      print(data);
      // getTrip();
      // getUserID();
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
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Search for a car'),
          // ),
          bottomNavigationBar: Container(
            color: Colors.lightBlue[500],
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    // color: Colors.grey,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.assignment,
                    // color: Colors.grey,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite,
                    // color: Colors.grey,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.perm_identity,
                    // color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 9),
                    child: Row(
                      children: [
                        Text(
                          'RentTo '.toUpperCase(),
                          style: TextStyle(
                            color: Colors.blue[300],
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'GO',
                          style: TextStyle(
                            // color: Colors.blue[300],
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _search,
                            onChanged: (text) {
                              searchTrip(text);
                              print(text);
                            },
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent,
                            ),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(Icons.search),
                                suffix: Icon(Icons.close),
                                hintText: "Search",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 32.0),
                                    borderRadius: BorderRadius.circular(25.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 32.0),
                                    borderRadius: BorderRadius.circular(25.0))),
                          ),
                        ),
                        data == null || data.length == 0
                            ? MyStyle().circleProgress()
                            : cardCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TravelCard(),
            Reservations(),
            Profile(),
          ]),
        ),
      ),
    );
  }

  Widget cardCard() {
    return data == null
        ? MyStyle().circleProgress()
        : SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.42,
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
                },
              ),
            ),
          );
  }
}
