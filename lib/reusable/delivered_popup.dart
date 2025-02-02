// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logistics/galliMap/signatureMap.dart';
// import 'package:logistics/reusable/staticorangetextmeduim.dart';
// import 'package:logistics/reusable/textregularsecondary.dart';
// import 'package:logistics/utils/color.dart';

// class StatusDeliveredChangePopUp extends StatelessWidget {
//   final VoidCallback onNextTap;
//   final String currentStatus;
//   final String newStatus;
//   final String productname;
//   final String price;
//   final TextEditingController collectedController;
//   final TextEditingController weightController;

//   const StatusDeliveredChangePopUp(
//       {Key key,
//       this.currentStatus,
//       this.newStatus,
//       this.productname,
//       this.price,
//       @required this.collectedController,
//       @required this.weightController,
//       @required this.onNextTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var showError = false;
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return new AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(14.0))),
//           insetPadding: EdgeInsets.all(16),
//           contentPadding: EdgeInsets.fromLTRB(25, 24, 25, 38),
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           content: SingleChildScrollView(
//             child: Container(
//               child: new Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                       height: 15,
//                       width: MediaQuery.of(context).size.width,
//                       child: Align(
//                         alignment: Alignment.topRight,
//                         child: Image.asset("assets/images/cancel.png"),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
//                     child: Text(
//                       "Do you want to change the status from",
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w700,
//                           color: MyColors.ligtBlack,
//                           fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         height: 65,
//                         width: 72,
//                         margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                         padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                         child: Center(
//                             child: Text(
//                           currentStatus,
//                           style: TextStyle(
//                               fontFamily: "Roboto",
//                               fontWeight: FontWeight.w500,
//                               color: MyColors.ligtBlack,
//                               fontSize: 12),
//                           textAlign: TextAlign.center,
//                         )),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: MyColors.lightGrey,
//                         ),
//                       ),
//                       Center(
//                         child: Container(
//                           margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                           height: 65,
//                           width: 72,
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Image.asset("assets/images/middivider.png"),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 65,
//                         width: 72,
//                         margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                         padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                         child: Center(
//                             child: Text(
//                           newStatus,
//                           style: TextStyle(
//                               fontFamily: "Roboto",
//                               fontWeight: FontWeight.w500,
//                               color: MyColors.white,
//                               fontSize: 12),
//                           textAlign: TextAlign.center,
//                         )),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: MyColors.green,
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(22, 32, 0, 20),
//                         child: Text(
//                           "Product Name :",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.darkGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(16, 32, 32, 20),
//                         child: Text(
//                           " $productname",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.darkGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(22, 0, 45, 0),
//                         child: Text(
//                           "Product Price :",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.ligtGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(24, 0, 32, 0),
//                         child: Text(
//                           "Rs $price",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.ligtGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(22, 32, 32, 20),
//                         child: Text(
//                           "Collected Amount :",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.darkGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Container(
//                           width: 150,
//                           margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                           child: Column(
//                             children: <Widget>[
//                               TextField(
//                                 inputFormatters: <TextInputFormatter>[
//                                   FilteringTextInputFormatter.digitsOnly,
//                                 ],
//                                 keyboardType: TextInputType.number,
//                                 controller: collectedController,
//                                 obscureText: false,
//                                 style: TextStyle(color: MyColors.primaryColor),
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.fromLTRB(
//                                       20.0, 15.0, 20.0, 15.0),
//                                   hintStyle:
//                                       TextStyle(color: MyColors.darkGreyText),
//                                   hintText: "Rs",
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(
//                                         width: 0, style: BorderStyle.none),
//                                   ),
//                                   filled: true,
//                                   fillColor: MyColors.lightGrey,
//                                 ),
//                               ),
//                               showError
//                                   ? TextRegularSecondary(
//                                       text: "Enter collected amount",
//                                     )
//                                   : Container()
//                             ],
//                           ))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: <Widget>[
//             Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.fromLTRB(18, 0, 25, 38),
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   backgroundColor: MyColors.primaryColor,
//                 ),
//                 onPressed: () {
//                   if (collectedController.text.isNotEmpty) {
//                     Navigator.of(context).pop();
//                     onNextTap();
//                   } else {
//                     setState(() {
//                       showError = true;
//                     });
//                   }
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(45, 15, 45, 15),
//                   child: Text(
//                     "Next",
//                     style: TextStyle(
//                       color: MyColors.white,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//  }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logistics/galliMap/signatureMap.dart';
// import 'package:logistics/reusable/staticorangetextmeduim.dart';
// import 'package:logistics/reusable/textregularsecondary.dart';
// import 'package:logistics/utils/color.dart';

// class StatusDeliveredChangePopUp extends StatelessWidget {
//   final VoidCallback onNextTap;
//   final String currentStatus;
//   final String newStatus;
//   final String productname;
//   final String price;
//   final TextEditingController collectedController;
//   final TextEditingController weightController;

//   const StatusDeliveredChangePopUp({
//     Key key,
//     this.currentStatus,
//     this.newStatus,
//     this.productname,
//     this.price,
//     @required this.collectedController,
//     @required this.weightController,
//     @required this.onNextTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//      TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var showError = false;
//     List<Map<String, dynamic>> paymentMethods = [];

//     return StatefulBuilder(
//       builder: (context, setState) {
//         // Function to add new payment method entry
//         void addPaymentMethod() {
//           setState(() {
//             paymentMethods.add({'method': 'Select Method', 'amount': 0});
//           });
//         }

//         // Function to calculate total collected amount
//         int calculateTotalAmount() {
//           return paymentMethods.fold<int>(
//             0,
//             (sum, item) => sum + (item['amount'] ?? 0),
//           );
//         }

//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(14.0)),
//           ),
//           insetPadding: EdgeInsets.all(16),
//           contentPadding: EdgeInsets.fromLTRB(25, 24, 25, 38),
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // Close Button
//                  GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                       height: 15,
//                       width: MediaQuery.of(context).size.width,
//                       child: Align(
//                         alignment: Alignment.topRight,
//                         child: Image.asset("assets/images/cancel.png"),
//                       ),
//                     ),
//                   ),
//                 // Current Status
//               Padding(
//                     padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
//                     child: Text(
//                       "Do you want to change the status from",
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w700,
//                           color: MyColors.ligtBlack,
//                           fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         height: 65,
//                         width: 72,
//                         margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                         padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                         child: Center(
//                             child: Text(
//                           currentStatus,
//                           style: TextStyle(
//                               fontFamily: "Roboto",
//                               fontWeight: FontWeight.w500,
//                               color: MyColors.ligtBlack,
//                               fontSize: 12),
//                           textAlign: TextAlign.center,
//                         )),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: MyColors.lightGrey,
//                         ),
//                       ),
//                       Center(
//                         child: Container(
//                           margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                           height: 65,
//                           width: 72,
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Image.asset("assets/images/middivider.png"),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 65,
//                         width: 72,
//                         margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                         padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                         child: Center(
//                             child: Text(
//                           newStatus,
//                           style: TextStyle(
//                               fontFamily: "Roboto",
//                               fontWeight: FontWeight.w500,
//                               color: MyColors.white,
//                               fontSize: 12),
//                           textAlign: TextAlign.center,
//                         )),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: MyColors.green,
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(22, 32, 0, 20),
//                         child: Text(
//                           "Product Name :",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.darkGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(16, 32, 32, 20),
//                         child: Text(
//                           " $productname",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.darkGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(22, 0, 45, 0),
//                         child: Text(
//                           "Product Price :",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.ligtGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(24, 0, 32, 0),
//                         child: Text(
//                           "Rs $price",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.ligtGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(22, 32, 32, 20),
//                         child: Text(
//                           "Collected Amount :",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: MyColors.darkGreyText,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Container(
//                           width: 150,
//                           margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                           child: Column(
//                             children: <Widget>[
//                               TextField(
//                                 inputFormatters: <TextInputFormatter>[
//                                   FilteringTextInputFormatter.digitsOnly,
//                                 ],
//                                 keyboardType: TextInputType.number,
//                                 controller: collectedController,
//                                 obscureText: false,
//                                 style: TextStyle(color: MyColors.primaryColor),
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.fromLTRB(
//                                       20.0, 15.0, 20.0, 15.0),
//                                   hintStyle:
//                                       TextStyle(color: MyColors.darkGreyText),
//                                   hintText: "Rs",
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(
//                                         width: 0, style: BorderStyle.none),
//                                   ),
//                                   filled: true,
//                                   fillColor: MyColors.lightGrey,
//                                 ),
//                               ),
//                               showError
//                                   ? TextRegularSecondary(
//                                       text: "Enter collected amount",
//                                     )
//                                   : Container()
//                             ],
//                           ))
//                     ],
//                   ),
//                 // Payment Method Button
//                 ElevatedButton(
//                   onPressed: addPaymentMethod,
//                   child: Text("Add Payment Method"),
//                 ),
//                 // List of Payment Methods
//                 ...paymentMethods.map((payment) {
//                   int index = paymentMethods.indexOf(payment);
//                   return Row(
//                     children: [
//                       // Dropdown for Payment Method
//                       DropdownButton<String>(
//                         value: payment['method'],
//                         items: <String>['Select Method', 'Cash', 'Credit Card', 'Mobile Banking']
//                             .map((String method) {
//                           return DropdownMenuItem<String>(
//                             value: method,
//                             child: Text(method),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             paymentMethods[index]['method'] = value;
//                           });
//                         },
//                       ),
//                       // TextField for Amount
//                       Container(
//                         width: 100,
//                         child: TextField(
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: "Rs",
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               paymentMethods[index]['amount'] = int.tryParse(value) ?? 0;
//                               collectedController.text = calculateTotalAmount().toString();
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//                 // Total Collected Amount
//                 TextField(
//                   controller: collectedController,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: "Collected Amount (Rs)",
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.blue,
//               ),
//               onPressed: () {
//                 if (collectedController.text.isNotEmpty) {
//                   Navigator.of(context).pop();
//                   onNextTap();
//                 }
//               },
//               child: Text(
//                 "Next",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logistics/galliMap/signatureMap.dart';
// import 'package:logistics/reusable/staticorangetextmeduim.dart';
// import 'package:logistics/reusable/textregularsecondary.dart';
// import 'package:logistics/utils/color.dart';
// class StatusDeliveredChangePopUp extends StatelessWidget {
//   final VoidCallback onNextTap;
//   final String currentStatus;
//   final String newStatus;
//   final String productname;
//   final String price;
//   final TextEditingController collectedController;
//   final TextEditingController weightController;

//   const StatusDeliveredChangePopUp({
//     Key key,
//     this.currentStatus,
//     this.newStatus,
//     this.productname,
//     this.price,
//     @required this.collectedController,
//     @required this.weightController,
//     @required this.onNextTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> paymentMethods = [];

//     return StatefulBuilder(
//       builder: (context, setState) {
//         // Function to add new payment method entry
//         void addPaymentMethod() {
//           setState(() {
//             paymentMethods.add({'method': 'Select Method', 'amount': 0});
//           });
//         }

//         // Function to calculate total collected amount
//         int calculateTotalAmount() {
//           return paymentMethods.fold<int>(
//             0,
//             (sum, item) => sum + (item['amount'] ?? 0),
//           );
//         }

//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(14.0)),
//           ),
//           insetPadding: EdgeInsets.all(16),
//           contentPadding: EdgeInsets.fromLTRB(25, 24, 25, 38),
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // Close Button
//                 GestureDetector(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Icon(Icons.cancel),
//                   ),
//                 ),
//                 // Current Status
//                 Text("Status: $currentStatus → $newStatus"),
//                 // Product Name and Price
//                 Text("Product Name: $productname"),
//                 Text("Product Price: Rs $price"),
//                 // Payment Method Button
//                 ElevatedButton(
//                   onPressed: addPaymentMethod,
//                   child: Text("Add Payment Method"),
//                 ),
//                 // List of Payment Methods
//                 ...paymentMethods.map((payment) {
//                   int index = paymentMethods.indexOf(payment);
//                   return Row(
//                     children: [
//                       // Dropdown for Payment Method
//                       DropdownButton<String>(
//                         value: payment['method'],
//                         items: <String>['Select Method', 'Cash', 'Credit Card', 'Mobile Banking']
//                             .map((String method) {
//                           return DropdownMenuItem<String>(
//                             value: method,
//                             child: Text(method),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             paymentMethods[index]['method'] = value;
//                           });
//                         },
//                       ),
//                       // TextField for Amount
//                       Container(
//                         width: 100,
//                         child: TextField(
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: "Rs",
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               paymentMethods[index]['amount'] = int.tryParse(value) ?? 0;
//                               collectedController.text = calculateTotalAmount().toString();
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//                 // Total Collected Amount
//                 TextField(
//                   controller: collectedController,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: "Collected Amount (Rs)",
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.blue,
//               ),
//               onPressed: () {
//                 if (collectedController.text.isNotEmpty) {
//                   Navigator.of(context).pop();
//                   onNextTap();
//                 }
//               },
//               child: Text(
//                 "Next",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logistics/reusable/textregularsecondary.dart';
// import 'package:logistics/utils/color.dart';

// class StatusDeliveredChangePopUp extends StatefulWidget {
//   final VoidCallback onNextTap;
//   final String currentStatus;
//   final String newStatus;
//   final String productname;
//   final TextEditingController collectedController;
//   final String price;

//   const StatusDeliveredChangePopUp({
//     Key key,
//     this.currentStatus,
//     this.newStatus,
//     this.productname,
//     this.price,
//     @required this.collectedController,
//     @required this.onNextTap,
//   }) : super(key: key);

//   @override
//   _StatusDeliveredChangePopUpState createState() =>
//       _StatusDeliveredChangePopUpState();
// }

// class _StatusDeliveredChangePopUpState
//     extends State<StatusDeliveredChangePopUp> {
//   List<String> paymentMethods = ["Cash", "Mobile Banking", "Esewa", "Khalti"];
//   List<Map<String, dynamic>> selectedPayments = [];
//   bool showError = false;

//   void addPaymentMethod(String method) {
//     setState(() {
//       selectedPayments
//           .add({"method": method, "controller": TextEditingController()});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var showError = false;
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(14.0)),
//       ),
//       insetPadding: EdgeInsets.all(16),
//       contentPadding: EdgeInsets.fromLTRB(25, 24, 25, 38),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       content: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // Title and Status Change Row
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Container(
//                   margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                   height: 15,
//                   width: MediaQuery.of(context).size.width,
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Image.asset("assets/images/cancel.png"),
//                   ),
//                 ),
//               ),
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
//                       widget.currentStatus,
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
//                       widget.newStatus,
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w500,
//                           color: MyColors.white,
//                           fontSize: 12),
//                       textAlign: TextAlign.center,
//                     )),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: MyColors.green,
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(22, 32, 0, 20),
//                     child: Text(
//                       "Product Name :",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: MyColors.darkGreyText,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(16, 32, 32, 20),
//                     child: Text(
//                       " ${widget.productname}",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: MyColors.darkGreyText,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(22, 0, 45, 0),
//                     child: Text(
//                       "Product Price :",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: MyColors.ligtGreyText,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(24, 0, 32, 0),
//                     child: Text(
//                       "Rs ${widget.price}",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: MyColors.ligtGreyText,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.start,
//               //   children: <Widget>[
//               //     Padding(
//               //       padding: EdgeInsets.fromLTRB(22, 32, 32, 20),
//               //       child: Text(
//               //         "Collected Amount :",
//               //         textAlign: TextAlign.left,
//               //         style: TextStyle(
//               //           color: MyColors.darkGreyText,
//               //           fontFamily: 'Roboto',
//               //           fontWeight: FontWeight.w500,
//               //           fontSize: 14.0,
//               //         ),
//               //       ),
//               //     ),
//               //     Container(
//               //         width: 150,
//               //         margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//               //         child: Column(
//               //           children: <Widget>[
//               //             TextField(
//               //               inputFormatters: <TextInputFormatter>[
//               //                 FilteringTextInputFormatter.digitsOnly,
//               //               ],
//               //               keyboardType: TextInputType.number,
//               //               controller:widget.collectedController,
//               //               obscureText: false,
//               //               style: TextStyle(color: MyColors.primaryColor),
//               //               decoration: InputDecoration(
//               //                 contentPadding: EdgeInsets.fromLTRB(
//               //                     20.0, 15.0, 20.0, 15.0),
//               //                 hintStyle:
//               //                     TextStyle(color: MyColors.darkGreyText),
//               //                 hintText: "Rs",
//               //                 border: OutlineInputBorder(
//               //                   borderRadius: BorderRadius.circular(12),
//               //                   borderSide: BorderSide(
//               //                       width: 0, style: BorderStyle.none),
//               //                 ),
//               //                 filled: true,
//               //                 fillColor: MyColors.lightGrey,
//               //               ),
//               //             ),
//               //             showError
//               //                 ? TextRegularSecondary(
//               //                     text: "Enter collected amount",
//               //                   )
//               //                 : Container()
//               //           ],
//               //         ))
//               //   ],
//               // ),
//               // SizedBox(height: 20),

//               // Dropdown to select payment method
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButton<String>(
//                       hint: Text("Select Payment Method"),
//                       items: paymentMethods.map((method) {
//                         return DropdownMenuItem(
//                           value: method,
//                           child: Text(method),
//                         );
//                       }).toList(),
//                       onChanged: (selectedMethod) {
//                         if (selectedMethod != null)
//                           addPaymentMethod(selectedMethod);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),

//               // Display text fields for each selected payment method
//               Column(
//                 children: selectedPayments.map((payment) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(payment['method']),
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: TextField(
//                             controller: payment['controller'],
//                             keyboardType: TextInputType.number,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             decoration: InputDecoration(
//                               hintText: "Enter amount",
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(1, 32, 32, 20),
//                     child: Text(
//                       "Total Recived Amount :",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: MyColors.darkGreyText,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ),
//                   Container(
//                       width: 100,//150
//                       margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                       child: Column(
//                         children: <Widget>[
//                           TextField(
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             keyboardType: TextInputType.number,
//                             controller: widget.collectedController,
//                             obscureText: false,
//                             style: TextStyle(color: MyColors.primaryColor),
//                             decoration: InputDecoration(
//                               contentPadding:
//                                   EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                               hintStyle:
//                                   TextStyle(color: MyColors.darkGreyText),
//                               hintText: "Rs",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(
//                                     width: 0, style: BorderStyle.none),
//                               ),
//                               filled: true,
//                               fillColor: MyColors.lightGrey,
//                             ),
//                           ),
//                           showError
//                               ? TextRegularSecondary(
//                                   text: "Enter collected amount",
//                                 )
//                               : Container()
//                         ],
//                       ))
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           style: TextButton.styleFrom(
//             backgroundColor: MyColors.primaryColor,
//           ),
//           onPressed: () {
//             if (selectedPayments
//                 .any((payment) => payment['controller'].text.isEmpty)) {
//               setState(() {
//                 showError = true;
//               });
//             } else {
//               // Process the collected amounts here, if needed
//               Navigator.of(context).pop();
//               widget.onNextTap();
//             }
//           },
//           child: Text(
//             "Next",
//             style: TextStyle(
//               color: MyColors.white,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logistics/utils/color.dart';

// class StatusDeliveredChangePopUp extends StatefulWidget {
//   final VoidCallback onNextTap;
//   final String currentStatus;
//   final String newStatus;
//   final String productname;
//   final String price;
//   final TextEditingController collectedController;

//   const StatusDeliveredChangePopUp({
//     Key key,
//     this.currentStatus,
//     this.newStatus,
//     this.productname,
//     this.price,
//     @required this.collectedController,
//     @required this.onNextTap,
//   }) : super(key: key);

//   @override
//   _StatusDeliveredChangePopUpState createState() =>
//       _StatusDeliveredChangePopUpState();
// }

// class _StatusDeliveredChangePopUpState
//     extends State<StatusDeliveredChangePopUp> {
//   List<String> paymentMethods = [
//     "Cash",
//     "Esewa",
//     "Khalti",
//     "Mobile Banking",
//     "Others"
//   ];
//   List<Map<String, dynamic>> selectedPayments = [];
//   TextEditingController totalAmountController = TextEditingController();
//   bool showError = false;

//   // Function to add a new payment method
//   void addPaymentMethod(String method) {
//     setState(() {
//       var controller = TextEditingController();
//       controller.addListener(updateTotalAmount);
//       selectedPayments.add({"method": method, "controller": controller});
//     });
//   }

//   // Function to calculate the total amount dynamically
//   void updateTotalAmount() {
//     double total = selectedPayments.fold(0.0, (sum, payment) {
//       double value = double.tryParse(payment['controller'].text) ?? 0.0;
//       return sum + value;
//     });
//     totalAmountController.text = total.toStringAsFixed(2);
//   }

//   @override
//   void dispose() {
//     for (var payment in selectedPayments) {
//       payment['controller'].removeListener(updateTotalAmount);
//       payment['controller'].dispose();
//     }
//     totalAmountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(14.0)),
//       ),
//       insetPadding: EdgeInsets.all(16),
//       contentPadding: EdgeInsets.fromLTRB(25, 24, 25, 38),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             // Title and Status Change Row
//             // Title and Status Change Row
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                 height: 15,
//                 width: MediaQuery.of(context).size.width,
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: Image.asset("assets/images/cancel.png"),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
//               child: Text(
//                 "Do you want to change the status from",
//                 style: TextStyle(
//                     fontFamily: "Roboto",
//                     fontWeight: FontWeight.w700,
//                     color: MyColors.ligtBlack,
//                     fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   height: 65,
//                   width: 72,
//                   margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                   padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                   child: Center(
//                       child: Text(
//                     widget.currentStatus,
//                     style: TextStyle(
//                         fontFamily: "Roboto",
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.ligtBlack,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   )),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: MyColors.lightGrey,
//                   ),
//                 ),
//                 Center(
//                   child: Container(
//                     margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                     height: 65,
//                     width: 72,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Image.asset("assets/images/middivider.png"),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 65,
//                   width: 72,
//                   margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                   padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                   child: Center(
//                       child: Text(
//                     widget.newStatus,
//                     style: TextStyle(
//                         fontFamily: "Roboto",
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.white,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   )),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: MyColors.green,
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(22, 32, 0, 20),
//                   child: Text(
//                     "Product Name :",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.darkGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(16, 32, 32, 20),
//                   child: Text(
//                     " ${widget.productname}",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.darkGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(22, 0, 45, 0),
//                   child: Text(
//                     "Product Price :",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.ligtGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(24, 0, 32, 0),
//                   child: Text(
//                     "Rs ${widget.price}",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.ligtGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),

//             // Dropdown to select payment method
//             Row(
//               children: [
//                 Expanded(
//                   child: DropdownButton<String>(
//                     hint: Text("Select Payment Method"),
//                     items: paymentMethods.map((method) {
//                       return DropdownMenuItem(
//                         value: method,
//                         child: Text(method),
//                       );
//                     }).toList(),
//                     onChanged: (selectedMethod) {
//                       if (selectedMethod != null)
//                         addPaymentMethod(selectedMethod);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),

//             // Display text fields for each selected payment method
//             Column(
//               children: selectedPayments.map((payment) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(payment['method']),
//                       ),
//                       SizedBox(width: 10),
//                       // Expanded(
//                       //   child: TextField(
//                       //     controller: payment['controller'],
//                       //     keyboardType: TextInputType.number,
//                       //     inputFormatters: <TextInputFormatter>[
//                       //       FilteringTextInputFormatter.digitsOnly,
//                       //     ],
//                       //     decoration: InputDecoration(
//                       //       hintText: "Enter amount",
//                       //       border: OutlineInputBorder(),
//                       //     ),
//                       //   ),
//                       // ),

//                       Expanded(
//                         child: TextField(
//                           controller: payment['controller'],
//                           keyboardType: TextInputType.number,
//                           inputFormatters: <TextInputFormatter>[
//                             FilteringTextInputFormatter.digitsOnly,
//                           ],
//                           decoration: InputDecoration(
//                             hintText: "Enter amount",
//                             border: OutlineInputBorder(),
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 8.0,
//                                 horizontal: 12.0), // Adjust padding as needed
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 20),

//             // Total Received Amount field
//             SizedBox(height: 50,
//               child: TextField(
//                 controller: totalAmountController,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: "Total Received Amount",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           style: TextButton.styleFrom(
//             backgroundColor: MyColors.primaryColor,
//           ),
//           onPressed: () {
//             if (selectedPayments
//                 .any((payment) => payment['controller'].text.isEmpty)) {
//               setState(() {
//                 showError = true;
//               });
//             } else {
//               Navigator.of(context).pop();
//               widget.onNextTap();
//             }
//           },
//           child: Text(
//             "Next",
//             style: TextStyle(
//               color: MyColors.white,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }









// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logistics/utils/color.dart';

// class StatusDeliveredChangePopUp extends StatefulWidget {
//   final VoidCallback onNextTap;
//   final String currentStatus;
//   final String newStatus;
//   final String productname;
//   final String price;
//   final TextEditingController totalAmountController;
// final TextEditingController weightController;
//   const StatusDeliveredChangePopUp({
//     Key key,
//     this.currentStatus,
//     this.newStatus,
//     this.productname,
//     this.price,
//     @required this.totalAmountController,
//      @required this.weightController,
//     @required this.onNextTap,
//   }) : super(key: key);

//   @override
//   _StatusDeliveredChangePopUpState createState() =>
//       _StatusDeliveredChangePopUpState();
// }

// class _StatusDeliveredChangePopUpState
//     extends State<StatusDeliveredChangePopUp> {
//   List<String> paymentMethods = [
//     "Cash",
//     "Esewa",
//     "Khalti",
//     "Mobile Banking",
//     "Others"
//   ];
//   List<Map<String, dynamic>> selectedPayments = [];
//   //TextEditingController totalAmountController = TextEditingController();
//   bool showError = false;

//   void _showAmountDialog(BuildContext context) {
//     TextEditingController amountController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter Amount'),
//           content: Column(
//             mainAxisSize: MainAxisSize
//                 .min, // Make the dialog take only the necessary space
//             children: [
//               TextField(
//                 controller: amountController,
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//                 decoration: InputDecoration(
//                   hintText: "Enter amount",
//                   border: OutlineInputBorder(),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Close the dialog without doing anything
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Get the value entered by the user and print or use it
//                 String enteredAmount = amountController.text;
//                 print('Entered amount: $enteredAmount');

//                 // Close the dialog
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// bool totalRecivedAmt=false;
//   // Function to add a new payment method
//   void addPaymentMethod(String method) {
//     setState(() {
//        totalRecivedAmt=true;
//       var controller = TextEditingController();
//       controller.addListener(updateTotalAmount);
//       selectedPayments.add({"method": method, "controller": controller});
//     });
//   }

//   // Function to remove a payment method
//   void removePaymentMethod(int index) {
//     setState(() {
//       selectedPayments[index]['controller'].removeListener(updateTotalAmount);
//       selectedPayments[index]['controller'].dispose();
//       selectedPayments.removeAt(index);
//       updateTotalAmount();
//     });
//   }
   


//   // Function to calculate the total amount dynamically
//   void updateTotalAmount() {
//     //totalRecivedAmt=true;
//     double total = selectedPayments.fold(0.0, (sum, payment) {
//       double value = double.tryParse(payment['controller'].text) ?? 0.0;
   
//       return sum + value;
//     });
//    widget. totalAmountController.text = total.toStringAsFixed(2);
//    totalRecivedAmt=true;
//   }

//   @override
//   void dispose() {
//     for (var payment in selectedPayments) {
//       payment['controller'].removeListener(updateTotalAmount);
//       payment['controller'].dispose();
//     }
//    widget. totalAmountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(14.0)),
//       ),
//       insetPadding: EdgeInsets.all(16),
//       contentPadding: EdgeInsets.fromLTRB(25, 24, 25, 38),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                 height: 15,
//                 width: MediaQuery.of(context).size.width,
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: Image.asset("assets/images/cancel.png"),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
//               child: Text(
//                 "Do you want to change the status from",
//                 style: TextStyle(
//                     fontFamily: "Roboto",
//                     fontWeight: FontWeight.w700,
//                     color: MyColors.ligtBlack,
//                     fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   height: 65,
//                   width: 72,
//                   margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                   padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                   child: Center(
//                       child: Text(
//                     widget.currentStatus,
//                     style: TextStyle(
//                         fontFamily: "Roboto",
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.ligtBlack,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   )),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: MyColors.lightGrey,
//                   ),
//                 ),
//                 Center(
//                   child: Container(
//                     margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                     height: 65,
//                     width: 72,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Image.asset("assets/images/middivider.png"),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 65,
//                   width: 72,
//                   margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                   padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                   child: Center(
//                       child: Text(
//                     widget.newStatus,
//                     style: TextStyle(
//                         fontFamily: "Roboto",
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.white,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   )),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: MyColors.green,
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(22, 32, 0, 20),
//                   child: Text(
//                     "Product Name :",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.darkGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(16, 32, 32, 20),
//                   child: Text(
//                     " ${widget.productname}",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.darkGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(22, 0, 45, 0),
//                   child: Text(
//                     "Product Price :",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.ligtGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(24, 0, 32, 0),
//                   child: Text(
//                     "Rs ${widget.price}",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.ligtGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: DropdownButton<String>(
//                     hint: Text("Select Payment Method"),
//                     items: paymentMethods.map((method) {
//                       return DropdownMenuItem(
//                         value: method,
//                         child: Text(method),
//                       );
//                     }).toList(),
//                     onChanged: (selectedMethod) {
//                       if (selectedMethod != null)
//                         addPaymentMethod(selectedMethod);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Column(
//               children: selectedPayments.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 var payment = entry.value;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(payment['method']),
//                       ),
//                       SizedBox(width: 10),
                  
//                       Expanded(
//                         child: Container(
//                           height: 40.0, // Set the height to whatever you prefer
//                           child: TextField(
//                             controller: payment['controller'],
//                             keyboardType: TextInputType.number,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             decoration: InputDecoration(
//                               hintText: "Enter amount",
//                               border: OutlineInputBorder(),
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 8.0,
//                                   horizontal:
//                                       12.0), // Optional, for more control
//                             ),
//                           ),
//                         ),
//                       ),

//                       IconButton(
//                         icon: Icon(Icons.remove_circle, color: Colors.red),
//                         onPressed: () => removePaymentMethod(index),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 20),
//             Row(
//               children: [      SizedBox(
//                   height: 40,
//                   width: 160,
//                   child: totalRecivedAmt?Text(
//                     "Total Collected Amount :",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: MyColors.darkGreyText,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.0,
//                     ),
//                   ):SizedBox(),
//                 ),
//                 SizedBox(
//                   height: 0,
//                   width: 100,
//                   child: totalRecivedAmt?
//                   TextField(
                 
//                     controller:widget. totalAmountController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                        enabledBorder: InputBorder.none, // No border when not focused
//                      // labelText: "Total Received Amount",
//                      // border: OutlineInputBorder(),
//                     ),
//                   ):SizedBox(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         Container(
//           alignment: Alignment.center,
//           margin: EdgeInsets.fromLTRB(18, 0, 25, 38),
//           child: TextButton(
//             style: TextButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               backgroundColor: MyColors.primaryColor,
//             ),
//             onPressed: () {
//                print(widget. totalAmountController.text.runtimeType);
//                print(widget.totalAmountController .runtimeType);
//                print(
//                    "${widget.totalAmountController .text} newprint .text***************************************");
//                print(
//                    "${widget.totalAmountController}  without text***************************************");

//               if (widget. totalAmountController.text.isEmpty ||
//                  widget. totalAmountController.text == "0.00") {
//                 setState(() {
//                   showError = true;
//                 });
//               } else {
//                 Navigator.of(context).pop();
//                 widget.onNextTap();
//               }
//             },
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(45, 15, 45, 15),
//               child: Text(
//                 "Next",
//                 style: TextStyle(
//                   color: MyColors.white,
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }












//working code ,just multiple payment method getting choose and no image can be clicked
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logistics/utils/color.dart';

// import '../newChange/scrollabletest.dart';

// class StatusDeliveredChangePopUp extends StatefulWidget {
//   final VoidCallback onNextTap;
//   final String currentStatus;
//   final String newStatus;
//   final String productname;
//   final String price;
//   final TextEditingController totalAmountController;
//   final TextEditingController priceBreakDown;
//   final TextEditingController weightController;

//   const StatusDeliveredChangePopUp({
//     Key key,
//     this.currentStatus,
//     this.newStatus,
//     this.productname,
//     this.price,
//     @required this.totalAmountController,
//     @required this.priceBreakDown,
//     @required this.weightController,
//     @required this.onNextTap,
//   }) : super(key: key);

//   @override
//   _StatusDeliveredChangePopUpState createState() =>
//       _StatusDeliveredChangePopUpState();
// }

// class _StatusDeliveredChangePopUpState
//     extends State<StatusDeliveredChangePopUp> {
//   List<String> paymentMethods = [
//     "Cash",
//     "Esewa",
//     "Khalti",
//     "Mobile",
//     "Paid to Client",
//     "Others"
//   ];
//   List<Map<String, dynamic>> selectedPayments = [];
//   bool showError = false;
//   bool totalRecivedAmt = false;
//   String dropKey;

//   void addPaymentMethod(String method) {
//     setState(() {
//       totalRecivedAmt = true;
//       var controller = TextEditingController();
//       controller.addListener(updateTotalAmount);
//       selectedPayments.add({"method": method, "controller": controller});
//     });
//   }

//   void removePaymentMethod(int index) {
//   setState(() {
//     var payment = selectedPayments[index];
//     payment['controller'].removeListener(updateTotalAmount);
//     payment['controller'].dispose();
//     selectedPayments.removeAt(index);
//     updateTotalAmount(); // Recalculate the total amount
//   });
// }


//   void updateTotalAmount() {
//     double total = selectedPayments.fold(0.0, (sum, payment) {
//       double value = double.tryParse(payment['controller'].text) ?? 0.0;
//       return sum + value;
//     });
//     widget.totalAmountController.text = total.toStringAsFixed(2);
//     totalRecivedAmt = true;
//   }


//   @override
// void dispose() {
//   for (var payment in selectedPayments) {
//     payment['controller'].removeListener(updateTotalAmount);
//     payment['controller'].dispose(); // Dispose only locally created controllers
//   }
//   // Do not dispose of controllers passed from outside the widget
//   super.dispose();
// }


//   String getFormattedPayments() {
//     return selectedPayments
//         .where((payment) => payment['controller'].text.isNotEmpty)
//         .map((payment) {
//           String method = payment['method'].toLowerCase();
//           String amount = payment['controller'].text;
//           return "$method:$amount";
//         })
//         .join(";");
//   }
  

  
//   @override
// Widget build(BuildContext context) {
//   return WillPopScope(
//     onWillPop: () async {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => UserMain()), // Replace UserMain with your actual screen widget
//       );
//       return false;
//     },
//     child: AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(14.0)),
//       ),
//       insetPadding: EdgeInsets.all(16),
//       contentPadding: EdgeInsets.fromLTRB(25, 24, 25, 38),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                 height: 15,
//                 width: MediaQuery.of(context).size.width,
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: Image.asset("assets/images/cancel.png"),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
//               child: Text(
//                 "Do you want to change the status from",
//                 style: TextStyle(
//                     fontFamily: "Roboto",
//                     fontWeight: FontWeight.w700,
//                     color: MyColors.ligtBlack,
//                     fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   height: 65,
//                   width: 72,
//                   margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                   padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                   child: Center(
//                       child: Text(
//                     widget.currentStatus,
//                     style: TextStyle(
//                         fontFamily: "Roboto",
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.ligtBlack,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   )),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: MyColors.lightGrey,
//                   ),
//                 ),
//                 Center(
//                   child: Container(
//                     margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                     height: 65,
//                     width: 72,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Image.asset("assets/images/middivider.png"),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 65,
//                   width: 72,
//                   margin: EdgeInsets.fromLTRB(3, 16, 3, 0),
//                   padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                   child: Center(
//                       child: Text(
//                     widget.newStatus,
//                     style: TextStyle(
//                         fontFamily: "Roboto",
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.white,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   )),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: MyColors.green,
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 8, 10),
//                 child: Text(
//                 "Product Name :",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   color: MyColors.darkGreyText,
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                 ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 child: Text(
//                   " ${widget.productname}",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                   color: MyColors.darkGreyText,
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 ),
//               ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 8, 10),
//                 child: Text(
//                 "Product Price :",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   color: MyColors.darkGreyText,
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                 ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 child: Text(
//                   "Rs ${widget.price}",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                   color: MyColors.darkGreyText,
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 ),
//               ),
//               ],
//             ),
//             SizedBox(height: 4),
//             Row(
//               children: [
//                 Expanded(
//                   child: DropdownButton<String>(
//                     hint: Text("Select Payment Method"),
//                     items: paymentMethods.map((method) {
//                       if (method=="Khalti"){
//                         dropKey="khalti";
//                       }
//                       else if (method=="Esewa"){
//                          dropKey="esewa";
//                       }
//                        else if (method=="Cash"){
//                          dropKey="cash";
//                       }
//                        else if (method=="Mobile"){
//                          dropKey="mobile";
//                       }
//                        else if (method=="Others"){
//                          dropKey="others";
//                       }
//                        else if (method=="Paid to Client"){
//                          dropKey="paidToClient";
//                       }
//                       return DropdownMenuItem(
//                         value: dropKey,
//                         child: Text(method),
//                       );
//                     }).toList(),
//                     onChanged: (selectedMethod) {
//                       if (selectedMethod != null) addPaymentMethod(selectedMethod);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 4),
//             Column(
//               children: selectedPayments.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 var payment = entry.value;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(payment['method']),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Container(
//                           height: 40.0,
//                           child: TextField(
//                             controller: payment['controller'],
//                             keyboardType: TextInputType.number,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               hintText: "Enter amount",
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () => removePaymentMethod(index),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: widget.totalAmountController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: "Total Amount",
//                 border: InputBorder.none,
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         Center(
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: MyColors.primaryColor,
//             ),
     

//                onPressed: () {
//                 if( widget.price=="0"){
//                    String formattedPayments = getFormattedPayments();
//                 widget.priceBreakDown.text = formattedPayments;
//                 print("Formatted Payments: $formattedPayments");

//                 Navigator.of(context).pop();
//                 widget.onNextTap();
//                 }
//                   setState(() {
//                     showError = true;
//                   });
//               if (widget.totalAmountController.text.isEmpty ||
//                   widget.totalAmountController.text == "0.00") {
//                 setState(() {
//                   showError = true;
//                 });
//               } else {
//                 String formattedPayments = getFormattedPayments();
//                 widget.priceBreakDown.text = formattedPayments;
//                 print("Formatted Payments: $formattedPayments");

//                 Navigator.of(context).pop();
//                 widget.onNextTap();
//               }
//             },
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(45, 15, 45, 15),
//               child: Text(
//                 "Next",
//                 style: TextStyle(
//                   color: MyColors.white,
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// }


















import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logistics/utils/color.dart';

import '../newChange/scrollabletest.dart';

class StatusDeliveredChangePopUp extends StatefulWidget {
  final VoidCallback onNextTap;
  final String currentStatus;
  final String newStatus;
  final String productname;
  final String price;
  final XFile imageClient;
  final TextEditingController totalAmountController;
  final TextEditingController priceBreakDown;
  final TextEditingController weightController;

  const StatusDeliveredChangePopUp({
    Key key,
    this.currentStatus,
    this.newStatus,
    this.productname,
    this.price,
    this.imageClient,
    @required this.totalAmountController,
    @required this.priceBreakDown,
    @required this.weightController,
    @required this.onNextTap,
  }) : super(key: key);

  @override
  _StatusDeliveredChangePopUpState createState() =>
      _StatusDeliveredChangePopUpState();
}

class _StatusDeliveredChangePopUpState
    extends State<StatusDeliveredChangePopUp> {
  List<String> paymentMethods = [
    "Cash",
    "Esewa",
    "Khalti",
    "Mobile",
    "Paid to Client",
    "Others"
  ];
  List<Map<String, dynamic>> selectedPayments = [];
  bool showError = false;
  bool totalRecivedAmt = false;
  String dropKey;
  XFile _selectedImage;
  final ImagePicker _picker = ImagePicker();

  void addPaymentMethod(String method) {
    setState(() {
      totalRecivedAmt = true;
      var controller = TextEditingController();
      controller.addListener(updateTotalAmount);
      selectedPayments.add({"method": method, "controller": controller});
    });
  }

  void removePaymentMethod(int index) {
    setState(() {
      var payment = selectedPayments[index];
      payment['controller'].removeListener(updateTotalAmount);
      payment['controller'].dispose();
      selectedPayments.removeAt(index);
      updateTotalAmount(); // Recalculate the total amount
    });
  }

  // void updateTotalAmount() {
  //   double total = selectedPayments.fold(0.0, (sum, payment) {
  //     double value = double.tryParse(payment['controller'].text) ?? 0.0;
  //     return sum + value;
  //   });
  //   widget.totalAmountController.text = total.toStringAsFixed(2);
  //   totalRecivedAmt = true;
  // }

    void updateTotalAmount() {
    int total = selectedPayments.fold(0, (sum, payment) {
      int value = int.tryParse(payment['controller'].text) ?? 0.0;
      return sum + value;
    });
    widget.totalAmountController.text = total.toString();
    totalRecivedAmt = true;
  }

  

  @override
  void dispose() {
    for (var payment in selectedPayments) {
      payment['controller'].removeListener(updateTotalAmount);
      payment['controller'].dispose(); // Dispose only locally created controllers
    }
    // Do not dispose of controllers passed from outside the widget
    super.dispose();
  }

  String getFormattedPayments() {
    return selectedPayments
        .where((payment) => payment['controller'].text.isNotEmpty)
        .map((payment) {
          String method = payment['method'].toLowerCase();
          String amount = payment['controller'].text;
          return "$method:$amount";
        })
        .join(";");
  }

  Future<void> _captureImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = image;
    });
  }

  Future<void> _selectImageFromGallery() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserMain()), // Replace UserMain with your actual screen widget
        );
        return false;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        insetPadding: EdgeInsets.all(16),
        contentPadding: EdgeInsets.fromLTRB(25, 24, 25, 38),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset("assets/images/cancel.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
                child: Text(
                  "Do you want to change the status from",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      color: MyColors.ligtBlack,
                      fontSize: 16),
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
                      widget.currentStatus,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: MyColors.ligtBlack,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    )),
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
                      widget.newStatus,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: MyColors.white,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors.green,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 8, 10),
                    child: Text(
                      "Product Name :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: MyColors.darkGreyText,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        " ${widget.productname}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: MyColors.darkGreyText,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 8, 10),
                    child: Text(
                      "Product Price :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: MyColors.darkGreyText,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Rs ${widget.price}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: MyColors.darkGreyText,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      hint: Text("Select Payment Method"),
                      items: paymentMethods.map((method) {
                        if (method == "Khalti") {
                          dropKey = "khalti";
                        } else if (method == "Esewa") {
                          dropKey = "esewa";
                        } else if (method == "Cash") {
                          dropKey = "cash";
                        } else if (method == "Mobile") {
                          dropKey = "mobile";
                        } else if (method == "Others") {
                          dropKey = "others";
                        } else if (method == "Paid to Client") {
                          dropKey = "paidToClient";
                        }
                        return DropdownMenuItem(
                          value: dropKey,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (selectedMethod) {
                        if (selectedMethod != null &&
                            !selectedPayments.any((payment) =>
                                payment['method'] == selectedMethod)) {
                          addPaymentMethod(selectedMethod);
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Column(
                children: selectedPayments.asMap().entries.map((entry) {
                  int index = entry.key;
                  var payment = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(payment['method']),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 40.0,
                            child: TextField(
                              controller: payment['controller'],
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter amount",
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => removePaymentMethod(index),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              if (selectedPayments.any((payment) =>
                  payment['method'] == "paidToClient")) ...[
       Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton.icon(
      onPressed: _captureImage,
      icon: Icon(Icons.camera_alt, color: Colors.white),
      label: Text("Capture"),
      style: ElevatedButton.styleFrom(
        primary: Colors.teal, // Background color
        onPrimary: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
    SizedBox(width: 8),
    ElevatedButton.icon(
      onPressed: _selectImageFromGallery,
      icon: Icon(Icons.photo_library, color: Colors.white),
      label: Text("Select"),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Background color
        onPrimary: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
    SizedBox(width: 8),
    if (_selectedImage != null)
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  width: double.maxFinite,
                  child: InteractiveViewer(
                    child: Image.file(
                      File(_selectedImage.path),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.image,
              color: Colors.green,
              size: 24,
            ),
          ),
        ),
      ),
  ],
)
              ],
              SizedBox(height: 2),
              TextField(
                controller: widget.totalAmountController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Total Amount",
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: MyColors.primaryColor,
              ),
              onPressed: () {
                if (widget.price == "0") {
                  String formattedPayments = getFormattedPayments();
                  widget.priceBreakDown.text = formattedPayments;
                  print("Formatted Payments: $formattedPayments");

                  Navigator.of(context).pop();
                  widget.onNextTap();
                }
                setState(() {
                  showError = true;
                });
                if (widget.totalAmountController.text.isEmpty ||
                    widget.totalAmountController.text == "0.00") {
                  setState(() {
                    showError = true;
                  });
                } else {
                  String formattedPayments = getFormattedPayments();
                  widget.priceBreakDown.text = formattedPayments;
                  print("Formatted Payments: $formattedPayments");

                  Navigator.of(context).pop();
                  widget.onNextTap();
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(45, 15, 45, 15),
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: MyColors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}