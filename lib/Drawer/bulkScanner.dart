// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/newChange/scrollabletest.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../utils/color.dart';

// class QRViewExampleBulk extends StatefulWidget {
//   const QRViewExampleBulk({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QRViewExampleBulkState();
// }

// class _QRViewExampleBulkState extends State<QRViewExampleBulk> {
//   Barcode result;
//   QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller.pauseCamera();
//     }
//     controller.resumeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         backgroundColor: Colors.white, // White background color
//         title: const Text(
//           'Bulk Scanner',
//           style: TextStyle(
//             color: MyColors.primaryColor,
//           ), // Red text color
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.black, // Black color for back arrow
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 4, child: _buildQrView(context)),
//             Expanded(
//             flex: 1,
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 if (result != null)
//                 Container(
//                   margin: const EdgeInsets.all(8.0),
//                   child: Text(
//                   ' Data: ${result.code}',
//                   style: const TextStyle(fontSize: 12),
//                   ),
//                 )
//                 else
//                 Container(
//                   margin: const EdgeInsets.all(8.0),
//                   child: const Text(
//                   'Scan a code',
//                   style: TextStyle(fontSize: 12),
//                   ),
//                 ),
//               ],
//               ),
//             ),
//             )
//         ],
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context) {
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) async {
//       setState(() {
//         result = scanData;
//       });
//       await _handleBulkDispatch(result.code);
//     });
//   }

// Future<void> _handleBulkDispatch(String bulkCode) async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token');
//     if (token == null) {
//       throw Exception('No token found in SharedPreferences');
//     }

//     Dio dio = Dio();
//     dio.options.headers = {'Authorization': 'Bearer $token'};

//     // Log the bulkCode
//     log('Scanned bulkCode: $bulkCode');

//     // Make GET request
//     final getUrl =
//         'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode';
//     final getResponse = await dio.get(getUrl);

//     if (getResponse.statusCode == 200) {
//       final status = getResponse.data['data']['status'];
//       log('Status obtained: $status');

//       if (status == 'initiate') {
//         _showConfirmationDialog(
//           'Status is "initiate". Do you want to start dispatch?',
//           () async {
//             // Make POST request to start dispatch
//             final postUrl =
//                 'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-dispatch';
//             await _makePostRequest(dio, postUrl, 'Dispatch started successfully!');
//           },
//         );
//       } else if (status == 'dispatch') {
//         _showConfirmationDialog(
//           'Status is "dispatch". Do you want to start receiving bulk?',
//           () async {
//             // Make POST request to start receiving
//             final postUrl =
//                 'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-receive';
//             await _makePostRequest(dio, postUrl, 'Bulk received successfully!');
//           },
//         );
//       } else if (status == 'complete') {
//         _showAlertDialog(
//           'Bulk already received',
//           'The status is "complete". Bulk has already been received.',
//         );

//       }
//     } else {
//       log('Error: ${getResponse.data}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${getResponse.statusMessage}')),
//       );
//     }
//   } catch (e) {
//     log('Error: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: $e')),
//     );
//   } finally {
//     // Reopen scanner for a new bulk code
//     controller.resumeCamera();
//   }
// }

// Future<void> _makePostRequest(Dio dio, String url, String successMessage) async {
//   try {
//     final postResponse = await dio.post(url);
//     if (postResponse.statusCode == 200) {
//       log(successMessage);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(successMessage)),
//       );
//     } else {
//       log('Error in POST: ${postResponse.data}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${postResponse.data}')),
//       );
//     }
//   } catch (e) {
//     log('Error: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: $e')),
//     );
//   }
// }

// void _showConfirmationDialog(String message, VoidCallback onConfirm) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Confirmation'),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               controller.resumeCamera(); // Reopen scanner
//             },
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               onConfirm(); // Perform the confirmed action
//             },
//             child: const Text('Start'),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _showAlertDialog(String title, String message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: <Widget>[
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               controller.resumeCamera(); // Reopen scanner
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _showDispatchSuccessDialog(String bulkCode) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Dispatch Successful'),
//         content: const Text('Do you want to receive the bulk?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: const Text('No'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.of(context).pop(); // Close the dialog
//               // Make POST request to start receive
//               try {
//                 final prefs = await SharedPreferences.getInstance();
//                 String token = prefs.getString('token');
//                 if (token == null) {
//                   throw Exception('No token found in SharedPreferences');
//                 }

//                 Dio dio = Dio();
//                 dio.options.headers = {'Authorization': 'Bearer $token'};

//                 final receiveUrl =
//                     'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-receive';
//                 final response = await dio.post(receiveUrl);

//                 if (response.statusCode == 200) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Receive operation successful!')),
//                   );
//                 } else {
//                   log('Error: ${response.data}');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Error: ${response.data}')),
//                   );
//                 }
//               } catch (e) {
//                 log('Error: $e');
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error: $e')),
//                 );
//               }
//             },
//             child: const Text('Yes'),
//           ),
//         ],
//       );
//     },
//   );
// }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }








///perfectly working withoud the tarcking code

// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/Drawer/bulkDispatchList.dart';
// import 'package:logistics/newChange/scrollabletest.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../utils/color.dart';

// class QRViewExampleBulk extends StatefulWidget {
//   const QRViewExampleBulk({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QRViewExampleBulkState();
// }

// class _QRViewExampleBulkState extends State<QRViewExampleBulk> {
//   Barcode result;
//   QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   bool _isProcessing = false; // Flag to prevent multiple processing
//   String status;
//   String NewStatus;
//   String senderHub;
//   String reciverHub;
//   String fromHubCode;
//   String toHubCode;
//   String fromHubName;
//   String toHubName;
//   String batchWeight;
//   String batchNumberItems;

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller.pauseCamera();
//     }
//     controller.resumeCamera();
//   }

//   String newStatusget(String status){
//     if(status == 'initiate'){
//       return 'Dispatch';
//     }else if(status == 'dispatch'){
//       return 'Complete';
//     }else{
//       return 'Initiate';
//     }
//   }

//   @override
// Widget build(BuildContext context) {
//   return WillPopScope(
//     onWillPop: () async {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => UserMain()),
//       );
//       return false; // Prevent default back action
//     },
//     child: Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Bulk Scanner',
//           style: TextStyle(
//             color: MyColors.primaryColor,
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 4, child: _buildQrView(context)),
//           Expanded(
//             flex: 1,
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   if (result != null)
//                     Container(
//                       margin: const EdgeInsets.all(8.0),
//                       child: Text(
//                         ' Data: ${result.code}',
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                     )
//                   else
//                     Container(
//                       margin: const EdgeInsets.all(8.0),
//                       child: const Text(
//                         'Scan a code',
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//   Widget _buildQrView(BuildContext context) {
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });

//     controller.scannedDataStream.listen((scanData) async {
//       if (!_isProcessing) {
//         _isProcessing = true; // Set flag to true
//         setState(() {
//           result = scanData;
//         });

//         // Stop the camera immediately to avoid further scans
//         await controller.pauseCamera();

//         // Handle the scanned QR code
//         await _handleBulkDispatch(result.code);

//         // No need to resume camera here since you want to stop it after scanning
//       }
//     });
//   }

//   Future<void> _handleBulkDispatch(String bulkCode) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       String token = prefs.getString('token');
//       if (token == null) {
//         throw Exception('No token found in SharedPreferences');
//       }

//       Dio dio = Dio();
//       dio.options.headers = {'Authorization': 'Bearer $token'};

//       log('Scanned bulkCode: $bulkCode');

//       final getUrl =
//           'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode';
//       final getResponse = await dio.get(getUrl);

//       if (getResponse.statusCode == 200) {

//          status = getResponse.data['data']['status'];
//           fromHubName = getResponse.data['data']['fromHub']['name'];
//           fromHubCode = getResponse.data['data']['fromHub']['code'];
//           toHubName = getResponse.data['data']['toHub']['name'];
//           toHubCode = getResponse.data['data']['toHub']['code'];
//           // batchWeight = getResponse.data['data']['batchWeight'];
//           // batchNumberItems = getResponse.data['data']['batchTotalItem'];
//           batchWeight = getResponse.data['data']['batchWeight'].toString();
// batchNumberItems = getResponse.data['data']['batchTotalItem'].toString();

//         log('Status obtained: $status');

//         if (status == 'initiate') {
//           await _showConfirmationDialog(
//             'Status is "initiate". Do you want to start dispatch?',
//             () async {
//               final postUrl =
//                   'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-dispatch';
//               await _makePostRequest(
//                   dio, postUrl, 'Dispatch started successfully!');
//             },
//           );
//         } else if (status == 'dispatch') {
//           await _showConfirmationDialog(
//             'Status is "dispatch". Do you want to start receiving bulk?',
//             () async {
//               final postUrl =
//                   'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-receive';
//               await _makePostRequest(
//                   dio, postUrl, 'Bulk received successfully!');
//             },
//           );
//         } else if (status == 'complete') {
//           await _showAlertDialog(
//             'Bulk already received',
//             'The status is "complete". Bulk has already been received.',
//           );

//         }
//       } else {
//         log('Error: ${getResponse.data}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${getResponse.statusMessage}')),
//         );
//       }
//     } catch (e) {
//       log('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<void> _showConfirmationDialog(
//     String message, VoidCallback onConfirm) async {
//   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//   var height = MediaQuery.of(context).size.height;
//   var width = MediaQuery.of(context).size.width;
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(14.0))),
//         insetPadding: EdgeInsets.all(16),
//         contentPadding: EdgeInsets.fromLTRB(25, 38, 25, 38),
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
//                 child: Text(
//                   "Do you want to change the status from",
//                   style: TextStyle(
//                       fontFamily: "Roboto",
//                       fontWeight: FontWeight.w700,
//                       color: MyColors.ligtBlack,
//                       fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _infoRow("From:", "$fromHubName ($fromHubCode)"),
//                   _infoRow("To:"," $toHubName ($toHubCode)"),
//                 ],
//               ),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _infoRow("Number of Items:"," ${batchNumberItems.toString()}"),
//                   _infoRow("Batch Weight:",  " ${batchWeight.toString()} kg"),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     height: 65,
//                     width: 72,
//                     margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     child: Center(
//                         child: Text(
//                         status[0].toUpperCase() + status.substring(1),
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w500,
//                           color: MyColors.ligtBlack,
//                           fontSize: 12),
//                       textAlign: TextAlign.center,
//                     )),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: MyColors.lightGrey,
//                     ),
//                   ),
//                   Center(
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                       height: 65,
//                       width: 72,
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Image.asset("assets/images/middivider.png"),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 65,
//                     width: 72,
//                     margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     child: Center(
//                         child: Text(
//                       newStatusget(status),
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w500,
//                           color: MyColors.white,
//                           fontSize: 12),
//                       textAlign: TextAlign.center,
//                     )),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: MyColors.lightSky,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 13),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     width: 138,
//                     height: 48,
//                     margin: EdgeInsets.fromLTRB(8, 32, 0, 11),
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         backgroundColor: MyColors.primaryColor,
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         onConfirm();
//                       },
//                       child: Text(
//                         "OK",
//                         style: TextStyle(
//                           color: MyColors.white,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Container(
//                 width: 138,
//                 height: 48,
//                 alignment: Alignment.center,
//                 margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     backgroundColor: MyColors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => QRViewExampleBulk()));
//                   },
//                   child: Text(
//                     "CANCEL SCAN",
//                     style: TextStyle(
//                       color: MyColors.darkOrange,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// Widget _infoRow(String label, String value) {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: 5),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//               fontSize: 14, fontWeight: FontWeight.bold, color: MyColors.ligtBlack),
//         ),
//         Text(
//           value,
//           style: TextStyle(fontSize: 14, color: MyColors.primaryColor),
//         ),
//       ],
//     ),
//   );
// }

//   Future<void> _showAlertDialog(String title, String message) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => BulkDispatchListScreen()));
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _makePostRequest(
//       Dio dio, String url, String successMessage) async {
//     try {
//       final postResponse = await dio.post(url);
//       if (postResponse.statusCode == 200) {
//         log(successMessage);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(successMessage)),
//         );
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BulkDispatchListScreen(),
//             ));
//       } else {
//         log('Error in POST: ${postResponse.data}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${postResponse.data}')),
//         );
//       }
//     } catch (e) {
//       log('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }















//code with switchin between manual and qr code
// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/Drawer/bulkDispatchList.dart';
// import 'package:logistics/newChange/scrollabletest.dart';
// import 'package:logistics/reusable/custombutton.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../login/login_screen.dart';
// import '../packagedetailpage/package_detail_screen.dart';
// import '../utils/color.dart';

// class QRViewExampleBulk extends StatefulWidget {
//   const QRViewExampleBulk({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QRViewExampleBulkState();
// }

// class _QRViewExampleBulkState extends State<QRViewExampleBulk> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   final TextEditingController trackCodeController = TextEditingController();
//   QRViewController controller;
//   Barcode result;
//   bool _isProcessing = false;
//   bool isScanSelected = true; // Toggle between scanning and manual entry
//   String status;
//   String NewStatus;
//   String senderHub;
//   String reciverHub;
//   String fromHubCode;
//   String toHubCode;
//   String fromHubName;
//   String toHubName;
//   String batchWeight;
//   String batchNumberItems;
//   bool isFirst = true;
//   BuildContext _ctx;
//   bool isDialogOpen = false;

//   void _showErrorDialog(String message) {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//             insetPadding: EdgeInsets.all(16),
//             contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             content: Container(
//               child: new Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(16, 6, 16, 16),
//                     child: Text(
//                       message,
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w700,
//                           color: MyColors.ligtBlack,
//                           fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Container(
//                     color: MyColors.scanDivider,
//                     height: 1,
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         setState(() {});
//                       },
//                       child: Container(
//                           height: 50,
//                           width: 100,
//                           padding: EdgeInsets.all(16),
//                           child: new Text(
//                             "OK",
//                             style: TextStyle(
//                                 color: MyColors.primaryColor,
//                                 fontFamily: "roboto",
//                                 fontWeight: FontWeight.w700),
//                             textAlign: TextAlign.center,
//                           ))),
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     trackCodeController.dispose();
//     super.dispose();
//   }

//   Widget _infoRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: MyColors.ligtBlack),
//           ),
//           Text(
//             value,
//             style: TextStyle(fontSize: 14, color: MyColors.primaryColor),
//           ),
//         ],
//       ),
//     );
//   }

//   String newStatusget(String status) {
//     if (status == 'initiate') {
//       return 'Dispatch';
//     } else if (status == 'dispatch') {
//       return 'Complete';
//     } else {
//       return 'Initiate';
//     }
//   }

//   void _showConfirmationDialogLogOut(String message) {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//             insetPadding: EdgeInsets.all(16),
//             contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             content: Container(
//               child: new Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(16, 6, 16, 16),
//                     child: Text(
//                       message,
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w700,
//                           color: MyColors.ligtBlack,
//                           fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Container(
//                     color: MyColors.scanDivider,
//                     height: 1,
//                   ),
//                   new Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                             setState(() {});
//                           },
//                           child: Container(
//                               height: 50,
//                               width: 100,
//                               padding: EdgeInsets.all(16),
//                               child: new Text(
//                                 "Cancel",
//                                 style: TextStyle(
//                                     color: MyColors.primaryColor,
//                                     fontFamily: "roboto",
//                                     fontWeight: FontWeight.w700),
//                                 textAlign: TextAlign.center,
//                               ))),
//                       GestureDetector(
//                           onTap: () {
//                             setState(() {});
//                             _logout();
//                             Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginScreen()),
//                               (Route<dynamic> route) => false,
//                             );
//                           },
//                           child: Container(
//                               height: 50,
//                               width: 100,
//                               padding: EdgeInsets.all(16),
//                               child: new Text(
//                                 "OK",
//                                 style: TextStyle(
//                                     color: MyColors.primaryColor,
//                                     fontFamily: "roboto",
//                                     fontWeight: FontWeight.w700),
//                                 textAlign: TextAlign.center,
//                               )))
//                     ],
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   void _logout() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('token', "");

//     await prefs.remove('cachedDeliveryList'); // Clear delivery cache
//     print("User logged out. Cache cleared.");
//     // Navigate to login screen
//   }

//   @override
//   Widget build(BuildContext context) {
//     _ctx = context;

//     var qrscan = Text(
//       "QR scan",
//       style: TextStyle(
//           fontFamily: "Roboto",
//           fontWeight: FontWeight.w500,
//           color: isScanSelected ? MyColors.primaryColor : MyColors.darkGreyText,
//           fontSize: 12),
//       textAlign: TextAlign.center,
//     );

//     var withcode = Text(
//       "Track with code",
//       style: TextStyle(
//           fontFamily: "Roboto",
//           fontWeight: FontWeight.w500,
//           color: isScanSelected ? MyColors.darkGreyText : MyColors.primaryColor,
//           fontSize: 12),
//       textAlign: TextAlign.center,
//     );

//     var editTrackingId = Container(
//         padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
//         child: TextField(
//           controller: trackCodeController,
//           obscureText: false,
//           style: TextStyle(color: MyColors.primaryColor),
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//             hintStyle: TextStyle(color: MyColors.white),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(width: 0, style: BorderStyle.none),
//             ),
//             filled: true,
//             fillColor: MyColors.lightGrey,
//           ),
//         ));

//     var trackBtn = CustomButton(
//       buttonText: "Track Order",
//       onPressed: () {
//         if (trackCodeController.text.isEmpty) {
//           _showErrorDialog("Tracking code must not be empty");
//         } else {
//           Navigator.push(
//             _ctx,
//             MaterialPageRoute(
//                 builder: (context) => PackageDetailScreen(
//                       code: trackCodeController.text,
//                     )),
//           );
//         }
//       },
//     );

//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => UserMain()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.logout,
//                 color: MyColors.darkGreyText,
//               ),
//               onPressed: () {
//                 _showConfirmationDialogLogOut(
//                     "Are you sure you want to logout?");
//               },
//             )
//           ],
//           title: Text("Bulk Scanner",
//               style: TextStyle(color: MyColors.darkGreyText, fontSize: 16),
//               textAlign: TextAlign.center),
//           backgroundColor: MyColors.white,
//           automaticallyImplyLeading: false,
//           bottom: PreferredSize(
//               child: Container(
//                 color: MyColors.toolbarBorder,
//                 height: 1.0,
//               ),
//               preferredSize: Size.fromHeight(1.0)),
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Stack(
//                 children: <Widget>[
   
// Column(
//   children: [
//     ConstrainedBox(
//       constraints: BoxConstraints(
//         maxWidth: MediaQuery.of(context).size.width,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           isScanSelected
//               ? Expanded( 
//                   child: _buildQrView(context),
//                 )
//               : Expanded(
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 20),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                                   child: Card(
//                                       color: MyColors.white,
//                                       elevation: 1.0,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(14.0)),
//                                       child: Padding(
//                                         padding: EdgeInsets.all(16.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.stretch,
//                                           children: <Widget>[
//                                             Text(
//                                               "Enter Bulk Code",
//                                               style: TextStyle(
//                                                   fontFamily: "Roboto",
//                                                   fontWeight: FontWeight.w500,
//                                                   color: MyColors.ligtGreyText,
//                                                   fontSize: 12),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                             SizedBox(height: 8),
//                                             editTrackingId,
//                                             SizedBox(height: 8),
//                                             trackBtn,
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ],
//       ),
//     ),
//   ],
// ),
//                   Container(
//                     alignment: Alignment.topCenter,
//                     padding: EdgeInsets.only(top: 20, right: 20.0, left: 20.0),
//                     child: Card(
//                       color: Colors.white,
//                       elevation: 4.0,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 isScanSelected = true;
//                               });
//                             },
//                             child: Column(
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: 25,
//                                   child: isScanSelected
//                                       ? Image.asset(
//                                           "assets/images/activeqricon.png")
//                                       : Image.asset("assets/images/qricon.png"),
//                                 ),
//                                 SizedBox(height: 5),
//                                 qrscan,
//                               ],
//                             ),
//                           ),
//                           Container(
//                             color: MyColors.scanDivider,
//                             width: 2,
//                             height: 50,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 isScanSelected = false;
//                               });
//                             },
//                             child: Column(
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: 25,
//                                   child: isScanSelected
//                                       ? Image.asset(
//                                           "assets/images/withcode.png")
//                                       : Image.asset(
//                                           "assets/images/active_withcode.png"),
//                                 ),
//                                 SizedBox(height: 5),
//                                 withcode,
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final scanArea = screenWidth < 400 ? 150.0 : 300.0;

//     return Container(
//       width: screenWidth, // Constrain width to screen width
//       height: 355.2, // Height from error message
//       child: QRView(
//         key: qrKey,
//         onQRViewCreated: _onQRViewCreated,
//         overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea,
//         ),
//       ),
//     );
//   }


//   Future<void> _showConfirmationDialog(
//       String message, VoidCallback onConfirm) async {
//     TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(14.0))),
//           insetPadding: EdgeInsets.all(16),
//           contentPadding: EdgeInsets.fromLTRB(25, 38, 25, 38),
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
//                   child: Text(
//                     "Do you want to change the status from",
//                     style: TextStyle(
//                         fontFamily: "Roboto",
//                         fontWeight: FontWeight.w700,
//                         color: MyColors.ligtBlack,
//                         fontSize: 16),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _infoRow("From:", "$fromHubName ($fromHubCode)"),
//                     _infoRow("To:", " $toHubName ($toHubCode)"),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _infoRow(
//                         "Number of Items:", " ${batchNumberItems.toString()}"),
//                     _infoRow("Batch Weight:", " ${batchWeight.toString()} kg"),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       height: 65,
//                       width: 72,
//                       margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                       padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                       child: Center(
//                           child: Text(
//                         status[0].toUpperCase() + status.substring(1),
//                         style: TextStyle(
//                             fontFamily: "Roboto",
//                             fontWeight: FontWeight.w500,
//                             color: MyColors.ligtBlack,
//                             fontSize: 12),
//                         textAlign: TextAlign.center,
//                       )),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: MyColors.lightGrey,
//                       ),
//                     ),
//                     Center(
//                       child: Container(
//                         margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                         height: 65,
//                         width: 72,
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Image.asset("assets/images/middivider.png"),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 65,
//                       width: 72,
//                       margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                       padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                       child: Center(
//                           child: Text(
//                         newStatusget(status),
//                         style: TextStyle(
//                             fontFamily: "Roboto",
//                             fontWeight: FontWeight.w500,
//                             color: MyColors.white,
//                             fontSize: 12),
//                         textAlign: TextAlign.center,
//                       )),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: MyColors.lightSky,
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 13),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       width: 138,
//                       height: 48,
//                       margin: EdgeInsets.fromLTRB(8, 32, 0, 11),
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           backgroundColor: MyColors.primaryColor,
//                         ),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           onConfirm();
//                         },
//                         child: Text(
//                           "OK",
//                           style: TextStyle(
//                             color: MyColors.white,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Container(
//                   width: 138,
//                   height: 48,
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
//                   child: TextButton(
//                     style: TextButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       backgroundColor: MyColors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => QRViewExampleBulk()));
//                     },
//                     child: Text(
//                       "CANCEL SCAN",
//                       style: TextStyle(
//                         color: MyColors.darkOrange,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w700,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() => this.controller = controller);
//     controller.scannedDataStream.listen((scanData) async {
//       if (!_isProcessing) {
//         _isProcessing = true;
//         setState(() => result = scanData);
//         await controller.pauseCamera();
//         await _handleBulkDispatch(result.code);
//       }
//     });
//   }

//   Future<void> _handleBulkDispatch(String bulkCode) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       String token = prefs.getString('token');
//       if (token == null) throw Exception('No token found');

//       Dio dio = Dio();
//       dio.options.headers = {'Authorization': 'Bearer $token'};
//       log('Processing bulkCode: $bulkCode');

//       final getUrl =
//           'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode';
//       final getResponse = await dio.get(getUrl);

//       if (getResponse.statusCode == 200) {
//         status = getResponse.data['data']['status'];
//         status = getResponse.data['data']['status'];
//         fromHubName = getResponse.data['data']['fromHub']['name'];
//         fromHubCode = getResponse.data['data']['fromHub']['code'];
//         toHubName = getResponse.data['data']['toHub']['name'];
//         toHubCode = getResponse.data['data']['toHub']['code'];
//         // batchWeight = getResponse.data['data']['batchWeight'];
//         // batchNumberItems = getResponse.data['data']['batchTotalItem'];
//         batchWeight = getResponse.data['data']['batchWeight'].toString();
//         batchNumberItems =
//             getResponse.data['data']['batchTotalItem'].toString();
//         print('Status obtained: $status');
//         await _showConfirmationDialog('Status: $status', () async {
//           final postUrl = status == 'initiate'
//               ? 'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-dispatch'
//               : 'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-receive';
//           await dio.post(postUrl);
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text('Process completed!')));
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => BulkDispatchListScreen()));
//         });
//       }
//     } catch (e) {
//       log('Error: $e');
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }
// }



















import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/Drawer/bulkDispatchList.dart';
import 'package:logistics/newChange/scrollabletest.dart';
import 'package:logistics/reusable/custombutton.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_screen.dart';
import '../packagedetailpage/package_detail_screen.dart';
import '../utils/color.dart';
import 'package:lucide_icons/lucide_icons.dart';

class QRViewExampleBulk extends StatefulWidget {
  const QRViewExampleBulk({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleBulkState();
}

class _QRViewExampleBulkState extends State<QRViewExampleBulk> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final TextEditingController trackCodeController = TextEditingController();
  QRViewController controller;
  Barcode result;
  bool _isProcessing = false;
  bool isScanSelected = true; // Toggle between scanning and manual entry
  String status;
  String NewStatus;
  String senderHub;
  String reciverHub;
  String fromHubCode;
  String toHubCode;
  String fromHubName;
  String toHubName;
  String batchWeight;
  String batchNumberItems;
  bool isFirst = true;
  BuildContext _ctx;
  bool isDialogOpen = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 6, 16, 16),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      color: MyColors.ligtBlack,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  color: MyColors.scanDivider,
                  height: 1,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: MyColors.primaryColor,
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    trackCodeController.dispose();
    super.dispose();
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.ligtBlack,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14, color: MyColors.primaryColor),
          ),
        ],
      ),
    );
  }

  String newStatusget(String status) {
    if (status == 'initiate') {
      return 'Dispatch';
    } else if (status == 'dispatch') {
      return 'Complete';
    } else {
      return 'Initiate';
    }
  }

  void _showConfirmationDialogLogOut(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 6, 16, 16),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      color: MyColors.ligtBlack,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  color: MyColors.scanDivider,
                  height: 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                        _logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: MyColors.primaryColor,
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");
    await prefs.remove('cachedDeliveryList'); // Clear delivery cache
    print("User logged out. Cache cleared.");
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var qrscan = Text(
      "QR scan",
      style: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: isScanSelected ? MyColors.primaryColor : MyColors.darkGreyText,
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
    );

    var withcode = Text(
      "Track with code",
      style: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: isScanSelected ? MyColors.darkGreyText : MyColors.primaryColor,
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
    );

    var editTrackingId = Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: TextField(
        controller: trackCodeController,
        obscureText: false,
        style: TextStyle(color: MyColors.primaryColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintStyle: TextStyle(color: MyColors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
          filled: true,
          fillColor: MyColors.lightGrey,
        ),
      ),
    );

    var trackBtn = CustomButton(
      buttonText: "Track Order",
      onPressed: () {
        if (trackCodeController.text.isEmpty) {
          _showErrorDialog("Tracking code must not be empty");
        } else {
          // Navigator.push(
          //   _ctx,
          //   MaterialPageRoute(
          //     builder: (context) => PackageDetailScreen(
          //       code: trackCodeController.text,
          //     ),
          //   ),
          // );
          //  _handleBulkDispatch(result.code);
          _handleBulkDispatch(trackCodeController.text);
           
        }
      },
    );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserMain()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: MyColors.darkGreyText,
              ),
              onPressed: () {
                _showConfirmationDialogLogOut(
                    "Are you sure you want to logout?");
              },
            ),
          ],
          title: Text(
            "Bulk Scanner",
            style: TextStyle(color: MyColors.darkGreyText, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          backgroundColor: MyColors.white,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            child: Container(
              color: MyColors.toolbarBorder,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(height: 100),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            isScanSelected
                                ? Expanded(child: _buildQrView(context))
                                : Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Card(
                                            color: MyColors.white,
                                            elevation: 1.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                    "Enter Bulk Code",
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: MyColors
                                                          .ligtGreyText,
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SizedBox(height: 8),
                                                  editTrackingId,
                                                  SizedBox(height: 8),
                                                  trackBtn,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding:
                        EdgeInsets.only(top: 20, right: 20.0, left: 20.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isScanSelected = true;
                              });
                            },
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 25,
                                  child: isScanSelected
                                      ? Image.asset(
                                          "assets/images/activeqricon.png")
                                      : Image.asset("assets/images/qricon.png"),
                                ),
                                SizedBox(height: 5),
                                qrscan,
                              ],
                            ),
                          ),
                          Container(
                            color: MyColors.scanDivider,
                            width: 2,
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isScanSelected = false;
                              });
                            },
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 25,
                                  child: isScanSelected
                                      ? Image.asset(
                                          "assets/images/withcode.png")
                                      : Image.asset(
                                          "assets/images/active_withcode.png"),
                                ),
                                SizedBox(height: 5),
                                withcode,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final scanArea = screenWidth < 400 ? 150.0 : 300.0;

    return Container(
      width: screenWidth, // Constrain width to screen width
      height: screenHeight, // Height based on screen height
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea,
        ),
      ),
    );
  }

Widget locationDisplay(String fromLocation, String toLocation) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min, // Prevents overflow
      children: [
       
        Flexible(
          child: Text(
            fromLocation,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
           
          ),
        ),
        
        Icon(LucideIcons.arrowRight, color: Colors.blue, size: 20),
        const SizedBox(width: 18),
        Flexible(
          child: Text(
            toLocation,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            
          ),
        ),
        
      ],
    ),
  );
}

  Future<void> _showConfirmationDialog(
      String message, VoidCallback onConfirm) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
          ),
          insetPadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.fromLTRB(25, 38, 25, 38),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     _infoRow("", "$fromHubName ($fromHubCode)"),
                //     _infoRow("->", "$toHubName ($toHubCode)"),
                //   ],
                // ),
                locationDisplay("$fromHubName ($fromHubCode)", "$toHubName ($toHubCode)"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoRow(
                        "Number of Items: ", "${batchNumberItems.toString()}"),
                    _infoRow("Batch Weight: ", "${batchWeight.toString()} kg"),
                  ],
                ),
               
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
                  child: Text(
                    "Do you want to change the status from",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      color: MyColors.ligtBlack,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 65,
                      width: 72,
                      margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Center(
                        child: Text(
                          status[0].toUpperCase() + status.substring(1),
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            color: MyColors.ligtBlack,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.lightGrey,
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
                        height: 65,
                        width: 72,
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/middivider.png"),
                        ),
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 72,
                      margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Center(
                        child: Text(
                          newStatusget(status),
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            color: MyColors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.lightSky,
                      ),
                    )
                  ],
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 138,
                      height: 48,
                      margin: EdgeInsets.fromLTRB(8, 32, 0, 11),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: MyColors.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: MyColors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 138,
                  height: 48,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: MyColors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRViewExampleBulk()),
                      );
                    },
                    child: Text(
                      "CANCEL SCAN",
                      style: TextStyle(
                        color: MyColors.darkOrange,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) async {
      if (!_isProcessing) {
        _isProcessing = true;
        setState(() => result = scanData);
        await controller.pauseCamera();
        await _handleBulkDispatch(result.code);
      }
    });
  }

  // Future<void> _handleBulkDispatch(String bulkCode) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     String token = prefs.getString('token');
  //     if (token == null) throw Exception('No token found');

  //     Dio dio = Dio();
  //     dio.options.headers = {'Authorization': 'Bearer $token'};
  //     log('Processing bulkCode: $bulkCode');

  //     final getUrl =
  //         'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode';
  //     final getResponse = await dio.get(getUrl);

  //     if (getResponse.statusCode == 200) {
  //       status = getResponse.data['data']['status'];
  //       fromHubName = getResponse.data['data']['fromHub']['name'];
  //       fromHubCode = getResponse.data['data']['fromHub']['code'];
  //       toHubName = getResponse.data['data']['toHub']['name'];
  //       toHubCode = getResponse.data['data']['toHub']['code'];
  //       batchWeight = getResponse.data['data']['batchWeight'].toString();
  //       batchNumberItems = getResponse.data['data']['batchTotalItem'].toString();
  //       print('Status obtained: $status');

  //       await _showConfirmationDialog('Status: $status', () async {
  //         final postUrl = status == 'initiate'
  //             ? 'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-dispatch'
  //             : 'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-receive';
  //         await dio.post(postUrl);
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text('Process completed!')));
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => BulkDispatchListScreen()));
  //       });
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error: $e')));
  //   } finally {
  //     _isProcessing = false;
  //     await controller.resumeCamera();
  //   }
  // }


  Future<void> _handleBulkDispatch(String bulkCode) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null) throw Exception('No token found');

    Dio dio = Dio();
    dio.options.headers = {'Authorization': 'Bearer $token'};
    log('Processing bulkCode: $bulkCode');

    final getUrl =
        'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode';
    final getResponse = await dio.get(getUrl);

    if (getResponse.statusCode == 200) {
      status = getResponse.data['data']['status'];
      fromHubName = getResponse.data['data']['fromHub']['name'];
      fromHubCode = getResponse.data['data']['fromHub']['code'];
      toHubName = getResponse.data['data']['toHub']['name'];
      toHubCode = getResponse.data['data']['toHub']['code'];
      batchWeight = getResponse.data['data']['batchWeight'].toString();
      batchNumberItems = getResponse.data['data']['batchTotalItem'].toString();
      print('Status obtained: $status');

      if (status == 'complete') {
        await _showCompleteAlertDialog('Bulk already received', 'The status is "Complete". Bulk has already been received.');
      } else {
        await _showConfirmationDialog('Status: $status', () async {
          final postUrl = status == 'initiate'
              ? 'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-dispatch'
              : 'https://www.dashlogistics.dev/api/v1/employee/bulkdispatch/$bulkCode/start-receive';
          await dio.post(postUrl);
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Process completed!')));
          _showTopSnackBarSucess(context, "Process completed!");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BulkDispatchListScreen()));
        });
      }
    }
  } catch (e) {
    log('Error: $e');
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Error: $e')));
    //  ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Please scan a valid Bulk code.This code is not valid')));
        _showTopSnackBar(context, "Please scan a valid Bulk code.This code is not valid");
  } finally {
    _isProcessing = false;
    await controller.resumeCamera();
  }
}

Future<void> _showCompleteAlertDialog(String title, String message) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        insetPadding: EdgeInsets.all(16),
        contentPadding: EdgeInsets.fromLTRB(25, 38, 25, 38),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700,
                    color: MyColors.ligtBlack,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoRow("From:", "$fromHubName ($fromHubCode)"),
                  _infoRow("To:", "$toHubName ($toHubCode)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoRow("Number of Items:", "${batchNumberItems.toString()}"),
                  _infoRow("Batch Weight:", "${batchWeight.toString()} kg"),
                ],
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: MyColors.ligtBlack,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                width: 138,
                height: 48,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: MyColors.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BulkDispatchListScreen()),
                    );
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: MyColors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


 void _showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 85.6, // Position at the top
        left: 0,
        right: 0,
        child: Material(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.red,
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    
    // Automatically remove the SnackBar after a delay
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }


   void _showTopSnackBarSucess(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 85.6, // Position at the top
        left: 0,
        right: 0,
        child: Material(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    
    // Automatically remove the SnackBar after a delay
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }



}