import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rentogo/constance.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';

class TravelMap extends StatefulWidget {
  @override
  _TravelMapState createState() => _TravelMapState();
}

class _TravelMapState extends State<TravelMap> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  double lat, lng;
  // var currentPosition;
  var currentLng, currentLat;
  String googleAPIKey = "AIzaSyCDi57wwdz3uWlazz97SkFNET5jDh2Hdjo";
  List data;
  var tripID;
  static LatLng _lat1 = LatLng(20.0580112, 99.898658);
  static LatLng _lat2 = LatLng(20.0491525, 99.891911);

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition();
    // currentPosition = position;

    setState(() {
      // findCurrentPosition(position.latitude, position.longitude);
      // currentLat = position.latitude;
      // currentLng = position.longitude;
      lat = position.latitude;
      // print(currentPosition);

      // lng = position.longitude;
      // polylineCoordinates.add(_lat1);
      // polylineCoordinates.add(_lat2);
    });
    print('lat:$lat   lng:$lng');
  }

  // findCurrentPosition(var lat, var lng) {
  //   setState(() {
  //     currentPosition = LatLng(lat, lng);
  //   });
  // }

  void getTripInfo() async {
    http.Response response =
        await http.get(url + '/tripInfo/' + tripID.toString());
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        print(data[0]['Lat']);
        for (int i = 0; i < data.length; i++) {
          double lat = double.parse(data[i]['Lat']);
          double lng = double.parse(data[i]['Lng']);
          loc(lat, lng);
        }
        int haftDataLength = (data.length / 2).round();
        currentLat = double.parse(data[haftDataLength]['Lat']);
        currentLng = double.parse(data[haftDataLength]['Lng']);
        // currentLat = _lat2.latitude;
        // currentLng = _lat2.longitude;
      });
    }
    // print(currentLat);
  }

  void addMarker() {
    setState(() {
      for (int i = 0; i < data.length; i++) {
        double lat = double.parse(data[i]['Lat']);
        double lng = double.parse(data[i]['Lng']);
        loc(lat, lng);
      }
      int haftDataLength = (data.length / 2).round();
      // currentLat = double.parse(data[haftDataLength]['Lat']);
      // currentLng = double.parse(data[haftDataLength]['Lng']);
      currentLat = _lat2.latitude;
      currentLng = _lat2.longitude;
      // findCurrentPosition(double.parse(data[haftDataLength]['Lat']),
      //     double.parse(data[haftDataLength]['Lng']));
      // currentPosition = LatLng(double.parse(data[haftDataLength]['Lat']),
      //     double.parse(data[haftDataLength]['Lng']));
    });
  }

  void loc(var lat, var lng) {
    final LatLng latlng = LatLng(lat, lng);
    final MarkerId markerId = MarkerId((markers.length + 1).toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: latlng,
      icon: BitmapDescriptor.defaultMarker,
      draggable: false,
      zIndex: 1,
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  Set<Polyline> createPolyline() {
    return <Polyline>[
      Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: polylineCoordinates,
        width: 2,
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ),
    ].toSet();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    // setSourceAndDestinationIcons();
    // findLatLng();
    Future.delayed(Duration.zero, () {
      setState(() {
        tripID = ModalRoute.of(context).settings.arguments;
        getTripInfo();
      });
      print(tripID);
      locatePosition();
    });
    // loc(_lat1);
    // loc(_lat2);

    // sendRequest();

    // marker();
  }

  @override
  Widget build(BuildContext context) {
    // tripID = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            // title: Text('Title'),
            // backgroundColor: Colors.white,
            ),
        body: Stack(
          children: [
            Container(
              // height: 500,
              child: lat == null ? MyStyle().circleProgress() : showMap(),
            ),
            SlidingUpPanel(
              minHeight: 110,
              // color: Colors.red,
              panel: Container(
                child: Column(
                  children: [
                    Icon(
                      Icons.maximize_rounded,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            // Spacer(),
                            Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: 30,
                            ),
                            Spacer(),
                            Text(
                              'แอ๋วกิ๋วฟิน West',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              child: CircleAvatar(
                                foregroundColor: Colors.blue,
                                child: Icon(
                                  Icons.near_me,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                              onTap: addMarker,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(data[index]['TripInfoPlaceName']),
                          subtitle: Row(
                            children: [
                              Text(
                                '4.2',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          // leading: Text('data'),
                          trailing: SizedBox(
                            // child: Image.asset('assets/images/Trip11.jpg'),
                            child: Image.asset(
                                'assets/images/${data[index]['TripInfoPlacePic']}'),
                            height: 200,
                            width: 100,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container showMap() {
    return Container(
      child: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        tiltGesturesEnabled: false,
        markers: Set.of(markers.values),
        // marker(),
        // polylines: createPolyline(),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLat, currentLng),
          zoom: 16.0,
        ),
      ),
    );
  }
}

class ListTravelPlace extends StatefulWidget {
  @override
  _ListTravelPlaceState createState() => _ListTravelPlaceState();
}

class _ListTravelPlaceState extends State<ListTravelPlace> {
  List<Map<String, dynamic>> data = [
    {
      'title': 'ดอยช้างมูบ',
      // 'subtitle': '9 baht',
      'image': 'assets/images/Trip11.jpg'
    },
    {
      'title': 'ดอยผาฮี้',
      // 'subtitle': '3 baht',
      'image': 'assets/images/Trip12.jpg'
    },
    {
      'title': 'สวยคุณปู่',
      // 'subtitle': '5 baht',
      'image': 'assets/images/Trip13.jpg'
    },
    {
      'title': 'ดอยผาหมี',
      // 'subtitle': '14 baht',
      'image': 'assets/images/Trip14.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index]['title']),
          subtitle: Row(
            children: [
              Text(
                '4.2',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.star,
                size: 20,
                color: Colors.blue,
              ),
            ],
          ),
          // leading: Text('data'),
          trailing: SizedBox(
            // child: Image.asset('assets/images/Trip11.jpg'),
            child: Image.asset(data[index]['image']),
            height: 200,
            width: 100,
          ),
        );
      },
    );
  }
}
