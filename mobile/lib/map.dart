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
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  double lat, lng;
  LatLng currentPosition;
  String googleAPIKey = "AIzaSyCDi57wwdz3uWlazz97SkFNET5jDh2Hdjo";
  // double CAMERA_ZOOM = 13;
  // double CAMERA_TILT = 0;
  // double CAMERA_BEARING = 30;
  // LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
  // LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  // final LatLng _center = const LatLng(20.336635, 99.810514);

  static LatLng _lat1 = LatLng(20.0580112, 99.898658);
  static LatLng _lat2 = LatLng(20.0491525, 99.891911);

  void locatePosition() async {
    // var permission =
    //     await await Permission.locationWhenInUse.serviceStatus.isEnabled;
    // print(permission);
    Position position = await Geolocator.getCurrentPosition();
    // currentPosition = position;
      
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      lat = position.latitude;
      lng = position.longitude;
      polylineCoordinates.add(_lat1);
      polylineCoordinates.add(_lat2);

      // polylineCoordinates
    });
    print('lat:$lat   lng:$lng');
  }

  // Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
  //   var url =
  //       'https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$googleAPIKey';
  //   http.Response response = await http.get(url);
  //   Map values = jsonDecode(response.body);
  //   print(values);
  //   return values["routes"][0]["overview_polyline"]["points"];
  // }

  Set<Marker> marker() {
    return <Marker>[
      // allMarker.add(
      Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        position: LatLng(_lat2.latitude, _lat2.longitude),
        // ),
      )
    ].toSet();
  }

  Set<Polyline> createPolyline() {
    return <Polyline>[
      // allMarker.add(
      // Polyline(
      //     width: 10,
      //     points: polylineCoordinates,
      //     endCap: Cap.roundCap,
      //     startCap: Cap.roundCap,
      //     color: Colors.green)
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

  // void createRoute(String encondedPoly) {
  //   _polylines.add(Polyline(
  //       polylineId: PolylineId('i'),
  //       width: 4,
  //       points: _convertToLatLng(_decodePoly(encondedPoly)),
  //       color: Colors.red));
  // }

  // void sendRequest() async {
  //   // LatLng destination = LatLng(20.008751, 73.780037);
  //   String route = await getRouteCoordinates(_lat1, _lat2);
  //   print(route);
  //   // createPolyline(route);
  //   // _addMarker(destination,"KTHM Collage");
  // }

  //  createPolyline() {
  //   // setState(() {
  //   //   _polylines.add(
  //   //     Polyline(
  //   //       polylineId: PolylineId('line1'),
  //   //       visible: true,
  //   //       points: _convertToLatLng(_decodePoly(encondedPoly)),
  //   //       width: 2,
  //   //       color: Colors.blue,
  //   //       startCap: Cap.roundCap,
  //   //       endCap: Cap.roundCap,
  //   //     ),
  //   //   );
  //   // });
  //   // allMarker.add(
  //   Polyline(
  //       width: 10,
  //       points: polylineCoordinates,
  //       endCap: Cap.roundCap,
  //       startCap: Cap.roundCap,
  //       color: Colors.green);
  // }

  // List<LatLng> _convertToLatLng(List points) {
  //   List<LatLng> result = <LatLng>[];
  //   for (int i = 0; i < points.length; i++) {
  //     if (i % 2 != 0) {
  //       result.add(LatLng(points[i - 1], points[i]));
  //     }
  //   }
  //   return result;
  // }

  // List _decodePoly(String poly) {
  //   var list = poly.codeUnits;
  //   var lList = new List();
  //   int index = 0;
  //   int len = poly.length;
  //   int c = 0;
  //   do {
  //     var shift = 0;
  //     int result = 0;
  //     do {
  //       c = list[index] - 63;
  //       result |= (c & 0x1F) << (shift * 5);
  //       index++;
  //       shift++;
  //     } while (c >= 32);
  //     if (result & 1 == 1) {
  //       result = ~result;
  //     }
  //     var result1 = (result >> 1) * 0.00001;
  //     lList.add(result1);
  //   } while (index < len);
  //   for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
  //   print(lList.toString());
  //   return lList;
  // }

  @override
  void initState() {
    super.initState();
    // setSourceAndDestinationIcons();
    // findLatLng();
    locatePosition();
    // sendRequest();

    // marker();
  }

  @override
  Widget build(BuildContext context) {
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
                            Spacer(),
                            Text(
                              'แอ๋วกิ๋วฟิน West',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.favorite_border_outlined,
                                color: Colors.red)
                          ],
                        ),
                      ),
                    ),
                    ListTravelPlace(),
                  ],
                ),

                //TODO: ทำขอบมน
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(30),
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       spreadRadius: 3,
                //       color: Color(0x11000000).withOpacity(.1),
                //     ),
                //   ],
                // ),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //         blurRadius: 5,
                //         spreadRadius: 2.0,
                //         color: const Color(0x11000000))
                //   ],
                //   // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(20),
                //     topRight: Radius.circular(20),
                //   ),
                //   // ),
                // ),
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
        markers: marker(),
        polylines: createPolyline(),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: currentPosition,
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
