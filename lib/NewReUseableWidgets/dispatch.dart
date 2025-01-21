// import 'package:flutter/material.dart';
// import 'package:logistics/newChange/commentList.dart';
// import 'package:logistics/packagedetailpage/package_detail_screen.dart';
// import 'package:logistics/response/PackageDetailM.dart';
// import 'package:logistics/scan.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';

// class DynamicListScreen extends StatelessWidget {

// PackageDetailM detail;

//   // final String phoneNumber = "+9779865248671";

//   // Future<void> _makePhoneCall(BuildContext context) async {
//   //   // Check and request CALL_PHONE permission
//   //   if (await Permission.phone.request().isGranted) {
//   //     final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

//   //     if (await canLaunchUrl(phoneUri)) {
//   //       await launchUrl(phoneUri);
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Unable to launch dialer')),
//   //       );
//   //     }
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Permission denied. Cannot make a call.')),
//   //     );
//   //   }
//   // }

// final String phoneNumber = "+9779865248671";

//   Future<void> _makePhoneCall(BuildContext context) async {
//     final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

//     if (await canLaunchUrl(phoneUri)) {
//       await launchUrl(phoneUri);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Dialer app not available on this device')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> textList = [
//       Container(
//         padding: EdgeInsets.all(16.0), // Add padding around the text
//         margin: EdgeInsets.all(10.0), // Add margin around the container
//         decoration: BoxDecoration(
//           color: Colors.blue[100], // Background color for the container
//           borderRadius: BorderRadius.circular(10), // Rounded corners
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3), // Shadow position
//             ),
//           ],
//         ),
//         child: Text(
//           "Empty, Please Refresh",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue[800],
//           ),
//           textAlign: TextAlign.center,
//         ),
//       )
//     ];
//     List<Widget> widgetList = [
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//           children: [
//             Text(
//              // "Medicine",
//              detail.productName,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "    5",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: .4),
//                     Text(
//                       "      Nov 2024",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.6),
//                     Text(
//                       "      1 Kg",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Text(
//                       "      Rs 250",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Ravi Giri",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                   Row(children: [  IconButton(
//                       icon: Icon(Icons.remove_red_eye, color: Colors.red,size: 35,),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   PackageDetailScreen(code: "ZRB2411KTM5H4E")),
//                         );
//                       },
//                     ),
//                     SizedBox(width: 8,),
//                     IconButton(
//                       icon: Icon(Icons.comment, color: Colors.red,size: 35,),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CommentList()),
//                         );
//                       },
//                     ),],),

//                     Row(
//                       children: [
//    IconButton(
//   icon: Icon(Icons.call, color: Colors.red, size: 35),
//   onPressed: () async {
//     const phoneNumber = 'tel:+9779865248671'; // Example Nepali number
//     try {
//       if (await canLaunch(phoneNumber)) {
//         print('Launching: $phoneNumber');
//         await launch(phoneNumber);
//       } else {
//         print('Could not launch $phoneNumber');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }

// // makePhoneCall('+9779865248671');

// // _makePhoneCall(context);
//          // child: Text('Call $phoneNumber'),

// //          final Uri webUri = Uri.parse('https://www.google.com');
// // if (await canLaunchUrl(webUri)) {
// //   await launchUrl(webUri);
// // } else {
// //   print('Could not launch web page');
// // }

//   },
// ),

//                         SizedBox(width: 8,),
//         IconButton(
//   icon: Icon(
//     Icons.mail,
//     color: Colors.red,
//     size: 35,
//   ),
//   onPressed: () async {
//     // The phone number to send the message to (Nepal country code +977)
//     String phoneNumber = '+9779865248671';  // Replace with the actual number, including the country code

//     // The message you want to send
//     String message = '';

//     // Construct the SMS URL with the Nepal country code
//     String url = 'sms:$phoneNumber?body=$message';

//     // Check if the URL can be launched
//     if (await canLaunch(url)) {
//       // Launch the SMS app with the pre-filled message
//       await launch(url);
//     } else {
//       // If the URL can't be launched, show an error
//       print('Could not launch the message app');
//     }
//   },
// )
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),

//       SizedBox(height: 10),
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0), //20.0
//         child: Column(
//           children: [
//             Text(
//               "Medicine",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "    5",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         //fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     SizedBox(height: .4),
//                     Text(
//                       "      Nov 2024",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.6),
//                     Text(
//                       "      1 Kg",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Text(
//                       "      Rs 250",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // VerticalDivider(
//                 //   color: Colors.grey,
//                 //   thickness: 1,
//                 //   indent: 8,//8
//                 //   endIndent: 8,//8
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Ravi Giri",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Detail"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 0.0001),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Comment"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 10),
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0), //20.0
//         child: Column(
//           children: [
//             Text(
//               "Medicine",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "    5",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         //fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     SizedBox(height: .4),
//                     Text(
//                       "      Nov 2024",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.6),
//                     Text(
//                       "      1 Kg",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Text(
//                       "      Rs 250",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // VerticalDivider(
//                 //   color: Colors.grey,
//                 //   thickness: 1,
//                 //   indent: 8,//8
//                 //   endIndent: 8,//8
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Ravi Giri",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Detail"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 0.0001),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Comment"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 10),
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0), //20.0
//         child: Column(
//           children: [
//             Text(
//               "Medicine",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "    5",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         //fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     SizedBox(height: .4),
//                     Text(
//                       "      Nov 2024",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.6),
//                     Text(
//                       "      1 Kg",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Text(
//                       "      Rs 250",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // VerticalDivider(
//                 //   color: Colors.grey,
//                 //   thickness: 1,
//                 //   indent: 8,//8
//                 //   endIndent: 8,//8
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Ravi Giri",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Detail"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 0.0001),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Comment"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 10),
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0), //20.0
//         child: Column(
//           children: [
//             Text(
//               "Medicine",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "    5",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         //fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     SizedBox(height: .4),
//                     Text(
//                       "      Nov 2024",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.6),
//                     Text(
//                       "      1 Kg",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Text(
//                       "      Rs 250",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // VerticalDivider(
//                 //   color: Colors.grey,
//                 //   thickness: 1,
//                 //   indent: 8,//8
//                 //   endIndent: 8,//8
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Ravi Giri",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Detail"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 0.0001),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Comment"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 10),
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0), //20.0
//         child: Column(
//           children: [
//             Text(
//               "Medicine",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "    5",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         //fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     SizedBox(height: .4),
//                     Text(
//                       "      Nov 2024",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.6),
//                     Text(
//                       "      1 Kg",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Text(
//                       "      Rs 250",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // VerticalDivider(
//                 //   color: Colors.grey,
//                 //   thickness: 1,
//                 //   indent: 8,//8
//                 //   endIndent: 8,//8
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Ravi Giri",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Detail"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 0.0001),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Comment"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 10),
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0), //20.0
//         child: Column(
//           children: [
//             Text(
//               "Medicine",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "    5",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         //fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     SizedBox(height: .4),
//                     Text(
//                       "      Nov 2024",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.6),
//                     Text(
//                       "      1 Kg",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Text(
//                       "      Rs 250",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // VerticalDivider(
//                 //   color: Colors.grey,
//                 //   thickness: 1,
//                 //   indent: 8,//8
//                 //   endIndent: 8,//8
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Ravi Giri",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Detail"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 0.0001),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Comment"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 10),
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0), //20.0
//         child: Column(
//           children: [
//             Text(
//               "Medicine",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "    5",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         //fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     SizedBox(height: .4),
//                     Text(
//                       "      Nov 2024",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.6),
//                     Text(
//                       "      1 Kg",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Text(
//                       "      Rs 250",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // VerticalDivider(
//                 //   color: Colors.grey,
//                 //   thickness: 1,
//                 //   indent: 8,//8
//                 //   endIndent: 8,//8
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Ravi Giri",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Detail"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 0.0001),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Comment"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(100, 38),
//                         primary: Colors.red,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 10),
//     ];
//     List<Widget> listFun() {
//       if (widgetList.isNotEmpty) return widgetList;
//       if (widgetList.isEmpty) return textList;
//     }

//     // You can adjust this count dynamically
//     int itemCount = 10; // Number of items in the list

//     return SingleChildScrollView(
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, children: listFun()));
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/newChange/commentList.dart';
// import 'package:logistics/packagedetailpage/package_detail_screen.dart';
// import 'package:logistics/response/PackageDetailM.dart';
// import 'package:logistics/scan.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';

// class DynamicListScreen extends StatelessWidget {

// PackageDetailM detail;

//  final Dio dio = Dio();
//   final String apiUrl = 'https://dashlogistics.dev/api/v1/employee/statusData';

//   // Function to fetch data using Dio
//   Future<List<dynamic>> fetchData() async {
//     try {
//       final response = await dio.get(apiUrl);
//       print("$response  is lextent response***********************************");
//       if (response.statusCode == 200) {
//         print("$response 2nd  is lextent response***********************************");
//         return response.data['data']; // Return the 'data' array

//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   // final String phoneNumber = "+9779865248671";

//   // Future<void> _makePhoneCall(BuildContext context) async {
//   //   // Check and request CALL_PHONE permission
//   //   if (await Permission.phone.request().isGranted) {
//   //     final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

//   //     if (await canLaunchUrl(phoneUri)) {
//   //       await launchUrl(phoneUri);
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Unable to launch dialer')),
//   //       );
//   //     }
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Permission denied. Cannot make a call.')),
//   //     );
//   //   }
//   // }

// final String phoneNumber = "+9779865248671";

//   Future<void> _makePhoneCall(BuildContext context) async {
//     final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

//     if (await canLaunchUrl(phoneUri)) {
//       await launchUrl(phoneUri);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Dialer app not available on this device')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> textList = [
//       Container(
//         padding: EdgeInsets.all(16.0), // Add padding around the text
//         margin: EdgeInsets.all(10.0), // Add margin around the container
//         decoration: BoxDecoration(
//           color: Colors.blue[100], // Background color for the container
//           borderRadius: BorderRadius.circular(10), // Rounded corners
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3), // Shadow position
//             ),
//           ],
//         ),
//         child: Text(
//           "Empty, Please Refresh",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue[800],
//           ),
//           textAlign: TextAlign.center,
//         ),
//       )
//     ];

//     List<Widget> listFun() {
//      return  FutureBuilder<List<dynamic>>(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             print("3rd  is lextent response***********************************");
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data.isEmpty) {
//             return Center(child: Text('No data available'));
//           } else {
//             final deliveryList = snapshot.data;
//             return ListView.builder(
//               itemCount: deliveryList.length,
//               itemBuilder: (context, index) {
//                 final item = deliveryList[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: buildDeliveryContainer(item, context),
//                 );
//               },
//             );
//           }
//         },
//       );
//     }

//     // You can adjust this count dynamically
//     int itemCount = 10; // Number of items in the list

//     return SingleChildScrollView(
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, children: listFun()));
//   }
// }

//   Widget buildDeliveryContainer(Map<String, dynamic> detail, BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             detail['product_name'] ?? 'Unknown Product',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 6),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "    ${detail['quantity'] ?? 0}",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "      ${detail['delivery_date'] ?? 'N/A'}",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     "      ${detail['weight'] ?? '0 Kg'}",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     "      Rs ${detail['price'] ?? '0'}",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Receiver",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.blueGrey,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     detail['receiver_name'] ?? 'Unknown',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     detail['receiver_contact'] ?? 'Unknown Contact',
//                     style: TextStyle(
//                       color: Colors.blueGrey,
//                       fontSize: 14,
//                     ),
//                   ),
//                   Text(
//                     detail['receiver_address'] ?? 'Unknown Address',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.remove_red_eye, color: Colors.red, size: 35),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PackageDetailScreen(code: detail['code']),
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(width: 8),
//                       IconButton(
//                         icon: Icon(Icons.comment, color: Colors.red, size: 35),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => CommentList()),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.call, color: Colors.red, size: 35),
//                         onPressed: () async {
//                           final phoneNumber = 'tel:${detail['receiver_contact']}';
//                           if (await canLaunch(phoneNumber)) {
//                             await launch(phoneNumber);
//                           }
//                         },
//                       ),
//                       SizedBox(width: 8),
//                       IconButton(
//                         icon: Icon(Icons.mail, color: Colors.red, size: 35),
//                         onPressed: () async {
//                           final smsUri = 'sms:${detail['receiver_contact']}?body=Hello!';
//                           if (await canLaunch(smsUri)) {
//                             await launch(smsUri);
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/newChange/commentList.dart';
// import 'package:logistics/packagedetailpage/package_detail_screen.dart';
// import 'package:logistics/response/PackageDetailM.dart';
// import 'package:logistics/reusable/URLS.dart';
// import 'package:logistics/scan.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:intl/intl.dart';

// String formatDate(String dateString) {
//   // Parse the date string into a DateTime object
//   DateTime parsedDate = DateTime.parse(dateString);

//   // Get the day, month, and year separately
//   String day = DateFormat('d').format(parsedDate); // Day without leading zeros
//   String monthYear = DateFormat('MMMM yyyy').format(parsedDate); // Month and year

//   // Return the formatted result with line breaks
//   return '$day\n$monthYear'; // Day on top, Month and Year on the next line
// }

// class DynamicListScreen extends StatelessWidget {
//   final Dio dio = Dio();
//   final String apiUrl = 'https://dashlogistics.dev/api/v1/employee/statusData';

// Future<List<dynamic>> fetchData() async {
//   BaseOptions options = new BaseOptions(
//         baseUrl: '${URLS.BASE_URL}',
//         //connectTimeout: 30000,
//         connectTimeout:( Duration(milliseconds:30000)),
//         receiveTimeout: ( Duration(milliseconds:30000)),
//         validateStatus: (status) {
//           return status < 500;
//         }
//     );

//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String token = prefs.getString('token');
//     // print("token");

//     Dio dio = new Dio(options);
//     dio.options.headers["Authorization"] = "Bearer $token";

//   const apiUrl = 'https://dashlogistics.dev/api/v1/employee/statusData';
//   //const token = 'your_api_token_here'; // Replace with your actual token

//   try {
//     final response = await dio.get(
//       apiUrl,
//       options: Options(
//         headers: {'Authorization': 'Bearer $token'},
//       ),
//     );

//     if (response.statusCode == 200) {
//       return response.data['data']; // Return the 'data' array
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     throw Exception('Error: $e');
//   }
// }

// String formatDate(String dateString) {
//   // Parse the date string into a DateTime object
//   DateTime parsedDate = DateTime.parse(dateString);

//   // Get the day, month, and year separately
//   String day = DateFormat('d').format(parsedDate); // Day without leading zeros
//   String monthYear = DateFormat('MMMM yyyy').format(parsedDate); // Month and year

//   // Return the formatted result with line breaks
//   return '$day\n$monthYear'; // Day on top, Month and Year on the next line
// }

// @override
// Widget build(BuildContext context) {
//   return  FutureBuilder<List<dynamic>>(
//       future: fetchData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data.isEmpty) {
//           return Center(child: Text('No data available'));
//         } else {
//           final deliveryList = snapshot.data;
//           return SingleChildScrollView(  // Wrap entire content in SingleChildScrollView
//             child: Column(
//               children: [
//                 ListView.builder(
//                   shrinkWrap: true,  // Ensures the ListView fits inside the parent widget
//                   physics: NeverScrollableScrollPhysics(),  // Disable ListView's own scroll
//                   itemCount: deliveryList.length,
//                   itemBuilder: (context, index) {
//                     final item = deliveryList[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: buildDeliveryContainer(item, context),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//   );
// }

//   Widget buildDeliveryContainer(Map<String, dynamic> detail, BuildContext context) {

//      String createdAt =  detail["created_at"];
// String formattedDate = formatDate(createdAt);

//  //detail['product_name'] ?? 'Unknown Product',
//     return    Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//           children: [
//             Text(
//              // "Medicine",   detail['product_name'] ?? 'Unknown Product',
//              //detail.productName,
//               detail['product_name'] ?? 'Unknown Product',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     // Text(
//                     //   "    5",
//                     //   style: TextStyle(
//                     //     color: Colors.red,
//                     //     fontSize: 30,
//                     //     fontWeight: FontWeight.bold,
//                     //   ),
//                     // ),
//                     DateDisplay(createdAt: detail["created_at"]),
//                     // SizedBox(height: .4),
//                     // Text(
//                     //   "      Nov 2024",
//                     //   style: TextStyle(
//                     //     color: Colors.red,
//                     //     fontSize: 13,
//                     //     fontWeight: FontWeight.w500,
//                     //   ),
//                     // ),
//                     SizedBox(height: 1.6),
//                     Row(
//                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                            Text(
//                    //   "      1 Kg",
//                   "Weight",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(width: 6,),
//                         Text(
//                    //   "      1 Kg",
//                    detail['initial_package_weight']?.toString() ?? 'Unknown Product',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 1.6,
//                     ),
//                     Row(
//                     //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                          if( detail["payment_type"]=="pre-paid")
//                           Text(//  "product_price"
//                         // detail["product_price"].toString() ?? 'Unknown Product',

//                           "Pre - Rs 0",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                          else
//                         Row(children: [   Text("COD - Rs " ,
//                            // "      Rs 250",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 7,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text("${ detail["product_price"].toString()} " ,
//                            // "      Rs 250",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],

//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Receiver",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                  //     "Ravi Giri",
//                   detail['receiver_name'] ?? 'Unknown Product',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "9865248671",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "Chysal,Lalitpur",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 8,
//                   endIndent: 8,
//                 ),
//                 Column(
//                   children: [
//                   Row(children: [  IconButton(
//                       icon: Icon(Icons.remove_red_eye, color: Colors.red,size: 35,),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   PackageDetailScreen(code: detail[ "DKJ2303KTM9RXI"])),
//                         );
//                       },
//                     ),
//                     SizedBox(width: 8,),
//                     IconButton(
//                       icon: Icon(Icons.comment, color: Colors.red,size: 35,),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CommentList()),
//                         );
//                       },
//                     ),],),

//                     Row(
//                       children: [
//    IconButton(
//   icon: Icon(Icons.call, color: Colors.red, size: 35),
//   onPressed: () async {  //"receiver_contact"
//     String phoneNumber = detail["receiver_contact"]; // Example Nepali number
//     try {
//       if (await canLaunch(phoneNumber)) {
//         print('Launching: $phoneNumber');
//         await launch(phoneNumber);
//       } else {
//         print('Could not launch $phoneNumber');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }

//   },
// ),

//                         SizedBox(width: 8,),
//         IconButton(
//   icon: Icon(
//     Icons.mail,
//     color: Colors.red,
//     size: 35,
//   ),
//   onPressed: () async {
//     // The phone number to send the message to (Nepal country code +977)
//    String phoneNumber = detail["receiver_contact"];  // Replace with the actual number, including the country code

//     // The message you want to send
//     String message = '';

//     // Construct the SMS URL with the Nepal country code
//     String url = 'sms:$phoneNumber?body=$message';

//     // Check if the URL can be launched
//     if (await canLaunch(url)) {
//       // Launch the SMS app with the pre-filled message
//       await launch(url);
//     } else {
//       // If the URL can't be launched, show an error
//       print('Could not launch the message app');
//     }
//   },
// )
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//   }
// }

// class DateDisplay extends StatelessWidget {
//   final String createdAt;

//   DateDisplay({ this.createdAt});

//   String formatDate(String dateString) {
//     // Parse the date string into a DateTime object
//     DateTime parsedDate = DateTime.parse(dateString);

//     // Get the day, month, and year separately
//     String day = DateFormat('d').format(parsedDate); // Day without leading zeros
//     String monthYear = DateFormat('MMMM yyyy').format(parsedDate); // Month and year

//     return '$day\n$monthYear'; // Day on top, Month and Year on the next line
//   }

//   @override
//   Widget build(BuildContext context) {
//     String formattedDate = formatDate(createdAt);
//     List<String> dateParts = formattedDate.split("\n"); // Split into day and month/year

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Day in the center with a larger font size
//         Text(
//           dateParts[0],
//              style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//         ),
//         // Month and Year below the day with a smaller font size
//         Text(
//           dateParts[1],
//              style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/newChange/commentList.dart';
// import 'package:logistics/packagedetailpage/package_detail_screen.dart';
// import 'package:logistics/response/PackageDetailM.dart';
// import 'package:logistics/scan.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:intl/intl.dart';

// String formatDate(String dateString) {
//   DateTime parsedDate = DateTime.parse(dateString);
//   String day = DateFormat('d').format(parsedDate);
//   String monthYear = DateFormat('MMMM yyyy').format(parsedDate);
//   return '$day\n$monthYear';
// }

// class DynamicListScreen extends StatefulWidget {
//   @override
//   _DynamicListScreenState createState() => _DynamicListScreenState();
// }

// class _DynamicListScreenState extends State<DynamicListScreen> {
//   final Dio dio = Dio();
//   final ScrollController _scrollController = ScrollController();
//   List<dynamic> _deliveryList = [];
//   bool _isLoading = false;
//   int _page = 1; // Start with page 1

//   Future<List<dynamic>> fetchData(int page) async {
//     BaseOptions options = BaseOptions(
//       baseUrl: 'https://dashlogistics.dev/api/v1/employee/statusData',
//       connectTimeout: Duration(milliseconds: 30000),
//       receiveTimeout: Duration(milliseconds: 30000),
//       validateStatus: (status) => status < 500,
//     );

//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String token = prefs.getString('token') ?? '';

//     dio.options.headers["Authorization"] = "Bearer $token";

//     try {
//       final response = await dio.get(
//         'https://dashlogistics.dev/api/v1/employee/statusData',
//         queryParameters: {'page': page}, // Pass the page number
//       );

//       if (response.statusCode == 200) {
//         return response.data['data']; // Return the 'data' array
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadMoreData();

//     // Listen for scroll changes
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//         _loadMoreData();
//       }
//     });
//   }

//   Future<void> _loadMoreData() async {
//     if (_isLoading) return; // Avoid multiple requests at the same time
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       List<dynamic> newData = await fetchData(_page);
//       setState(() {
//         _deliveryList.addAll(newData);
//         _page++;
//       });
//     } catch (e) {
//       // Handle error if needed
//       print("Error loading more data: $e");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       controller: _scrollController,
//       child: Column(
//         children: [
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _deliveryList.length + (_isLoading ? 1 : 0), // Show loading indicator at the end
//             itemBuilder: (context, index) {
//               if (index == _deliveryList.length) {
//                 return Center(child: CircularProgressIndicator());
//               }

//               final item = _deliveryList[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: buildDeliveryContainer(item, context),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDeliveryContainer(Map<String, dynamic> detail, BuildContext context) {
//     String createdAt = detail["created_at"];
//     String formattedDate = formatDate(createdAt);

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(2.0),
//       child: Column(
//         children: [
//           Text(
//             detail['product_name'] ?? 'Unknown Product',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 6),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DateDisplay(createdAt: detail["created_at"]),
//                   SizedBox(height: 1.6),
//                   Row(
//                     children: [
//                       Text(
//                         "Weight",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Text(
//                         detail['initial_package_weight']?.toString() ?? 'Unknown Product',
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 1.6),
//                   Row(
//                     children: [
//                       if (detail["payment_type"] == "pre-paid")
//                         Text(
//                           "Pre - Rs 0",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                       else
//                         Row(
//                           children: [
//                             Text(
//                               "COD - Rs ",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 7,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Text(
//                               "${detail["product_price"].toString()} ",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Receiver",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.blueGrey,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   Text(
//                     detail['receiver_name'] ?? 'Unknown Product',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   Text(
//                     "9865248671",
//                     style: TextStyle(
//                       color: Colors.blueGrey,
//                       fontSize: 14,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   Text(
//                     "Chysal, Lalitpur",
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               VerticalDivider(
//                 color: Colors.grey,
//                 thickness: 1,
//                 indent: 8,
//                 endIndent: 8,
//               ),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           Icons.remove_red_eye,
//                           color: Colors.red,
//                           size: 35,
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PackageDetailScreen(
//                                   code: detail["DKJ2303KTM9RXI"]),
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(width: 8),
//                       IconButton(
//                         icon: Icon(
//                           Icons.comment,
//                           color: Colors.red,
//                           size: 35,
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => CommentList()),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           Icons.call,
//                           color: Colors.red,
//                           size: 35,
//                         ),
//                         onPressed: () async {
//                           String phoneNumber = detail["receiver_contact"];
//                           try {
//                             if (await canLaunch(phoneNumber)) {
//                               await launch(phoneNumber);
//                             } else {
//                               print('Could not launch $phoneNumber');
//                             }
//                           } catch (e) {
//                             print('Error: $e');
//                           }
//                         },
//                       ),
//                       SizedBox(width: 8),
//                       IconButton(
//                         icon: Icon(
//                           Icons.mail,
//                           color: Colors.red,
//                           size: 35,
//                         ),
//                         onPressed: () async {
//                           String phoneNumber = detail["receiver_contact"];
//                           String message = '';
//                           String url = 'sms:$phoneNumber?body=$message';
//                           if (await canLaunch(url)) {
//                             await launch(url);
//                           } else {
//                             print('Could not launch the message app');
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DateDisplay extends StatelessWidget {
//   final String createdAt;

//   DateDisplay({this.createdAt});

//   String formatDate(String dateString) {
//     DateTime parsedDate = DateTime.parse(dateString);
//     String day = DateFormat('d').format(parsedDate);
//     String monthYear = DateFormat('MMMM yyyy').format(parsedDate);
//     return '$day\n$monthYear';
//   }

//   @override
//   Widget build(BuildContext context) {
//     String formattedDate = formatDate(createdAt);
//     List<String> dateParts = formattedDate.split("\n");

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           dateParts[0],
//           style: TextStyle(
//             color: Colors.red,
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           dateParts[1],
//           style: TextStyle(
//             color: Colors.red,
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/Drawer/drawer.dart';
import 'package:logistics/Drawer/privacyPolicy.dart';
import 'package:logistics/edit/packageedit/package_edit_presenter.dart';
import 'package:logistics/newChange/commentList.dart';
import 'package:logistics/newChange/scrollabletest.dart';

import 'package:logistics/packagedetailpage/package_detail_screen.dart';
import 'package:logistics/response/PackageDetailM.dart';
import 'package:logistics/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

import '../login/login_screen.dart';
import '../newChange/aboutUs.dart';
import '../newChange/rateApp.dart';
import '../newChange/riderDetailsScreen.dart';
import '../newChange/sidebarNotification.dart';
import '../utils/color.dart';

String formatDate(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);
  String day = DateFormat('d').format(parsedDate);
  String monthYear = DateFormat('MMMM yyyy').format(parsedDate);
  return '$day\n$monthYear';
}

class DynamicListScreen extends StatefulWidget {
  @override
  _DynamicListScreenState createState() => _DynamicListScreenState();
}

class _DynamicListScreenState extends State<DynamicListScreen> {
  EditPackageScreenContract _view;
  final Dio dio = Dio();
  ScrollController _scrollController = ScrollController();
  List<dynamic> _deliveryList = [];
  bool _isLoading = false;
  int _page = 1; // Start with page 1
  bool isLoggingOut = false;

  Future<List<dynamic>> fetchData(int page) async {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://dashlogistics.dev/api/v1/employee/statusData',
      connectTimeout: Duration(milliseconds: 30000),
      receiveTimeout: Duration(milliseconds: 30000),
      validateStatus: (status) => status < 500,
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';

    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      final response = await dio.get(
        'https://dashlogistics.dev/api/v1/employee/statusData',
       // queryParameters: {'page': page}, // Pass the page number
           queryParameters: {'status': 'outForDelivery', 'page': page}
      );

      if (response.statusCode == 200) {
        return response.data['data']; // Return the 'data' array
      }
      //    else {
      //     throw Exception('Failed to load data');
      //   }
      // } catch (e) {
      //   throw Exception('Error: $e');
      // }
      else {
        _view.onError("Something Went Wrong");
      }
    } catch (e) {
      _view.onError("Something Went Wrong");
    }
  }
  
   Future<void> _clearCache() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('cachedOutFordelivery'); // Clear cache
  print("Cache cleared for testing.");
}
  @override
  void initState() {
    super.initState();
   // _clearCache();
     _loadInitialData();
    _scrollController = ScrollController();


    _scrollController.addListener(() {
      print("5st***************");

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 50 &&
          !_isLoading) {
        print("1st***************");
         _loadMoreData();
      }
    });
  }


  

Future<void> _loadInitialData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String cachedData = prefs.getString('cachedOutFordelivery');
  
  if (cachedData != null && cachedData.isNotEmpty) {
    // await _loadMoreData();
    print("Cache data is present *************");
    setState(() {
      _deliveryList = List<dynamic>.from(json.decode(cachedData));
    });
  } else {
    print("No cache data is present *************");
    await _loadMoreData(); // Load from server if no cached data
  }
}



  Future<Map<String, dynamic>> fetchRiderDetails() async {
    final Dio dio = Dio();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token') ?? '';

      dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      // Make GET request with Bearer Token
      final response = await dio.get(
        'https://dashlogistics.dev/api/v1/employee',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch rider details!');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }



Future<void> _cacheData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.setString('cachedDeliveryList', json.encode(_deliveryList));
  await prefs.setString('cachedOutFordelivery', json.encode(_deliveryList));
  print("Data cached successfully.");
}

Future<void> _loadMoreData() async {
  if (_isLoading) return; // Prevent multiple calls

  setState(() => _isLoading = true);

  try {
    List<dynamic> newData = await fetchData(_page);

    if (newData.isNotEmpty) {
      setState(() {
        _deliveryList.addAll(newData);
        _page++;
      });

      // Cache the updated data
      await _cacheData();
    } else {
      print("No more data available."); // No further API calls
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
    //  SnackBar(content: Text("Error loading data: $e")),
          SnackBar(
  content: Text("Session Expired. Please log in again"),
)
    );
    print("Error loading data: $e");
  } finally {
    setState(() => _isLoading = false);
  }
}


      void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");

   
  await prefs.remove('cachedOutFordelivery'); // Clear delivery cache
  print("User logged out. Cache cleared.");
  // Navigate to login screen
    
  }

  @override
Widget build(BuildContext context) {
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
          onTap: () async {
            setState(() {
              isLoggingOut = true; // Show loading indicator.
            });
            await _logout(); // Perform logout logic.
            setState(() {
              isLoggingOut = false; // Hide loading indicator.
            });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
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
            ));
      },
    );
  }
  
  return Scaffold(
    drawer: MyDrawer(),
   
         appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
    body: RefreshIndicator(
      onRefresh: () async {
        // Fetch new data when user pulls down to refresh
        await _loadNewData();
      },
      child: Scaffold(
        floatingActionButton:     FloatingActionButton(
          onPressed: () {
        
          // Scroll to top with an animation
                      _scrollController.animateTo(
                        0.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
          },
          child: Icon(Icons.arrow_upward),
        ),
        body: SingleChildScrollView(
          controller: _scrollController, // Attach the scroll controller
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
                itemCount: _deliveryList.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _deliveryList.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final item = _deliveryList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildDeliveryContainer(item, context),
                  );
                },
              ),               
            ],
          ),
        ),
      ),
    ),
  );
}

// Function to fetch new data
Future<void> _loadNewData() async {
  setState(() => _isLoading = true); // Show loading indicator
  try {
    _page = 1; // Reset to first page
    List<dynamic> newData = await fetchData(_page);
    setState(() {
      _deliveryList = newData; // Replace current data with new data
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error refreshing data: $e")),
    );
  } finally {
    setState(() => _isLoading = false); // Hide loading indicator
  }
}


  Widget buildDeliveryContainer(
      Map<String, dynamic> detail, BuildContext context) {
    String createdAt = detail["created_at"];
    String formattedDate = formatDate(createdAt);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Text(
            detail['product_name'] ?? 'Unknown Product',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateDisplay(createdAt: detail["created_at"]),
                  SizedBox(height: 1.6),
                  Row(
                    children: [
                      Text(
                        "Weight",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        detail['initial_package_weight']?.toString() ??
                            'Unknown Product',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.6),
                  Row(
                    children: [
                      if (detail["payment_type"] == "pre-paid")
                        Text(
                          "Pre - Rs 0",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      else
                        Row(
                          children: [
                            Text(
                              "COD - Rs ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${detail["product_price"].toString()} ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 9,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2),
                  Container(
                    width: 125,
                    child: Text(
                      detail['receiver_name'] ?? 'Unknown Receiver',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                      softWrap: true, // Enable soft wrapping
                      maxLines: 2, // Allow up to 2 lines
                      overflow: TextOverflow
                          .ellipsis, // Add ellipsis (...) if text overflows
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    detail["receiver_contact"] ?? 'Unknown Receiver',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    width: 125,
                    child: Text(
                      detail["receiver_address"] ?? 'Unknown Receiver',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                      softWrap: true, // Enable soft wrapping
                      maxLines: 2, // Allow up to 2 lines
                      overflow: TextOverflow
                          .ellipsis, // Add ellipsis (...) if text overflows
                    ),
                  ),
                ],
              ),
              VerticalDivider(
                color: Colors.grey,
                thickness: 1,
                indent: 8,
                endIndent: 8,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PackageDetailScreen(
                                  code: detail["tracking_code"]),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () async {
  // Show a loading dialog
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
    // Simulate data loading or perform an async operation
    await Future.delayed(Duration(seconds: 2)); // Replace with actual async data fetch if needed

    // Close the loader dialog
    Navigator.of(context).pop();

    // Navigate to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentList(trackingCode: detail["tracking_code"]),
      ),
    );
  } catch (e) {
    // Close the loader in case of an error
    Navigator.of(context).pop();

    // Optionally show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
},

                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.call,
                          color: Colors.red,
                          size: 35,
                        ),
                     
                        onPressed: () async {
                          String phoneNumber = detail["receiver_contact"];
                          try {
                            // Format the phone number with the 'tel:' scheme
                            String phoneUrl = 'tel:$phoneNumber';

                            if (await canLaunch(phoneUrl)) {
                              await launch(phoneUrl);
                            } else {
                              print('Could not launch $phoneUrl');
                            }
                          } catch (e) {
                            print('Error: $e');
                          }
                        },
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          Icons.mail,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () async {
                          String phoneNumber = detail["receiver_contact"];
                          String message = '';
                          String url = 'sms:$phoneNumber?body=$message';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            print('Could not launch the message app');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DateDisplay extends StatelessWidget {
  final String createdAt;

  DateDisplay({this.createdAt});

  String formatDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    String day = DateFormat('d').format(parsedDate);
    String monthYear = DateFormat('MMM yyyy')
        .format(parsedDate); // Use 'MMM' for abbreviated month
    return '$day\n$monthYear';
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = formatDate(createdAt);
    List<String> dateParts = formattedDate.split("\n");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dateParts[0],
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          dateParts[1],
          style: TextStyle(
            color: Colors.red,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
