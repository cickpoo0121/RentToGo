import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:rentogo/constance.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import "package:latlong/latlong.dart" as latLng;

class MapTest extends StatefulWidget {
  @override
  _MapTestState createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  // GoogleMapController mapController;
  // Completer<GoogleMapController> _controller = Completer();
  double lat = 1, lng;
  // LatLng currentPosition;
  String googleAPIKey = "AIzaSyCDi57wwdz3uWlazz97SkFNET5jDh2Hdjo";

  // final LatLng _center = const LatLng(20.336635, 99.810514);
  List<latLng.LatLng> polylineCoordinates = [];

  latLng.LatLng _lat1 = latLng.LatLng(20.0580112, 99.898658);
  latLng.LatLng _lat2 = latLng.LatLng(20.0491525, 99.891911);

  @override
  void initState() {
    super.initState();

    polylineCoordinates.add(_lat1);
    polylineCoordinates.add(_lat2);
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
              child: new FlutterMap(
                options: new MapOptions(
                    center: new latLng.LatLng(_lat1.latitude, _lat1.longitude),
                    minZoom: 10.0),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/cickpool/ckig5qyd3598119oay9tedl7a/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2lja3Bvb2wiLCJhIjoiY2tpZzVrdGU4MDRsazMzbzMwZTU0ZGoydiJ9.GwZ2FauCukSBROsE24xUdA",
                      additionalOptions: {
                        'accessToken':
                            'pk.eyJ1IjoiY2lja3Bvb2wiLCJhIjoiY2tpZzVrdGU4MDRsazMzbzMwZTU0ZGoydiJ9.GwZ2FauCukSBROsE24xUdA',
                        'id': 'mapbox.mapbox-streets-v8'
                      }),
                  MarkerLayerOptions(markers: [
                    Marker(
                        width: 50,
                        height: 50,
                        point: latLng.LatLng(_lat1.latitude, _lat1.longitude),
                        builder: (context) => Container(
                              child: Text('aaaa'),
                            ))
                  ]),
                  PolylineLayerOptions(polylines: [
                    Polyline(
                        points: polylineCoordinates,
                        color: Colors.blue,
                        strokeWidth: 3)
                  ])
                ],
              ),
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

  // Container showMap() {
  //   return
  // }
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
