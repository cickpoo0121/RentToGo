import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentogo/constance.dart';
// import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';

class TravelMap extends StatefulWidget {
  @override
  _TravelMapState createState() => _TravelMapState();
}

class _TravelMapState extends State<TravelMap> {
  List<Marker> allMarker = [];
  GoogleMapController mapController;
  double lat, lng;
  LatLng currentPosition;
  // final LatLng _center = const LatLng(20.336635, 99.810514);

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition();
    // currentPosition = position;
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      lat = position.latitude;
      lng = position.longitude;
    });
    print('lat:$lat   lng:$lng');
  }

  Set<Marker> marker() {
    return <Marker>[
      // allMarker.add(
      Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        position: LatLng(lat, lng),
        // ),
      )
    ].toSet();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    // findLatLng();
    locatePosition();
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
              minHeight: 130,
              // color: Colors.red,
              panel: Container(
                child: Column(
                  children: [
                    Icon(
                      Icons.maximize_rounded,
                      size: 50,
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
        // onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        initialCameraPosition: CameraPosition(
          target: currentPosition,
          zoom: 16.0,
        ),
        // markers: marker(),
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
