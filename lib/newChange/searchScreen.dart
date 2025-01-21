


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DashboardScreenNew extends StatefulWidget {
//   @override
//   _DashboardScreenNewState createState() => _DashboardScreenNewState();
// }

// class _DashboardScreenNewState extends State<DashboardScreenNew> {


//  bool showDateFilter = false;
//   DateTimeRange dateRange;
//   final DateFormat dateFormat = DateFormat("dd MMM yyyy");

//   Future<void> _selectDateRange(BuildContext context) async {
//     final DateTime now = DateTime.now();
//     final DateTimeRange pickedRange = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(
//         now.year,
//         now.month == 1 ? 12 : now.month - 1,
//         now.day,
//       ),
//       lastDate: now,
//       initialDateRange: dateRange ??
//           DateTimeRange(
//             start: DateTime(
//               now.year,
//               now.month == 1 ? 12 : now.month - 1,
//               now.day,
//             ),
//             end: now,
//           ),
//     );

//     if (pickedRange != null) {
//       setState(() {
//         dateRange = pickedRange;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> widgetList = [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: TextField(
//             readOnly: true,
//             decoration: InputDecoration(
//               labelText: "Date Range",
//               hintText: dateRange != null
//                   ? "${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}"
//                   : "Select Date Range",
//             ),
//             onTap: () => _selectDateRange(context),
//           ),
//         ),
      
//       // Dashboard items
//       Container(
//         padding: EdgeInsets.all(10.0),
//         color: Colors.white,
//         margin: EdgeInsets.symmetric(vertical: 2.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildDashboardCard("Total Dispatch", "93"),
//                 _buildDashboardCard("Deliver Order", "118"),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildDashboardCard("Return Order", "2"),
//                 _buildDashboardCard("Pending COD", "RS 8453"),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildDashboardCard("Last COD Amount", "RS 8451"),
//                 _buildDashboardCard("Total COD Amount", "RS 9547"),
//               ],
//             ),
//             SizedBox(height: 10,),
//             DashboardCard(title: "Today Collection",value: "Rs 5500",)
//           ],
//         ),
//       ),
//     ];

//     return SingleChildScrollView(
//       child: Column(
//         children: widgetList,
//       ),
//     );
//   }

//   Widget _buildDashboardCard(String title, String value) {
//     return Container(
//       height: 110,
//      // width: 160,
//      width: (MediaQuery.of(context).size.width / 2) - 17,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title,style: TextStyle(fontSize: 17.2)),
//             SizedBox(height: 4),
//             Text(value, style: TextStyle(
//               fontSize: 25.2,
//               fontWeight: FontWeight.bold,
//             ),),
//           ],
//         ),
//       ),
//     );
//   }
// }




// class DashboardCard extends StatelessWidget {
//   // Define your data for the DashboardCard
//   final String title;
//   final String value;

//   DashboardCard({ this.title,  this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,  // Adjust the height as per your requirement
//       width: double.infinity,  // Use full width of the screen
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],  // Background color for the card
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 17.2,
             
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 25.2,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               // Navigate to the payment options screen
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PaymentOptionsScreen()),
//               );
//             },
//             child: Text('View Details'),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.red, // Button color
//               onPrimary: Colors.white, // Text color
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // PaymentOptionsScreen: The screen that shows different payment options with amounts
// class PaymentOptionsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment Options'),
//         backgroundColor: Colors.red,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             PaymentOptionTile('Esewa', 'Rs. 500'),
//             PaymentOptionTile('Khalti', 'Rs. 1200'),
//             PaymentOptionTile('Mobile Banking', 'Rs. 3000'),
//             PaymentOptionTile('Cash', 'Rs. 800'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Widget to show individual payment option with amount
// class PaymentOptionTile extends StatelessWidget {
//   final String paymentMethod;
//   final String amount;

//   PaymentOptionTile(this.paymentMethod, this.amount);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: ListTile(
//         title: Text(paymentMethod, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         subtitle: Text(amount, style: TextStyle(fontSize: 16, color: Colors.green)),
//       ),
//     );
//   }
// }





















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';

// class DashboardScreenNew extends StatefulWidget {
//   @override
//   _DashboardScreenNewState createState() => _DashboardScreenNewState();
// }

// class _DashboardScreenNewState extends State<DashboardScreenNew> {
//   final Dio dio = Dio();
//   Map<String, dynamic> dashboardData;
//   bool isLoading = true;
//   bool hasError = false;
//   final DateFormat dateFormat = DateFormat("dd MMM yyyy");
//   DateTimeRange dateRange;

//   @override
//   void initState() {
//     super.initState();
//     fetchDashboardData();
//   }

//   Future<void> fetchDashboardData() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token') ?? '';

//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.get('https://dashlogistics.dev/api/v1/employee/dashboardData');

//       if (response.statusCode == 200) {
//         setState(() {
//           dashboardData = response.data;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     final DateTime now = DateTime.now();
//     final DateTimeRange pickedRange = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(now.year, now.month == 1 ? 12 : now.month - 1, now.day),
//       lastDate: now,
//       initialDateRange: dateRange ??
//           DateTimeRange(
//             start: DateTime(now.year, now.month == 1 ? 12 : now.month - 1, now.day),
//             end: now,
//           ),
//     );

//     if (pickedRange != null) {
//       setState(() {
//         dateRange = pickedRange;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (hasError || dashboardData == null) {
//       return Center(child: Text("Failed to load dashboard data."));
//     }

//     return Scaffold(
//           appBar: AppBar(
//         title: Text(
//           "Dashboard",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Stack(
//               children: [
//                 Icon(Icons.notifications, color: Colors.black),
//               ],
//             ),
//             onPressed: () {},
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
//       body: RefreshIndicator(
//         onRefresh: fetchDashboardData,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextField(
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: "Date Range",
//                     hintText: dateRange != null
//                         ? "${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}"
//                         : "Select Date Range",
//                   ),
//                   onTap: () => _selectDateRange(context),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 color: Colors.white,
//                 margin: EdgeInsets.symmetric(vertical: 2.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildDashboardCard("Total Dispatch", "${dashboardData['total_dispatched']}"),
//                         _buildDashboardCard("Deliver Order", "${dashboardData['total_delivered']}"),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildDashboardCard("Return Order", "${dashboardData['total_reschedule']}"),
//                         _buildDashboardCard("Pending COD", "Rs ${dashboardData['pending_cod']}"),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildDashboardCard("Last COD Amount", "Rs ${dashboardData['last_cod']}"),
//                         _buildDashboardCard("Total COD Amount", "Rs ${dashboardData['total_cod']}"),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     DashboardCard(
//                       title: "Today Collection Rs ${dashboardData['total_collection']['total_amount']}",
//                       value1: "Esewa Collection Rs ${dashboardData['total_collection']['esewa_amount']}",
//                       value2: "Khalti Collection Rs ${dashboardData['total_collection']['khalti_amount']}",
//                       value3: "MobileBanking Collection Rs ${dashboardData['total_collection']['mobile_amount']}",
//                       value4: "Cash Collection ${dashboardData['total_collection']['cash_amount']}",
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard(String title, String value) {
//     return Container(
//       height: 110,
//       width: (MediaQuery.of(context).size.width / 2) - 17,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title, style: TextStyle(fontSize: 17.2)),
//             SizedBox(height: 4),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 25.2,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final String title;
//   final String value1;
//   final String value2;
//   final String value3;
//   final String value4;

//   DashboardCard({this.title, this.value1,this.value2,this.value3,this.value4});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 180,
//       width: double.infinity,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//            Text(
//             title,
//             style: TextStyle(
//               fontSize: 25.2,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             value1,
//             style: TextStyle(
//               fontSize: 17.2,
//             ),
//           ),
//            SizedBox(height: 4),
//            Text(
//             value2,
//             style: TextStyle(
//               fontSize: 17.2,
//             ),
//           ),
//            SizedBox(height: 4),
//          Text(
//             value3,
//             style: TextStyle(
//               fontSize: 17.2,
//             ),
//           ),
//            SizedBox(height: 4),
//           Text(
//             value4,
//             style: TextStyle(
//               fontSize: 17.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }









// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';

// class DashboardScreenNew extends StatefulWidget {
//   @override
//   _DashboardScreenNewState createState() => _DashboardScreenNewState();
// }

// class _DashboardScreenNewState extends State<DashboardScreenNew> {
//   final Dio dio = Dio();
//   Map<String, dynamic> dashboardData;
//   bool isLoading = true;
//   bool hasError = false;
//   final DateFormat dateFormat = DateFormat("dd MMM yyyy");
//   DateTimeRange dateRange;

//   @override
//   void initState() {
//     super.initState();
//     loadCachedData();
//   }

//   Future<void> loadCachedData() async {
//     setState(() => isLoading = true);

//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String cachedData = prefs.getString('dashboardData');

//     if (cachedData != null) {
//       setState(() {
//         dashboardData = jsonDecode(cachedData);
//         isLoading = false;
//       });
//     } else {
//       await fetchDashboardData(); // Fetch data if no cache is available
//     }
//   }

//   Future<void> fetchDashboardData() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token') ?? '';

//       dio.options.headers['Authorization'] = 'Bearer $token';

//       // Prepare query parameters
//       Map<String, String> queryParams = {};
//       if (dateRange != null) {
//         queryParams = {
//           'start_date': DateFormat('yyyy-MM-dd').format(dateRange.start),
//           'end_date': DateFormat('yyyy-MM-dd').format(dateRange.end),
//         };
//       }

//       final response = await dio.get(
//         'https://dashlogistics.dev/api/v1/employee/dashboardData',
//         queryParameters: queryParams,
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           dashboardData = response.data;
//           isLoading = false;
//         });

//         // Save the data to SharedPreferences for caching
//         await prefs.setString('dashboardData', jsonEncode(dashboardData));
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     final DateTime now = DateTime.now();
//     final DateTimeRange pickedRange = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(now.year, now.month == 1 ? 12 : now.month - 1, now.day),
//       lastDate: now,
//       initialDateRange: dateRange ??
//           DateTimeRange(
//             start: DateTime(now.year, now.month == 1 ? 12 : now.month - 1, now.day),
//             end: now,
//           ),
//     );

//     if (pickedRange != null) {
//       setState(() {
//         dateRange = pickedRange;
//         isLoading = true; // Show loading indicator during fetch
//       });
//       await fetchDashboardData(); // Fetch data for the selected range
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (hasError || dashboardData == null) {
//       return Center(child: Text("Failed to load dashboard data."));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Dashboard",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Stack(
//               children: [
//                 Icon(Icons.notifications, color: Colors.black),
//               ],
//             ),
//             onPressed: () {},
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
//       body: RefreshIndicator(
//         onRefresh: fetchDashboardData, // Fetch data on manual refresh
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextField(
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: "Date Range",
//                     hintText: dateRange != null
//                         ? "${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}"
//                         : "Select Date Range",
//                   ),
//                   onTap: () => _selectDateRange(context),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 color: Colors.white,
//                 margin: EdgeInsets.symmetric(vertical: 2.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildDashboardCard("Total Dispatch", "${dashboardData['total_dispatched']}"),
//                         _buildDashboardCard("Deliver Order", "${dashboardData['total_delivered']}"),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildDashboardCard("Return Order", "${dashboardData['total_reschedule']}"),
//                         _buildDashboardCard("Pending COD", "Rs ${dashboardData['pending_cod']}"),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildDashboardCard("Last COD Amount", "Rs ${dashboardData['last_cod']}"),
//                         _buildDashboardCard("Total COD Amount", "Rs ${dashboardData['total_cod']}"),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     DashboardCard(
//                       title: "Today Collection Rs ${dashboardData['total_collection']['total_amount']}",
//                       value1: "Esewa Collection Rs ${dashboardData['total_collection']['esewa_amount']}",
//                       value2: "Khalti Collection Rs ${dashboardData['total_collection']['khalti_amount']}",
//                       value3: "MobileBanking Collection Rs ${dashboardData['total_collection']['mobile_amount']}",
//                       value4: "Cash Collection ${dashboardData['total_collection']['cash_amount']}",
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard(String title, String value) {
//     return Container(
//       height: 110,
//       width: (MediaQuery.of(context).size.width / 2) - 17,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title, style: TextStyle(fontSize: 17.2)),
//             SizedBox(height: 4),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 25.2,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final String title;
//   final String value1;
//   final String value2;
//   final String value3;
//   final String value4;

//   DashboardCard({this.title, this.value1, this.value2, this.value3, this.value4});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 180,
//       width: double.infinity,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 25.2,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(value1, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value2, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value3, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value4, style: TextStyle(fontSize: 17.2)),
//         ],
//       ),
//     );
//   }
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

// class DashboardScreenNew extends StatefulWidget {
//   @override
//   _DashboardScreenNewState createState() => _DashboardScreenNewState();
// }

// class _DashboardScreenNewState extends State<DashboardScreenNew> {
//   final Dio dio = Dio();
//   Map<String, dynamic> dashboardData;
//   bool isLoading = true;
//   bool hasError = false;
//   final DateFormat dateFormat = DateFormat("dd MMM yyyy");
//   DateTimeRange dateRange;

//   @override
//   void initState() {
//     super.initState();
//     fetchDashboardData();
//   }

//   Future<void> fetchDashboardData() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token') ?? '';

//       dio.options.headers['Authorization'] = 'Bearer $token';

//       // Include the date range in the API request if available
//       String url = 'https://dashlogistics.dev/api/v1/employee/dashboardData';
//       if (dateRange != null) {
//         url += '?startDate=${dateFormat.format(dateRange.start)}&endDate=${dateFormat.format(dateRange.end)}';
//       }

//       final response = await dio.get(url);

//       if (response.statusCode == 200) {
//         setState(() {
//           dashboardData = response.data;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     final DateTime now = DateTime.now();
//     final DateTime start = now.subtract(Duration(days: 30));
//     final DateTime end = now;

//     final DateTimeRange pickedRange = await showDateRangePicker(
//       context: context,
//       initialDateRange: DateTimeRange(start: start, end: end),
//       firstDate: DateTime(now.year - 1), // Allows selecting dates up to 1 year back
//       lastDate: now,
//     );

//     if (pickedRange != null) {
//       setState(() {
//         dateRange = pickedRange;
//       });

//       // Fetch data for the new date range
//       await fetchDashboardData();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (hasError || dashboardData == null) {
//       return Center(child: Text("Failed to load dashboard data."));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Dashboard",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh, color: Colors.black),
//             onPressed: fetchDashboardData,
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: fetchDashboardData,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextField(
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: "Date Range",
//                     hintText: dateRange != null
//                         ? "${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}"
//                         : "Select Date Range",
//                   ),
//                   onTap: () => _selectDateRange(context),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Total Dispatched and Delivered
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   DashboardCard(
//                     title: "Total Dispatched",
//                     value: dashboardData['total_dispatched'].toString(),
//                   ),
//                   DashboardCard(
//                     title: "Total Delivered",
//                     value: dashboardData['total_delivered'].toString(),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               // Total Reschedule and Pending COD
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   DashboardCard(
//                     title: "Total Reschedule",
//                     value: dashboardData['total_reschedule'].toString(),
//                   ),
//                   DashboardCard(
//                     title: "Pending COD",
//                     value: "Rs ${dashboardData['pending_cod']}",
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               // Total COD and Last COD Amount
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   DashboardCard(
//                     title: "Total COD Amount",
//                     value: "Rs ${dashboardData['total_cod']}",
//                   ),
//                   DashboardCard(
//                     title: "Last COD Amount",
//                     value: "Rs ${dashboardData['last_cod']}",
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               // Total Collection (Esewa, Khalti, Cash, etc.)
//               DashboardCard(
//                 title: "Today Collection Rs ${dashboardData['total_collection']['total_amount']}",
//                 value1: "Esewa Collection Rs ${dashboardData['total_collection']['esewa_amount']}",
//                 value2: "Khalti Collection Rs ${dashboardData['total_collection']['khalti_amount']}",
//                 value3: "MobileBanking Collection Rs ${dashboardData['total_collection']['mobile_amount']}",
//                 value4: "Cash Collection Rs ${dashboardData['total_collection']['cash_amount']}",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String value1;
//   final String value2;
//   final String value3;
//   final String value4;

//   DashboardCard({this.title, this.value, this.value1, this.value2, this.value3, this.value4});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       margin: EdgeInsets.all(8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             if (value != null) Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             if (value1 != null) Text(value1, style: TextStyle(fontSize: 16)),
//             if (value2 != null) Text(value2, style: TextStyle(fontSize: 16)),
//             if (value3 != null) Text(value3, style: TextStyle(fontSize: 16)),
//             if (value4 != null) Text(value4, style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

// class DashboardScreenNew extends StatefulWidget {
//   @override
//   _DashboardScreenNewState createState() => _DashboardScreenNewState();
// }

// class _DashboardScreenNewState extends State<DashboardScreenNew> {
//   final Dio dio = Dio();
//   Map<String, dynamic> dashboardData;
//   bool isLoading = true;
//   bool hasError = false;
//   final DateFormat dateFormat = DateFormat("dd MMM yyyy");
//   DateTimeRange dateRange;

//   @override
//   void initState() {
//     super.initState();
//     fetchDashboardData();
//   }

//   Future<void> fetchDashboardData() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token') ?? '';

//       dio.options.headers['Authorization'] = 'Bearer $token';

//       // Include the date range in the API request if available
//       String url = 'https://dashlogistics.dev/api/v1/employee/dashboardData';
//       if (dateRange != null) {
//         url += '?startDate=${dateFormat.format(dateRange.start)}&endDate=${dateFormat.format(dateRange.end)}';
//       }

//       final response = await dio.get(url);

//       if (response.statusCode == 200) {
//         setState(() {
//           dashboardData = response.data;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     final DateTime now = DateTime.now();
//     final DateTime start = now.subtract(Duration(days: 30));
//     final DateTime end = now;

//     final DateTimeRange pickedRange = await showDateRangePicker(
//       context: context,
//       initialDateRange: DateTimeRange(start: start, end: end),
//       firstDate: DateTime(now.year - 1), // Allows selecting dates up to 1 year back
//       lastDate: now,
//     );

//     if (pickedRange != null) {
//       setState(() {
//         dateRange = pickedRange;
//       });

//       // Fetch data for the new date range
//       await fetchDashboardData();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (hasError || dashboardData == null) {
//       return Center(child: Text("Failed to load dashboard data."));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Dashboard",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh, color: Colors.black),
//             onPressed: fetchDashboardData,
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: fetchDashboardData,
//         child: SingleChildScrollView(
//           child: Container(
//             color: Colors.pink[100],  // Set pink background color
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: TextField(
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: "Date Range",
//                       hintText: dateRange != null
//                           ? "${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}"
//                           : "Select Date Range",
//                     ),
//                     onTap: () => _selectDateRange(context),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // Display the dashboard data
//                 Container(
//                   padding: EdgeInsets.all(10.0),
//                   color: Colors.white,
//                   margin: EdgeInsets.symmetric(vertical: 2.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildDashboardCard("Total Dispatch", "${dashboardData['total_dispatched']}"),
//                           _buildDashboardCard("Deliver Order", "${dashboardData['total_delivered']}"),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildDashboardCard("Return Order", "${dashboardData['total_reschedule']}"),
//                           _buildDashboardCard("Pending COD", "Rs ${dashboardData['pending_cod']}"),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildDashboardCard("Last COD Amount", "Rs ${dashboardData['last_cod']}", fontSize: 18),
//                           _buildDashboardCard("Total COD Amount", "Rs ${dashboardData['total_cod']}"),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       DashboardCard(
//                         title: "Today Collection Rs ${dashboardData['total_collection']['total_amount']}",
//                         value1: "Esewa Collection Rs ${dashboardData['total_collection']['esewa_amount']}",
//                         value2: "Khalti Collection Rs ${dashboardData['total_collection']['khalti_amount']}",
//                         value3: "MobileBanking Collection Rs ${dashboardData['total_collection']['mobile_amount']}",
//                         value4: "Cash Collection ${dashboardData['total_collection']['cash_amount']}",
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard(String title, String value, {double fontSize = 25.2}) {
//     return Container(
//       height: 110,
//       width: (MediaQuery.of(context).size.width / 2) - 17,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title, style: TextStyle(fontSize: 17.2)),
//             SizedBox(height: 4),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//               ),
//               overflow: TextOverflow.ellipsis,  // Prevent text overflow
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final String title;
//   final String value1;
//   final String value2;
//   final String value3;
//   final String value4;

//   DashboardCard({this.title, this.value1, this.value2, this.value3, this.value4});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 180,
//       width: double.infinity,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 25.2,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(value1, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value2, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value3, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value4, style: TextStyle(fontSize: 17.2)),
//         ],
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

// class DashboardScreenNew extends StatefulWidget {
//   @override
//   _DashboardScreenNewState createState() => _DashboardScreenNewState();
// }

// class _DashboardScreenNewState extends State<DashboardScreenNew> {
//   final Dio dio = Dio();
//   Map<String, dynamic> dashboardData;
//   bool isLoading = true;
//   bool hasError = false;
//   final DateFormat dateFormat = DateFormat("dd MMM yyyy");
//   DateTimeRange dateRange;

//   @override
//   void initState() {
//     super.initState();
//     loadCachedData();
//   }

//   Future<void> loadCachedData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String cachedData = prefs.getString('dashboardData');

//     if (cachedData != null) {
//       setState(() {
//         dashboardData = jsonDecode(cachedData);
//         isLoading = false;
//       });
//     } else {
//       fetchDashboardData();
//     }
//   }

//   Future<void> fetchDashboardData() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token') ?? '';

//       dio.options.headers['Authorization'] = 'Bearer $token';

//       // Include the date range in the API request if available
//       String url = 'https://dashlogistics.dev/api/v1/employee/dashboardData';
//       if (dateRange != null) {
//         url += '?startDate=${dateFormat.format(dateRange.start)}&endDate=${dateFormat.format(dateRange.end)}';
//       }

//       final response = await dio.get(url);

//       if (response.statusCode == 200) {
//         setState(() {
//           dashboardData = response.data;
//           isLoading = false;
//         });

//         // Cache the fetched data
//         await prefs.setString('dashboardData', jsonEncode(dashboardData));
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     final DateTime now = DateTime.now();
//     final DateTime start = now.subtract(Duration(days: 30));
//     final DateTime end = now;

//     final DateTimeRange pickedRange = await showDateRangePicker(
//       context: context,
//       initialDateRange: DateTimeRange(start: start, end: end),
//       firstDate: DateTime(now.year - 1), // Allows selecting dates up to 1 year back
//       lastDate: now,
//     );

//     if (pickedRange != null) {
//       setState(() {
//         dateRange = pickedRange;
//       });

//       // Fetch data for the new date range
//       await fetchDashboardData();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (hasError || dashboardData == null) {
//       return Center(child: Text("Failed to load dashboard data."));
//     }

//     return Scaffold(
//        appBar: AppBar(
//         title: Text(
//           "Dashboard",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         // actions: [
//         //   IconButton(
//         //     icon: Stack(
//         //       children: [
//         //         Icon(Icons.notifications, color: Colors.black),
//         //       ],
//         //     ),
//         //     onPressed: () {},
//         //   ),
//         // ],
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: fetchDashboardData,
//         child: SingleChildScrollView(
//           child: Container(
//             color: Colors.pink[100],  // Set pink background color
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: TextField(
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: "Date Range",
//                       hintText: dateRange != null
//                           ? "${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}"
//                           : "Select Date Range",
//                       fillColor: Colors.white,  // Set white background for the text field
//                       filled: true,
//                     ),
//                     onTap: () => _selectDateRange(context),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // Display the dashboard data
//                 Container(
//                   padding: EdgeInsets.all(10.0),
//                   color: Colors.white,
//                   margin: EdgeInsets.symmetric(vertical: 2.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildDashboardCard("Total Dispatch", "${dashboardData['total_dispatched']}"),
//                           _buildDashboardCard("Deliver Order", "${dashboardData['total_delivered']}"),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildDashboardCard("Return Order", "${dashboardData['total_reschedule']}"),
//                           _buildDashboardCard("Pending COD", "Rs ${dashboardData['pending_cod']}"),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildDashboardCard("Last COD Amount", "Rs ${dashboardData['last_cod']}", fontSize: 18),
//                           _buildDashboardCard("Total COD Amount", "Rs ${dashboardData['total_cod']}"),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       DashboardCard(
//                         title: "Today Collection Rs ${dashboardData['total_collection']['total_amount']}",
//                         value1: "Esewa Collection Rs ${dashboardData['total_collection']['esewa_amount']}",
//                         value2: "Khalti Collection Rs ${dashboardData['total_collection']['khalti_amount']}",
//                         value3: "MobileBanking Collection Rs ${dashboardData['total_collection']['mobile_amount']}",
//                         value4: "Cash Collection ${dashboardData['total_collection']['cash_amount']}",
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard(String title, String value, {double fontSize = 25.2}) {
//     return Container(
//       height: 110,
//       width: (MediaQuery.of(context).size.width / 2) - 17,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title, style: TextStyle(fontSize: 17.2)),
//             SizedBox(height: 4),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//               ),
//               overflow: TextOverflow.ellipsis,  // Prevent text overflow
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final String title;
//   final String value1;
//   final String value2;
//   final String value3;
//   final String value4;

//   DashboardCard({this.title, this.value1, this.value2, this.value3, this.value4});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 180,
//       width: double.infinity,
//       padding: EdgeInsets.all(8.0),
//       color: Colors.pink[200],
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 25.2,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(value1, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value2, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value3, style: TextStyle(fontSize: 17.2)),
//           SizedBox(height: 4),
//           Text(value4, style: TextStyle(fontSize: 17.2)),
//         ],
//       ),
//     );
//   }
// }






import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logistics/Drawer/drawer.dart';
import 'package:logistics/Drawer/privacyPolicy.dart';
import 'package:logistics/newChange/rateApp.dart';
import 'package:logistics/newChange/riderDetailsScreen.dart';
import 'package:logistics/newChange/sidebarNotification.dart';
import 'package:logistics/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

import '../login/login_screen.dart';
import '../utils/color.dart';
import 'aboutUs.dart';

class DashboardScreenNew extends StatefulWidget {
  @override
  _DashboardScreenNewState createState() => _DashboardScreenNewState();
}

class _DashboardScreenNewState extends State<DashboardScreenNew> {
  final Dio dio = Dio();
  Map<String, dynamic> dashboardData;
  bool isLoading = true;
  bool hasError = false;
  final DateFormat dateFormat = DateFormat("dd MMM yyyy");
  DateTimeRange dateRange;
  QRViewExample qrViewExample;

  @override
  void initState() {
    super.initState();
    loadCachedData();
  }


      void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");

   
  await prefs.remove('cachedDeliveryList'); // Clear delivery cache
  print("User logged out. Cache cleared.");
  // Navigate to login screen
    
  }

  Future<void> loadCachedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cachedData = prefs.getString('dashboardData');

    if (cachedData != null) {
      setState(() {
        dashboardData = jsonDecode(cachedData);
        isLoading = false;
      });
    } else {
      fetchDashboardData();
    }
  }

  Future<void> fetchDashboardData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token') ?? '';

      dio.options.headers['Authorization'] = 'Bearer $token';

      // Include the date range in the API request if available
      String url = 'https://dashlogistics.dev/api/v1/employee/dashboardData';
      if (dateRange != null) {
        url += '?startDate=${dateFormat.format(dateRange.start)}&endDate=${dateFormat.format(dateRange.end)}';
      }

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        setState(() {
          dashboardData = response.data;
          isLoading = false;
        });

        // Cache the fetched data
        await prefs.setString('dashboardData', jsonEncode(dashboardData));
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime start = now.subtract(Duration(days: 30));
    final DateTime end = now;

    final DateTimeRange pickedRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: start, end: end),
      firstDate: DateTime(now.year - 1), // Allows selecting dates up to 1 year back
      lastDate: now,
    );

    if (pickedRange != null) {
      setState(() {
        dateRange = pickedRange;
      });

      // Fetch data for the new date range
      await fetchDashboardData();
    }
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
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (hasError || dashboardData == null) {
      return Center(child: Text("Failed to load dashboard data."));
    }

    return Scaffold(

   drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Dashboard",
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
        onRefresh: fetchDashboardData,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.pink[100], // Set pink background color
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date Range",
                      hintText: dateRange != null
                          ? "${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}"
                          : "Select Date Range",
                      fillColor: Colors.white, // Set white background for the text field
                      filled: true,
                    ),
                    onTap: () => _selectDateRange(context),
                  ),
                ),
                SizedBox(height: 10),
                // Display the dashboard data
                Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDashboardCard("Total Dispatch", "${dashboardData['total_dispatched']}"),
                          _buildDashboardCard("Deliver Order", "${dashboardData['total_delivered']}"),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDashboardCard("Return Order", "${dashboardData['total_reschedule']}"),
                          _buildDashboardCard("Pending COD", "Rs ${dashboardData['pending_cod']}"),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDashboardCard("Last COD Amount", "Rs ${dashboardData['last_cod']}", fontSize: 18),
                          _buildDashboardCard("Total COD Amount", "Rs ${dashboardData['total_cod']}"),
                        ],
                      ),
                      SizedBox(height: 10),
                      DashboardCard(
                        title: "Today Collection Rs ${dashboardData['total_collection']['total_amount']}",
                        
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink, // Button background color
                            onPrimary: Colors.white, // Button text color
                          ),
                          onPressed: () {
                            _showCollectionDetails(context);
                          },
                          child: Text("View Details"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, {double fontSize = 25.2}) {
    return Container(
      height: 110,
      width: (MediaQuery.of(context).size.width / 2) - 17,
      padding: EdgeInsets.all(8.0),
      color: Colors.pink[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 17.2)),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis, // Prevent text overflow
            ),
          ],
        ),
      ),
    );
  }

  // void _showCollectionDetails(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Collection Details"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             SingleChildScrollView(
  //               scrollDirection: Axis.horizontal,
  //               child: Text("Esewa Collection: Rs ${dashboardData['total_collection']['esewa_amount']}"),
  //             ),
  //             SizedBox(height: 8),
  //             SingleChildScrollView(
  //               scrollDirection: Axis.horizontal,
  //               child: Text("Khalti Collection: Rs ${dashboardData['total_collection']['khalti_amount']}"),
  //             ),
  //             SizedBox(height: 8),
  //             SingleChildScrollView(
  //               scrollDirection: Axis.horizontal,
  //               child: Text("MobBank Collection: Rs ${dashboardData['total_collection']['mobile_amount']}"),
  //             ),
  //             SizedBox(height: 8),
  //             SingleChildScrollView(
  //               scrollDirection: Axis.horizontal,
  //               child: Text("Cash Collection: Rs ${dashboardData['total_collection']['cash_amount']}"),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //             child: Text("Close"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }



  void _showCollectionDetails(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Center(
          child: Text(
            "Collection Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCollectionItem(
              title: "Esewa Collection",
              amount: dashboardData['total_collection']['esewa_amount'],
              color: Colors.green.shade200,
            ),
            _buildCollectionItem(
              title: "Khalti Collection",
              amount: dashboardData['total_collection']['khalti_amount'],
              color: Colors.blue.shade200,
            ),
            _buildCollectionItem(
              title: "MobBank Collection",
              amount: dashboardData['total_collection']['mobile_amount'],
              color: Colors.orange.shade200,
            ),
            _buildCollectionItem(
              title: "Cash Collection",
              amount: dashboardData['total_collection']['cash_amount'],
              color: Colors.purple.shade200,
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildCollectionItem({ String title,  dynamic amount,  Color color}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1), // Subtle shadow
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        Text(
          "Rs $amount",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
      ],
    ),
  );
}

}

class DashboardCard extends StatelessWidget {
  final String title;
  

  DashboardCard({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      color: Colors.pink[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 25.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
         
        ],
      ),
    );
  }
}
