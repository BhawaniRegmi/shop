// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:logistics/newChange/searchScreen.dart';
// import 'package:logistics/newChange/test.dart';
// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';

// class PaymentRequestScreen extends StatefulWidget {
//   @override
//   _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
// }

// class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController noteController = TextEditingController();
//   File _voucherImage;
//   // Future<void> _openCamera() async {
//   //   final picker = ImagePicker();
//   //   final pickedFile = await picker.pickImage(source: ImageSource.camera);

//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       _voucherImage = File(pickedFile.path);
//   //     });
//   //   }
//   // }

//   Future<void> _openCamera() async {
//   // Request camera permission
//   if (await Permission.camera.request().isGranted) {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       setState(() {
//         _voucherImage = File(pickedFile.path);
//       });
//     }
//   } else {
//     // Handle permission denied
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Camera permission denied')),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> widgetList = [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 50,
//             child: TextField(
//               controller: amountController,
//               decoration: InputDecoration(
//                 labelText: 'Rs',
//                 prefixIcon: Icon(Icons.attach_money, color: Colors.red),
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//           ),
//           SizedBox(height: 16.0),
//           TextField(
//             controller: noteController,
//             decoration: InputDecoration(
//               labelText: 'Note',
//               prefixIcon: Icon(Icons.note, color: Colors.red),
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 3,
//           ),
//           SizedBox(height: 24.0),
//           Text(
//             "Voucher Image",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 2.0),
//           Row(
//             children: [SizedBox(width: 110,),
//               GestureDetector(
//                 onTap: _openCamera,
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.grey[300],
//                   backgroundImage:
//                       _voucherImage != null ? FileImage(_voucherImage) : null,
//                   child: _voucherImage == null
//                       ? Icon(Icons.camera_alt, color: Colors.grey, size: 40)
//                       : null,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 18.0),
//           Center(
//             child: ElevatedButton( 
//               onPressed: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => UserMain()),
//   );
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.red,
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//               ),
//               child: Text("Submit", style: TextStyle(fontSize: 16)),
//             ),
//           ),
//         ],
//       ),
//     ];

//     return SingleChildScrollView(
//   padding: const EdgeInsets.all(13.0), // Apply a small padding
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: widgetList,
//   ),
// );

//   }
// }





























// this is the code with rs icon and note icon

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';

// import '../newChange/scrollabletest.dart';

// class PaymentRequestScreen extends StatefulWidget {
//   @override
//   _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
// }

// class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController noteController = TextEditingController();
//   File _voucherImage;
//    CameraController _cameraController;
//    List<CameraDescription> _cameras;
//   bool isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   // Initialize the camera
//   Future<void> _initializeCamera() async {
//     _cameras = await availableCameras();
//     _cameraController = CameraController(_cameras[0], ResolutionPreset.high);

//     // Wait until the camera is initialized
//     await _cameraController.initialize();
//     setState(() {
//       isCameraInitialized = true;
//     });
//   }

//   // Capture the image and save it after adjusting the camera
//   Future<void> _takePicture() async {
//     if (await Permission.camera.request().isGranted) {
//       try {
//         final Directory appDirectory = await getApplicationDocumentsDirectory();
//         final String picturePath = '${appDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

//         final XFile pictureFile = await _cameraController.takePicture();
//         await pictureFile.saveTo(picturePath);

//         setState(() {
//           _voucherImage = File(picturePath);
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Picture saved to $picturePath'), duration: Duration(milliseconds: 1500), ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to take picture: $e')),
//         );
//       }
//     } else {
//       // Handle permission denied
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Camera permission denied')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> widgetList = [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 50,
//             child: TextField(
//               controller: amountController,
//               decoration: InputDecoration(
//                 labelText: 'Rs',
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image.asset('assets/images/nepRs.png', width: 24, height: 24),
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//           ),
//           SizedBox(height: 16.0),
//           TextField(
//             controller: noteController,
//             decoration: InputDecoration(
//               labelText: 'Note',
//               prefixIcon: Icon(Icons.note, color: Colors.red),
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 3,
//           ),
//           SizedBox(height: 24.0),
//           Text(
//             "Voucher Image",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10.0),
//           Row(mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // SizedBox(width: 110),
//               // SizedBox(width: 30),
//               isCameraInitialized
//                   ? SizedBox(
//                       height: 250,
//                       width: 250,
//                       child: CameraPreview(_cameraController), // Camera preview
//                     )
//                   : CircularProgressIndicator(), // Show loading until camera is initialized
//             ],
//           ),
//           SizedBox(height: 18.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: _takePicture,
//                 child: Text("Capture Image"),
//                 style: ElevatedButton.styleFrom(primary: Colors.red),
//               ),
//             ],
//           ),
//           SizedBox(height: 18.0),
//           Row(mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               //SizedBox(width: 90,),
//               _voucherImage != null
//                   ? Container(
//   height: 200,  // Set the height
//   width: 200,   // Set the width
//   decoration: BoxDecoration(
//     color: Colors.grey[300],  // Set a background color when no image is selected
//     image: _voucherImage != null
//         ? DecorationImage(
//             image: FileImage(_voucherImage),  // Display the captured image
//             fit: BoxFit.cover,  // Ensure the image covers the container
//           )
//         : null,  // No image, so no DecorationImage
//   ),
//   child: _voucherImage == null
//       ? Icon(
//           Icons.camera_alt,  // Show the camera icon when no image is selected
//           color: Colors.grey,
//           size: 40,
//         )
//       : null,  // Don't show the camera icon if an image is present
// )

//                   : Container(),
//             ],
//           ),
//           SizedBox(height: 18.0),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => UserMain()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.red,
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//               ),
//               child: Text("Submit", style: TextStyle(fontSize: 16)),
//             ),
//           ),
//           SizedBox(height: 40,)
//         ],
//       ),
//     ];

//     return Scaffold(
//           appBar: AppBar(
//         title: Text(
//           "Payment Voucher",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         actions: [
//             TextButton(
//             onPressed: () {},
//             child: Text(
//               'View History',
//               style: TextStyle(color: Colors.blue, fontSize: 12),
//             ),
//             ),
//         ],
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(13.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: widgetList,
//         ),
//       ),
//     );
//   }
// }


// code for delete and show voucher without text field and camera 

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PaymentRequestScreen extends StatefulWidget {
//   @override
//   _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
// }

// class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController noteController = TextEditingController();
//   final TextEditingController idController = TextEditingController();
//   File _voucherImage;
//    CameraController _cameraController;
//    List<CameraDescription> _cameras;
//   bool isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     _cameras = await availableCameras();
//     _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
//     await _cameraController.initialize();
//     setState(() {
//       isCameraInitialized = true;
//     });
//   }

//   Future<void> _fetchVoucherList() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.get(
//         'https://dashlogistics.com.np/api/v1/employee/ridervoucher',
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voucher List fetched successfully!')),
//         );
//         print(response.data); // Process and display response data here
//       } else {
//         throw Exception('Failed to fetch voucher list');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<void> _fetchVoucherShow(int id) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.get(
//         'https://dashlogistics.com.np/api/v1/employee/ridervoucher/show/$id',
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voucher details fetched successfully!')),
//         );
//         print(response.data); // Process and display response data here
//       } else {
//         throw Exception('Failed to fetch voucher details');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<void> _deleteVoucher(int id) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.post(
//         'https://dashlogistics.com.np/api/v1/employee/ridervoucher/destroy/$id',
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voucher deleted successfully!')),
//         );
//       } else {
//         throw Exception('Failed to delete voucher');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Payment Voucher",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: _fetchVoucherList,
//             child: Text(
//               'Voucher List',
//               style: TextStyle(color: Colors.blue, fontSize: 12),
//             ),
//           ),
//         ],
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(13.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("Enter ID to Show Voucher"),
//                       content: TextField(
//                         controller: idController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(hintText: "Enter ID"),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             final id = int.tryParse(idController.text);
//                             if (id != null) {
//                               _fetchVoucherShow(id);
//                               Navigator.of(context).pop();
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text("Invalid ID")),
//                               );
//                             }
//                           },
//                           child: Text("Show"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Text('Voucher Show'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("Enter ID to Delete Voucher"),
//                       content: TextField(
//                         controller: idController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(hintText: "Enter ID"),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             final id = int.tryParse(idController.text);
//                             if (id != null) {
//                               _deleteVoucher(id);
//                               Navigator.of(context).pop();
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text("Invalid ID")),
//                               );
//                             }
//                           },
//                           child: Text("Delete"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Text('Delete Voucher'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//all done with camera but no submit .there is voucher show and delet voucher 
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PaymentRequestScreen extends StatefulWidget {
//   @override
//   _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
// }

// class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController noteController = TextEditingController();
//   final TextEditingController idController = TextEditingController();
//   File _voucherImage;
//    CameraController _cameraController;
//    List<CameraDescription> _cameras;
//   bool isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     _cameras = await availableCameras();
//     _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
//     await _cameraController.initialize();
//     setState(() {
//       isCameraInitialized = true;
//     });
//   }

//   Future<void> _fetchVoucherList() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.get(
//         'https://dashlogistics.dev/api/v1/employee/ridervoucher',
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voucher List fetched successfully!')),
//         );
//         print(response.data); // Process and display response data here
//       } else {
//         throw Exception('Failed to fetch voucher list');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<void> _fetchVoucherShow(int id) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.get(
//         'https://dashlogistics.dev/api/v1/employee/ridervoucher/show/$id',
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voucher details fetched successfully!')),
//         );
//         print(response.data); // Process and display response data here
//       } else {
//         throw Exception('Failed to fetch voucher details');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<void> _deleteVoucher(int id) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.post(
//         'https://dashlogistics.dev/api/v1/employee/ridervoucher/destroy/$id',
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voucher deleted successfully!')),
//         );
//       } else {
//         throw Exception('Failed to delete voucher');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

// Future<void> _captureImage() async {
//   if (!isCameraInitialized) return;

//   try {
//     final XFile imageFile = await _cameraController.takePicture();
//     setState(() {
//       _voucherImage = File(imageFile.path); // Convert XFile to File for display
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Image captured successfully!")),
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error capturing image: $e")),
//     );
//   }
// }


//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Payment Voucher",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: _fetchVoucherList,
//             child: Text(
//               'Voucher List',
//               style: TextStyle(color: Colors.blue, fontSize: 12),
//             ),
//           ),
//         ],
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(13.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Rs'),
//             ),
//             TextField(
//               controller: noteController,
//               decoration: InputDecoration(labelText: 'Note'),
//             ),
//             SizedBox(height: 10),
//             isCameraInitialized
//                 ? Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         child: CameraPreview(_cameraController),
//                       ),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: _captureImage,
//                         child: Text('Capture Image'),
//                       ),
//                       if (_voucherImage != null)
//                         Image.file(
//                           _voucherImage,
//                           height: 100,
//                           width: 100,
//                         ),
//                     ],
//                   )
//                 : Center(child: CircularProgressIndicator()),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("Enter ID to Show Voucher"),
//                       content: TextField(
//                         controller: idController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(hintText: "Enter ID"),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             final id = int.tryParse(idController.text);
//                             if (id != null) {
//                               _fetchVoucherShow(id);
//                               Navigator.of(context).pop();
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text("Invalid ID")),
//                               );
//                             }
//                           },
//                           child: Text("Show"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Text('Voucher Show'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("Enter ID to Delete Voucher"),
//                       content: TextField(
//                         controller: idController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(hintText: "Enter ID"),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             final id = int.tryParse(idController.text);
//                             if (id != null) {
//                               _deleteVoucher(id);
//                               Navigator.of(context).pop();
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text("Invalid ID")),
//                               );
//                             }
//                           },
//                           child: Text("Delete"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Text('Delete Voucher'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// working code with showing alert dialog of voucher list ,showing camera and submit button as well
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PaymentRequestScreen extends StatefulWidget {
//   @override
//   _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
// }

// class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController noteController = TextEditingController();
//   final TextEditingController idController = TextEditingController();
//   File _voucherImage;
//   CameraController _cameraController;
//   List<CameraDescription> _cameras;
//   bool isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     _cameras = await availableCameras();
//     _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
//     await _cameraController.initialize();
//     setState(() {
//       isCameraInitialized = true;
//     });
//   }

//   Future<void> _submitVoucher() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');
//       if (_voucherImage == null) throw Exception('Image not captured');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final formData = FormData.fromMap({
//         'amount': amountController.text,
//         'note': noteController.text,
//         'image': await MultipartFile.fromFile(_voucherImage.path),
//       });
//       print("this is the string for form data");
//       print("Image: ${formData.files.firstWhere((file) => file.key == 'image').value.filename}");
      
     

//       final response = await dio.post(
//         'https://dashlogistics.dev/api/v1/employee/ridervoucher/store',
//         data: formData,
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voucher submitted successfully!')),
//         );
//       } else {
//         throw Exception('Failed to submit voucher');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<void> _fetchVoucherList() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.get(
//         'https://dashlogistics.dev/api/v1/employee/ridervoucher',
//       );

//       if (response.statusCode == 200) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Voucher List'),
//               content: Text(response.data.toString()),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Close'),
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         throw Exception('Failed to fetch voucher list');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<void> _captureImage() async {
//     if (!isCameraInitialized) return;

//     try {
//       final XFile imageFile = await _cameraController.takePicture();
//       setState(() {
//         _voucherImage = File(imageFile.path); // Convert XFile to File for display
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Image captured successfully!")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error capturing image: $e")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Payment Voucher",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(13.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Rs'),
//             ),
//             TextField(
//               controller: noteController,
//               decoration: InputDecoration(labelText: 'Note'),
//             ),
//             SizedBox(height: 10),
//             isCameraInitialized
//                 ? Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         child: CameraPreview(_cameraController),
//                       ),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: _captureImage,
//                         child: Text('Capture Image'),
//                       ),
//                       if (_voucherImage != null)
//                         Image.file(
//                           _voucherImage,
//                           height: 100,
//                           width: 100,
//                         ),
//                     ],
//                   )
//                 : Center(child: CircularProgressIndicator()),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _submitVoucher,
//               child: Text('Submit'),
//             ),
//             ElevatedButton(
//               onPressed: _fetchVoucherList,
//               child: Text('Voucher List'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




//everything working even submit button
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:logistics/Drawer/drawer.dart';
import 'package:logistics/Drawer/privacyPolicy.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Voucher/voucherList.dart';
import '../login/login_screen.dart';
import '../newChange/aboutUs.dart';
import '../newChange/rateApp.dart';
import '../newChange/riderDetailsScreen.dart';
import '../newChange/sidebarNotification.dart';
import '../utils/color.dart';

class PaymentRequestScreen extends StatefulWidget {
  @override
  _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
}

class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  File _voucherImage;
  CameraController _cameraController;
  List<CameraDescription> _cameras;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  // Future<void> _submitVoucher() async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String token = prefs.getString('token');

  //     if (token == null) throw Exception('Token not found');
  //     if (_voucherImage == null) throw Exception('Image not captured');

  //     final Dio dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $token';

  //     final formData = FormData.fromMap({
  //       'amount': amountController.text,
  //       'note': noteController.text,
  //       'image': await MultipartFile.fromFile(_voucherImage.path),
  //     });

  //     final response = await dio.post(
  //       'https://dashlogistics.dev/api/v1/employee/ridervoucher/store',
  //       data: formData,
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Voucher submitted successfully!')),
  //       );
  //     } else if (response.statusCode == 302) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Redirected! Please check the URL or login session.')),
  //       );
  //     } else {
  //       throw Exception('Failed to submit voucher');
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   }
  // }


// Future<void> _submitVoucher() async {
//   try {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String token = prefs.getString('token');
//     if (token == null) throw Exception('Token not found');
//     if (amountController.text.isEmpty) throw Exception('Amount is required');
//     if (noteController.text.isEmpty) throw Exception('Note is required');
//     if (_voucherImage == null) throw Exception('Voucher Image is required');

//     final Dio dio = Dio();
//     dio.options.headers['Authorization'] = 'Bearer $token';
//     dio.options.headers['Accept'] = 'application/json';

//     print('Authorization Header: Bearer $token');

//     final formData = FormData.fromMap({
//       'voucherPayment': amountController.text,
//       'voucherNote': noteController.text,
//       'voucherImage': await MultipartFile.fromFile(_voucherImage.path),
//     });

//     final response = await dio.post(
//       'https://dashlogistics.dev/api/v1/employee/ridervoucher/store',
//       data: formData,
//       options: Options(
//         followRedirects: false,
//         validateStatus: (status) => status < 500,
//       ),
//     );

//     print('Response status: ${response.statusCode}');
//     print('Response data: ${response.data}');

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Voucher submitted successfully!')),
//       );
//     } else if (response.statusCode == 422) {
//       final errors = response.data['errors'];
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Validation Errors: $errors')),
//       );
//     } else {
//       throw Exception('Failed to submit voucher. Status: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: $e')),
//     );
//   }
// }

Future<void> _submitVoucher() async {
  // Show the loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    if (token == null) throw Exception('Token not found');
    if (amountController.text.isEmpty) throw Exception('Amount is required');
    if (noteController.text.isEmpty) throw Exception('Note is required');
    if (_voucherImage == null) throw Exception('Voucher Image is required');

    final Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    dio.options.headers['Accept'] = 'application/json';

    print('Authorization Header: Bearer $token');

    final formData = FormData.fromMap({
      'voucherPayment': amountController.text,
      'voucherNote': noteController.text,
      'voucherImage': await MultipartFile.fromFile(_voucherImage.path),
    });

    final response = await dio.post(
      'https://dashlogistics.dev/api/v1/employee/ridervoucher/store',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) => status < 500,
      ),
    );

    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');

    // Close the loading dialog
    Navigator.of(context).pop();

    if (response.statusCode == 200 || response.statusCode == 201) {
      _showSnackBar('Voucher submitted successfully!');
      // Navigate to Voucher List
      _fetchVoucherList();
    } else if (response.statusCode == 422) {
      final errors = response.data['errors'];
      _showSnackBar('Validation Errors: $errors');
    } else {
      throw Exception('Failed to submit voucher. Status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    // Close the loading dialog in case of an error
    Navigator.of(context).pop();
    _showSnackBar('Error: $e');
  }
}

// Helper function to show SnackBar at the top
void _showSnackBar(String message) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: kToolbarHeight + 10, left: 10, right: 10),
    ),
  );
}




  // Future<void> _fetchVoucherList() async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String token = prefs.getString('token');

  //     if (token == null) throw Exception('Token not found');

  //     final Dio dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $token';

  //     final response = await dio.get(
  //       'https://dashlogistics.dev/api/v1/employee/ridervoucher',
  //     );

  //     if (response.statusCode == 200) {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => VoucherList(response: response.data),));
  //     } else {
  //       throw Exception('Failed to fetch voucher list');
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   }
  // }


  Future<void> _fetchVoucherList() async {
  // Show the loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if (token == null) throw Exception('Token not found');

    final Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await dio.get(
      'https://dashlogistics.dev/api/v1/employee/ridervoucher',
    );

    // Close the loading dialog
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VoucherList(response: response.data),
        ),
      );
    } else {
      throw Exception('Failed to fetch voucher list');
    }
  } catch (e) {
    // Close the loading dialog in case of an error
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  Future<void> _fetchVoucherShow(int id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'https://dashlogistics.dev/api/v1/employee/ridervoucher/show/$id',
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voucher details fetched successfully!')),
        );
        print(response.data); // Process and display response data here
      } else {
        throw Exception('Failed to fetch voucher details');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _deleteVoucher(int id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'https://dashlogistics.dev/api/v1/employee/ridervoucher/destroy/$id',
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voucher deleted successfully!')),
        );
      } else {
        throw Exception('Failed to delete voucher');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _captureImage() async {
    if (!isCameraInitialized) return;

    try {
      final XFile imageFile = await _cameraController.takePicture();
      setState(() {
        _voucherImage = File(imageFile.path); // Convert XFile to File for display
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Image captured successfully!")),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error capturing image: $e")),
      );
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
     void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");

   
  await prefs.remove('cachedDeliveryList'); // Clear delivery cache
  print("User logged out. Cache cleared.");
  // Navigate to login screen
    
  }



   void _showConfirmationDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            insetPadding: EdgeInsets.all(16),
            contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Container(
              child: new Column(
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
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    color: MyColors.scanDivider,
                    height: 1,
                  ),
                  new Row(
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
                              child: new Text(
                                "Cancel",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontFamily: "roboto",
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ))),
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
                              child: new Text(
                                "OK",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontFamily: "roboto",
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              )))
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

  drawer: MyDrawer(),

       appBar: AppBar(
        title: Text(
          "Payment Voucher",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
            TextButton(
            //onPressed: () {},
            onPressed: _fetchVoucherList,
            child: Text(
              'View History',
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
            ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField(
            //   controller: amountController,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(labelText: 'Rs'),
            // ),
            // TextField(
            //   controller: noteController,
            //   decoration: InputDecoration(labelText: 'Note'),
            // ),

                  SizedBox(height: 50,
            child: TextField(
  controller: amountController,
  decoration: InputDecoration(
    labelText: 'Rs',
    prefixIcon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/images/nepRs.png',
        width: 16, // Reduced width
        height: 16, // Reduced height
      ),
    ),
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.number,
),

          ),
          SizedBox(height: 16.0),
          TextField(
            controller: noteController,
            decoration: InputDecoration(
              labelText: 'Note',
            prefixIcon: Icon(Icons.note, color: Color(0xFFCF0000)),
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),

             SizedBox(height: 24.0),
            Center(
            child: Text(
              "Voucher Image",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ),
          
            SizedBox(height: 10),
            isCameraInitialized
                ? Column(
                    children: [
                        Center(
                        child: Container(
                          width: 250,
                          height: 250,
                          child: CameraPreview(_cameraController),
                        ),
                        ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _captureImage,
                        child: Text('Capture Image'),
                      ),
                      if (_voucherImage != null)
                        Center(
  child: Image.file(
    _voucherImage,
    height: 250,
    width: MediaQuery.of(context).size.width, // Full screen width
    fit: BoxFit.cover, // Adjust the fit as per your requirement
  ),
),

                    ],
                  )
                : Center(child: CircularProgressIndicator()),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitVoucher,
              style: ElevatedButton.styleFrom(
              primary: Colors.red,
              minimumSize: Size(double.infinity, 50), // Full width and fixed height
              ),
              child: Text('Submit'),
            ),
            SizedBox(height: 50,)
           
          ],
        ),
      ),
    );
  }
}






