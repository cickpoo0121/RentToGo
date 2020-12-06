import 'package:flutter/material.dart';
import 'package:rentogo/createTrip.dart';
import 'package:rentogo/favoritePlane.dart';
import 'package:rentogo/profile.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _search = TextEditingController();
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
            Column(
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
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 32.0),
                            borderRadius: BorderRadius.circular(25.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(25.0))),
                  ),
                ),
                Category(),
                TravelCard()
              ],
            ),
            CreatTrip(),
            FavoritePlane(),
            Profile(),
          ]),
        ),
      ),
    );
  }
}

class TravelCard extends StatefulWidget {
  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('297 บาท 10 ชั่วโมง 7 แหล่งสถานที่ท่องเที่ยว '),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          onPressed: () => {},
          color: Colors.white,
          child: Text(
            'New',
            style: TextStyle(color: Colors.black),
          ),
        ),
        RaisedButton(
          onPressed: () => {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          color: Colors.white,
          child: Text(
            'Popular',
            style: TextStyle(color: Colors.black),
          ),
        ),
        RaisedButton(
          onPressed: () => {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          color: Colors.white,
          child: Text(
            'Cafe',
            style: TextStyle(color: Colors.black),
          ),
        ),
        RaisedButton(
          onPressed: () => {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          color: Colors.white,
          child: Text(
            'Nature',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ));
  }
}
