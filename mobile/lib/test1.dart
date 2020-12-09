// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class CampsiteInfo extends StatefulWidget {
//   @override
//   _CampsiteInfoState createState() => _CampsiteInfoState();
// }

// class _CampsiteInfoState extends State<CampsiteInfo> {
//   String _url = 'http://10.0.2.2:3000/reserveCamp';
//   List campInfo;
//   int _value = 1;
//   List dataID;

//   String _selectDate =
//       DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
//   String _lastDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
//   int stDay, stMonth, stYear;

//   DateTime startDate1 = DateTime.now();
//   DateTime endDate1 = DateTime.now();
//   String dd = '';

//   String difer = '';
//   int numDay = 0;

//   void connectReserve() async {
//     http.Response response = await http.post(
//       _url,
//       body: {
//         "uid": dataID[0]['UserID'].toString(),
//         "cid": campInfo[0]['CampID'].toString(),
//         "firstDate": startDate1.toString(),
//         "lastDate": endDate1.toString(),
//         "day": numDay.toString(),
//       },
//     );
//     if (response.statusCode == 200) {
//       print(response.body.toString());
//       print('success');
//     } else {
//       print(response.body.toString());
//       print('error');
//     }
//   }

//   void loadUserData() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String jsonUserData = pref.getString('userData');
//     if (jsonUserData != null) {
//       dataID = jsonDecode(jsonUserData);
//       print(dataID[0]['username']);
//     }
//   }

//   Future firstPickDate() async {
//     DateTime dt = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2120, 12, 31),
//     );

//     if (dt != null) {
//       // print(dt.toString());
//       setState(() {
//         // _selectDate = dt.toString();
//         _selectDate = '${dt.day}/${dt.month}/${dt.year}';
//         startDate1 = DateTime(dt.year, dt.month, dt.day);
//         print('start date : $startDate1 \nend date : $endDate1');
//         // print(difference);
//         dd = "${endDate1.difference(startDate1).inDays}";
//         print(dd);
//         stDay = dt.day;
//         stMonth = dt.month;
//         stYear = dt.year;
//       });
//     }
//   }

//   Future lastPickDate() async {
//     DateTime dt = await showDatePicker(
//       context: context,
//       initialDate: DateTime(stYear, stMonth, stDay),
//       firstDate: DateTime(stYear, stMonth, stDay),
//       lastDate: DateTime(2120, 12, 31),
//     );

//     if (dt != null) {
//       // print(dt.toString());
//       setState(() {
//         // _selectDate = dt.toString();
//         _lastDate = '${dt.day}/${dt.month}/${dt.year}';
//         endDate1 = DateTime(dt.year, dt.month, dt.day);
//         print('start date : $startDate1 \nend date : $endDate1');
//         dd = "${endDate1.difference(startDate1).inDays}";
//         print(dd);
//         numDay = int.parse(dd);
//       });
//     }
//   }

//   void diferenceDate() {
//     setState(() {
//       dd = "${endDate1.difference(startDate1).inDays}";
//       print(numDay);
//     });
//   }

//   void closePage() {
//     setState(() {
//       Navigator.pop(context);
//     });
//   }

//   Future reseveDialog() async {
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text('Reservation',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               content: Container(
//                 height: MediaQuery.of(context).size.width / 2.3,
//                 width: 350,
//                 child: Column(
//                   children: [
//                     Container(
//                       //width: 200,
//                       child: Row(
//                         children: [
//                           RaisedButton(
//                             //TODO:check IN
//                             onPressed: () async {
//                               DateTime dt = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime.now(),
//                                 lastDate: DateTime(2120, 12, 31),
//                               );

//                               if (dt != null) {
//                                 // print(dt.toString());
//                                 setState(() {
//                                   // _selectDate = dt.toString();
//                                   _selectDate =
//                                       '${dt.day}/${dt.month}/${dt.year}';
//                                   startDate1 =
//                                       DateTime(dt.year, dt.month, dt.day);
//                                   print(
//                                       'start date : $startDate1 \nend date : $endDate1');
//                                   // print(difference);
//                                   dd =
//                                       "${endDate1.difference(startDate1).inDays}";
//                                   print(dd);
//                                   stDay = dt.day;
//                                   stMonth = dt.month;
//                                   stYear = dt.year;
//                                 });
//                               }
//                             },
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Text(
//                               'Check-In Date',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             _selectDate,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Container(
//                       //width: 200,
//                       child: Row(
//                         children: [
//                           RaisedButton(
//                             //TODO:Check Out
//                             onPressed: () async {
//                               DateTime dt = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime(stYear, stMonth, stDay),
//                                 firstDate: DateTime(stYear, stMonth, stDay),
//                                 lastDate: DateTime(2120, 12, 31),
//                               );

//                               if (dt != null) {
//                                 // print(dt.toString());
//                                 setState(() {
//                                   // _selectDate = dt.toString();
//                                   _lastDate =
//                                       '${dt.day}/${dt.month}/${dt.year}';
//                                   endDate1 =
//                                       DateTime(dt.year, dt.month, dt.day);
//                                   print(
//                                       'start date : $startDate1 \nend date : $endDate1');
//                                   dd = dd =
//                                       "${endDate1.difference(startDate1).inDays}";
//                                   print(dd);
//                                   numDay = int.parse(dd);
//                                 });
//                               }
//                             },
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Text(
//                               'Check-Out Date',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             _lastDate,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     // Container(
//                     //   //width: 200,
//                     //   child: DropdownButtonFormField(
//                     //     decoration: InputDecoration(
//                     //         border: OutlineInputBorder(
//                     //       borderRadius: BorderRadius.circular(30.0),
//                     //     )),
//                     //     value: _value,
//                     //     items: [
//                     //       DropdownMenuItem(
//                     //         child: Text(
//                     //           'Zone',
//                     //           style: TextStyle(
//                     //               fontSize: 18, fontWeight: FontWeight.bold),
//                     //         ),
//                     //         value: 0,
//                     //       ),
//                     //     ],
//                     //     onChanged: (value) {
//                     //       setState(() {
//                     //         _value = value;
//                     //       });
//                     //     },
//                     //   ),
//                     // ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     // Container(
//                     //   //width: 200,
//                     //   child: DropdownButtonFormField(
//                     //     decoration: InputDecoration(
//                     //         border: OutlineInputBorder(
//                     //       borderRadius: BorderRadius.circular(30.0),
//                     //     )),
//                     //     value: _value,
//                     //     items: [
//                     //       DropdownMenuItem(
//                     //         child: Text(
//                     //           'No.Place',
//                     //           style: TextStyle(
//                     //               fontSize: 18, fontWeight: FontWeight.bold),
//                     //         ),
//                     //         value: 0,
//                     //       ),
//                     //       DropdownMenuItem(
//                     //         child: Text(
//                     //           '1',
//                     //           style: TextStyle(
//                     //               fontSize: 18, fontWeight: FontWeight.bold),
//                     //         ),
//                     //         value: 1,
//                     //       ),
//                     //     ],
//                     //     onChanged: (value) {
//                     //       setState(() {
//                     //         _value = value;
//                     //       });
//                     //     },
//                     //   ),
//                     // ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               '${campInfo[0]['price']}x$numDay days',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Column(
//                           children: [
//                             Text(
//                               '${campInfo[0]['price'] * numDay}',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     // Row(
//                     //   children: [
//                     //     Column(
//                     //       children: [
//                     //         Text(
//                     //           'No.Place',
//                     //           style: TextStyle(
//                     //               fontSize: 18, fontWeight: FontWeight.bold),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Spacer(),
//                     //     Column(
//                     //       children: [
//                     //         Text(
//                     //           '2',
//                     //           style: TextStyle(
//                     //               fontSize: 18, fontWeight: FontWeight.bold),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ],
//                     // ),
//                     // SizedBox(
//                     //   height: 20,
//                     // ),
//                     Divider(),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               'Total',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Column(
//                           children: [
//                             Text(
//                               '${campInfo[0]['price'] * numDay}',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 FlatButton(
//                   //TODO: enable service function to complete
//                   onPressed: () {
//                     connectReserve();
//                     // Navigator.of(context).pop();
//                     Navigator.pushReplacementNamed(context, '/history',arguments: dataID);
//                   },
//                   child: Text('OK'),
//                 ),
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     // print('${dataID}\n${campInfo}');
//                     // Navigator.pop(context);
//                   },
//                   child: Text('Cancel'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadUserData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     campInfo = ModalRoute.of(context).settings.arguments;
//     return Scaffold(
//       //   appBar: AppBar(
//       //     title: Text('Title'),
//       //   ),
//       body: SingleChildScrollView(
//         child: Container(
//           color: Color.fromRGBO(255, 248, 220, 0.5),
//           child: Padding(
//             padding: const EdgeInsets.all(40.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Campsite',
//                       style:
//                           TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       campInfo[0]['Name'],
//                       style:
//                           TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(30.0),
//                       child: Image.asset(
//                         'assets/images/${campInfo[0]['image']}',
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(30.0),
//                           child: Image.asset(
//                             'assets/images/${campInfo[0]['image']}',
//                             width: 150,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(30.0),
//                           child: Image.asset(
//                             'assets/images/${campInfo[0]['image']}',
//                             width: 150,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Information',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//                 Container(
//                   width: 550,
//                   // height: 200,
//                   child: Column(
//                     children: [
//                       Text(
//                         campInfo[0]['Description'],
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Contact',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   child: Column(
//                     children: [
//                       Text(
//                         campInfo[0]['contact'],
//                         style: TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                 ),
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//                 // Row(
//                 //   children: [
//                 //     Text(
//                 //       'Comments',
//                 //       style:
//                 //           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 //     ),
//                 //   ],
//                 // ),
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     Column(
//                 //       children: [
//                 //         CircleAvatar(
//                 //           backgroundImage:
//                 //               AssetImage('assets/images/person.png'),
//                 //           radius: 25,
//                 //           backgroundColor: Colors.white,
//                 //         ),
//                 //       ],
//                 //     ),
//                 //     SizedBox(
//                 //       width: 10,
//                 //     ),
//                 //     Column(
//                 //       children: [
//                 //         Text(
//                 //           'Good place!',
//                 //           style: TextStyle(fontSize: 18),
//                 //         )
//                 //       ],
//                 //     ),
//                 //     SizedBox(
//                 //       width: 100,
//                 //     ),
//                 //     Column(
//                 //       children: [
//                 //         CircleAvatar(
//                 //           backgroundImage:
//                 //               AssetImage('assets/images/person.png'),
//                 //           radius: 25,
//                 //           backgroundColor: Colors.white,
//                 //         ),
//                 //       ],
//                 //     ),
//                 //     SizedBox(
//                 //       width: 10,
//                 //     ),
//                 //     Column(
//                 //       children: [
//                 //         Text(
//                 //           'Wonderful!',
//                 //           style: TextStyle(fontSize: 18),
//                 //         )
//                 //       ],
//                 //     ),
//                 //   ],
//                 // ),
//                 SizedBox(
//                   height: 40,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         color: Color.fromRGBO(255, 248, 220, 0.5),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ButtonTheme(
//                 minWidth: 150,
//                 height: 50,
//                 child: RaisedButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   onPressed: reseveDialog,
//                   child: Text(
//                     'Reserve',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   color: Color.fromRGBO(0, 128, 129, 1),
//                   textColor: Colors.white,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ButtonTheme(
//                 minWidth: 150,
//                 height: 50,
//                 child: RaisedButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   onPressed: closePage,
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   color: Colors.red,
//                   textColor: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
