// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/Drawer/drawer.dart';

// import 'package:logistics/edit/packageedit/package_edit_presenter.dart';
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


// // code with cache
// // class DynamicListScreenDelivered extends StatefulWidget {
// //   @override
// //   DynamicListScreenDeliveredState createState() =>
// //       DynamicListScreenDeliveredState();
// // }

// // class DynamicListScreenDeliveredState
// //     extends State<DynamicListScreenDelivered> {
// //   EditPackageScreenContract _view;
// //   final Dio dio = Dio();
// //   final ScrollController _scrollController = ScrollController();
// //   List<dynamic> _deliveryList = [];
// //   bool _isLoading = false;
// //   int _page = 1; // Start with page 1

// //   Future<List<dynamic>> fetchData(int page) async {
// //     BaseOptions options = BaseOptions(
// //       baseUrl: 'https://dashlogistics.dev/api/v1/employee/statusData',
// //       connectTimeout: Duration(milliseconds: 30000),
// //       receiveTimeout: Duration(milliseconds: 30000),
// //       validateStatus: (status) => status < 500,
// //     );

// //     final SharedPreferences prefs = await SharedPreferences.getInstance();
// //     final String token = prefs.getString('token') ?? '';

// //     dio.options.headers["Authorization"] = "Bearer $token";

// //     try {
// //       final response = await dio.get(
// //         'https://dashlogistics.dev/api/v1/employee/statusData',
// //         queryParameters: {
// //           'status': 'delivered',
// //           'page': page
// //         }, // Added status parameter
// //       );

// //       if (response.statusCode == 200) {
// //         return response.data['data']; // Return the 'data' array
// //       } else {
// //         _view.onError("Something Went Wrong");
// //       }
// //     } catch (e) {
// //       _view.onError("Something Went Wrong");
// //     }
// //   }

// //   Future<void> _clearCache() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     prefs.remove('cachedDeliveryList'); // Clear cache
// //     print("Cache cleared for testing.");
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadInitialData();

// //     _scrollController.addListener(() {
// //       print("5st***************");
// //       if (_scrollController.position.pixels >=
// //               _scrollController.position.maxScrollExtent - 50 &&
// //           !_isLoading) {
// //         print("1st***************");
// //         _loadMoreData();
// //       }
// //     });
// //   }

// //   Future<void> _loadInitialData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String cachedData = prefs.getString('cachedDeliveryList');

// //     if (cachedData != null && cachedData.isNotEmpty) {
// //       //  await _loadMoreData();
// //       print("Cache data is present *************");
// //       setState(() {
// //         _deliveryList = List<dynamic>.from(json.decode(cachedData));
// //       });
// //     } else {
// //       print("No cache data is present *************");
// //       await _loadMoreData(); // Load from server if no cached data
// //     }
// //   }

// //   Future<void> _cacheData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('cachedDeliveryList', json.encode(_deliveryList));
// //     print("Data cached successfully.");
// //   }

// //   Future<void> _loadMoreData() async {
// //     if (_isLoading) return; // Prevent multiple calls

// //     setState(() => _isLoading = true);

// //     try {
// //       List<dynamic> newData = await fetchData(_page);

// //       if (newData.isNotEmpty) {
// //         setState(() {
// //           _deliveryList.addAll(newData);
// //           _page++;
// //         });

// //         // Cache the updated data
// //         await _cacheData();
// //       } else {
// //         print("No more data available."); // No further API calls
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //        // SnackBar(content: Text("Error loading data: $e")),
// //        SnackBar(
// //   content: Text("Session Expired. Please log in again"),
// // )
// //       );
// //       print("Error loading data: $e");
// //     } finally {
// //       setState(() => _isLoading = false);
// //     }
// //   }

// //   // Function to fetch new data
// //   Future<void> _loadNewData() async {
// //     setState(() => _isLoading = true); // Show loading indicator
// //     try {
// //       _page = 1; // Reset to first page
// //       List<dynamic> newData = await fetchData(_page);
// //       setState(() {
// //         _deliveryList = newData; // Replace current data with new data
// //       });
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Error refreshing data: $e")),
// //       );
// //     } finally {
// //       setState(() => _isLoading = false); // Hide loading indicator
// //     }
// //   }


// // code without cache
// class DynamicListScreenDelivered extends StatefulWidget {
//   @override
//   DynamicListScreenDeliveredState createState() =>
//       DynamicListScreenDeliveredState();
// }

// class DynamicListScreenDeliveredState
//     extends State<DynamicListScreenDelivered> {
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
//         queryParameters: {
//           'status': 'delivered',
//           'page': page,
//         }, // Added status parameter
//       );

//       if (response.statusCode == 200) {
//         return response.data['data']; // Return the 'data' array
//       } else {
//         throw Exception("Failed to load data");
//       }
//     } catch (e) {
//       throw Exception("Error fetching data: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadInitialData();

//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//               _scrollController.position.maxScrollExtent - 50 &&
//           !_isLoading) {
//         _loadMoreData();
//       }
//     });
//   }

//   Future<void> _loadInitialData() async {
//     setState(() {
//       _deliveryList.clear(); // Clear existing data
//     });
//     await _loadMoreData(); // Fetch fresh data
//   }

//   Future<void> _loadMoreData() async {
//     if (_isLoading) return; // Prevent multiple calls

//     setState(() => _isLoading = true);

//     try {
//       List<dynamic> newData = await fetchData(_page);

//       if (newData.isNotEmpty) {
//         setState(() {
//           _deliveryList.addAll(newData);
//           _page++;
//         });
//       } else {
//         print("No more data available.");
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error loading data: $e")),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _loadNewData() async {
//     setState(() => _isLoading = true); // Show loading indicator

//     try {
//       _page = 1; // Reset to the first page
//       List<dynamic> newData = await fetchData(_page);

//       setState(() {
//         _deliveryList = newData; // Replace current data with new data
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error refreshing data: $e")),
//       );
//     } finally {
//       setState(() => _isLoading = false); // Hide loading indicator
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }



// class DynamicListScreenDelivered extends StatefulWidget {
//   @override
//   DynamicListScreenDeliveredState createState() =>
//       DynamicListScreenDeliveredState();
// }

// class DynamicListScreenDeliveredState
//     extends State<DynamicListScreenDelivered> {
//   EditPackageScreenContract _view;
//   final Dio dio = Dio();
//   final ScrollController _scrollController = ScrollController();
//   List<dynamic> _deliveryList = [];
//   bool _isLoading = false;
//   int _page = 1; // Start with page 1

//   // Future<List<dynamic>> fetchData(int page) async {
//   //   BaseOptions options = BaseOptions(
//   //     baseUrl: 'https://dashlogistics.dev/api/v1/employee/statusData',
//   //     connectTimeout: Duration(milliseconds: 30000),
//   //     receiveTimeout: Duration(milliseconds: 30000),
//   //     validateStatus: (status) => status < 500,
//   //   );

//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   final String token = prefs.getString('token') ?? '';

//   //   dio.options.headers["Authorization"] = "Bearer $token";

//   //   try {
//   //     final response = await dio.get(
//   //       'https://dashlogistics.dev/api/v1/employee/statusData',
//   //       queryParameters: {
//   //         'status': 'delivered',
//   //         'page': page
//   //       }, // Added status parameter
//   //     );

//   //     if (response.statusCode == 200) {
//   //       return response.data['data']; // Return the 'data' array
//   //     } else {
//   //       _view.onError("Something Went Wrong");
//   //     }
//   //   } catch (e) {
//   //     _view.onError("Something Went Wrong");
//   //   }
//   // }



//   Future<List<dynamic>> fetchData(int page) async {
//   try {
//     final response = await dio.get(
//       'https://dashlogistics.dev/api/v1/employee/statusData',
//       queryParameters: {'status': 'delivered', 'page': page},
//     );

//     if (response.statusCode == 200) {
//       return response.data['data'] ?? []; // Return data or empty list
//     } else {
//       print("API Error: ${response.statusCode}");
//       return [];
//     }
//   } catch (e) {
//     print("Error fetching data: $e");
//     return [];
//   }
// }


//   Future<void> _clearCache() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('cachedDeliveryList'); // Clear cache
//     print("Cache cleared for testing.");
//   }

// // @override
// // void initState() {
// //   super.initState();
// //   _loadInitialData();

// //   _scrollController.addListener(() {
// //     // Load more data when user scrolls to the bottom
// //     if (_scrollController.position.pixels >=
// //             _scrollController.position.maxScrollExtent - 50 &&
// //         !_isLoading) {
// //       _loadMoreData();
// //     }

// //     // Load new data when user scrolls to the top
// //     if (_scrollController.position.pixels <= 50 && !_isLoading) {
// //       _refreshFromTop();
// //     }
// //   });
// // }




// @override
// void initState() {
//   super.initState();

//   _loadInitialData();

//   _scrollController.addListener(() {
//     // Check if user has scrolled to the bottom for pagination
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 50 &&
//         !_isLoading) {
//       _loadMoreData(); // Load the next page
//     }
//   });
// }





// // Future<void> _refreshFromTop() async {
// //   if (_isLoading) return; // Prevent multiple calls

// //   print("Refreshing data from the top...");
// //   setState(() => _isLoading = true); // Show loading indicator

// //   try {
// //     // Clear the cache
// //     await _clearCache();

// //     // Fetch new data from the server
// //     _page = 1; // Reset to the first page
// //     List<dynamic> newData = await fetchData(_page);

// //     if (newData.isNotEmpty) {
// //       setState(() {
// //         _deliveryList = newData; // Replace current data with new data
// //       });

// //       // Cache the new data
// //       await _cacheData();
// //     } else {
// //       print("No new data available.");
// //     }
// //   } catch (e) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text("Error refreshing data: $e")),
// //     );
// //     print("Error refreshing data: $e");
// //   } finally {
// //     setState(() => _isLoading = false); // Hide loading indicator
// //   }
// // }



// Future<void> _refreshFromTop() async {
//   setState(() => _isLoading = true); // Show loading indicator
//   try {
//     _page = 1; // Reset to the first page
//     List<dynamic> newData = await fetchData(_page);
//     setState(() {
//       _deliveryList = newData; // Replace old data with the new data
//     });
//     await _cacheData(); // Update the cache
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error refreshing data: $e")),
//     );
//   } finally {
//     setState(() => _isLoading = false); // Hide loading indicator
//   }
// }



//   Future<void> _loadInitialData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String cachedData = prefs.getString('cachedDeliveryList');

//     if (cachedData != null && cachedData.isNotEmpty) {
//       //  await _loadMoreData();
//       print("Cache data is present *************");
//       setState(() {
//         _deliveryList = List<dynamic>.from(json.decode(cachedData));
//       });
//     } else {
//       print("No cache data is present *************");
//       await _loadMoreData(); // Load from server if no cached data
//     }
//   }

//   Future<void> _cacheData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('cachedDeliveryList', json.encode(_deliveryList));
//     print("Data cached successfully.");
//   }

// //   Future<void> _loadMoreData() async {
// //     if (_isLoading) return; // Prevent multiple calls

// //     setState(() => _isLoading = true);

// //     try {
// //       List<dynamic> newData = await fetchData(_page);

// //       if (newData.isNotEmpty) {
// //         setState(() {
// //           _deliveryList.addAll(newData);
// //           _page++;
// //         });

// //         // Cache the updated data
// //         await _cacheData();
// //       } else {
// //         print("No more data available."); // No further API calls
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //        // SnackBar(content: Text("Error loading data: $e")),
// //        SnackBar(
// //   content: Text("Session Expired. Please log in again"),
// // )
// //       );
// //       print("Error loading data: $e");
// //     } finally {
// //       setState(() => _isLoading = false);
// //     }
// //   }



// Future<void> _loadMoreData() async {
//   if (_isLoading) return; // Prevent multiple calls

//   setState(() => _isLoading = true); // Show loading spinner

//   try {
//     List<dynamic> newData = await fetchData(_page);

//     if (newData.isNotEmpty) {
//       setState(() {
//         _deliveryList.addAll(newData); // Append new data
//         _page++; // Increment the page number
//       });
//       await _cacheData(); // Cache the updated data
//     } else {
//       print("No more data available.");
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error loading more data: $e")),
//     );
//   } finally {
//     setState(() => _isLoading = false); // Hide loading spinner
//   }
// }




//   // Function to fetch new data
//   Future<void> _loadNewData() async {
//     setState(() => _isLoading = true); // Show loading indicator
//     try {
//       _page = 1; // Reset to first page
//       List<dynamic> newData = await fetchData(_page);
//       setState(() {
//         _deliveryList = newData; // Replace current data with new data
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error refreshing data: $e")),
//       );
//     } finally {
//       setState(() => _isLoading = false); // Hide loading indicator
//     }
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     drawer: MyDrawer(),
//   //     appBar: AppBar(
//   //       title: Text(
//   //         "Delivered",
//   //         style: TextStyle(color: Colors.red),
//   //       ),
//   //       backgroundColor: Colors.white,
//   //       elevation: 1,
//   //       centerTitle: true,
//   //       leading: Builder(
//   //         builder: (context) => IconButton(
//   //           icon: Icon(Icons.menu, color: Colors.black),
//   //           onPressed: () {
//   //             Scaffold.of(context).openDrawer();
//   //           },
//   //         ),
//   //       ),
//   //     ),
//   //     body: RefreshIndicator(
//   //       // onRefresh: () async {
//   //       //   // Fetch new data when user pulls down to refresh
//   //       //   await _loadNewData();
//   //       // },

//   //        onRefresh: _refreshFromTop,
//   //       child: Scaffold(
//   //         floatingActionButton: FloatingActionButton(
//   //           onPressed: () {
//   //             // Scroll to top with an animation
//   //             _scrollController.animateTo(
//   //               0.0,
//   //               duration: Duration(milliseconds: 500),
//   //               curve: Curves.easeInOut,
//   //             );
//   //           },
//   //           child: Icon(Icons.arrow_upward),
//   //         ),
//   //         body: SingleChildScrollView(
//   //           controller: _scrollController, // Attach the scroll controller
//   //           child: Column(
//   //             children: [
//   //               ListView.builder(
//   //                  controller: _scrollController,
//   //                 shrinkWrap: true,
//   //                 physics:
//   //                     NeverScrollableScrollPhysics(), // Disable internal scrolling
//   //                 itemCount: _deliveryList.length + (_isLoading ? 1 : 0),
//   //                 itemBuilder: (context, index) {
//   //                   if (index == _deliveryList.length) {
//   //                     return Center(child: CircularProgressIndicator());
//   //                   }
//   //                   final item = _deliveryList[index];
//   //                   return Padding(
//   //                     padding: const EdgeInsets.all(8.0),
//   //                     child: buildDeliveryContainer(item, context),
//   //                   );
//   //                 },
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }


// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     drawer: MyDrawer(),
//     appBar: AppBar(
//       title: Text(
//         "Delivered",
//         style: TextStyle(color: Colors.red),
//       ),
//       backgroundColor: Colors.white,
//       elevation: 1,
//       centerTitle: true,
//       leading: Builder(
//         builder: (context) => IconButton(
//           icon: Icon(Icons.menu, color: Colors.black),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//         ),
//       ),
//     ),
//     body: RefreshIndicator(
//       onRefresh: _refreshFromTop, // Refresh when pulling down
//       child: ListView.builder(
//         controller: _scrollController, // Attach the scroll controller
//         itemCount: _deliveryList.length + (_isLoading ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == _deliveryList.length) {
//             return _isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : SizedBox.shrink();
//           }
//           final item = _deliveryList[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: buildDeliveryContainer(item, context),
//           );
//         },
//       ),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {
//         // Scroll to the top
//         _scrollController.animateTo(
//           0.0,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       },
//       child: Icon(Icons.arrow_upward),
//     ),
//   );
// }


//   Widget buildDeliveryContainer(
//       Map<String, dynamic> detail, BuildContext context) {
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
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           // Icon button with a tick icon
//           IconButton(
//             icon: Icon(
//               Icons.check_circle,
//               color: Colors.orange,
//               size: 30,
//             ),
//             onPressed: () {
//               // Add functionality if needed when the tick icon is pressed
//               print('Order ${detail['orderId']} completed!');
//             },
//           ),
//           // Column for Order ID and Address
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Order ID
//               Text(
//                 "Order ID: ${detail["tracking_code"] ?? 'Unknown Order'}",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               // Address
//               SizedBox(height: 4),

//               Container(
//                 width: 220,
//                 child: Text(
//                   detail["receiver_address"] ?? 'Unknown Receiver',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.blue,
//                   ),
//                   softWrap: true, // Enable soft wrapping
//                   maxLines: 2, // Allow up to 2 lines
//                   overflow: TextOverflow
//                       .ellipsis, // Add ellipsis (...) if text overflows
//                 ),
//               ),
//             ],
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.remove_red_eye,
//               color: Colors.red,
//               size: 30,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       PackageDetailScreen(code: detail["tracking_code"]),
//                 ),
//               );
//             },
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
//     String monthYear = DateFormat('MMM yyyy')
//         .format(parsedDate); // Use 'MMM' for abbreviated month
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



class DynamicListScreenDelivered extends StatefulWidget {
  @override
  _DynamicListScreenDeliveredState createState() => _DynamicListScreenDeliveredState();
}

class _DynamicListScreenDeliveredState extends State<DynamicListScreenDelivered> {
  final Dio dio = Dio();
  ScrollController _scrollController = ScrollController();
  List<dynamic> _deliveryList = [];
  bool _isLoading = false;
  int _page = 1;
  bool isLoggingOut = false;
    bool _hasMoreData = true; // Add a flag to indicate more data 


  Future<List<dynamic>> fetchDataFromCache() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String cachedData = prefs.getString('cacheddelivered');
  if (cachedData != null) {
    return json.decode(cachedData) as List<dynamic>;
  }
  return [];
}

Future<void> saveDataToCache(List<dynamic> data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Clear the previous cache before saving new data
  await prefs.remove('cacheddelivered');
  // Save the new data to the cache
  await prefs.setString('cacheddelivered', json.encode(data));
}

Future<void> _loadInitialData() async {
  // Load data from cache first
  List<dynamic> cachedData = await fetchDataFromCache();
  if (cachedData.isNotEmpty) {
    setState(() {
      _deliveryList = cachedData;
    });
  }

  // Load data from server
  await _loadMoreData();
}

Future<void> _loadMoreData() async {
  if (_isLoading || !_hasMoreData) return;

  setState(() => _isLoading = true);

  try {
    List<dynamic> newData = await fetchData(_page);

    if (newData.length < 20) {
      setState(() => _hasMoreData = false);
    }

    if (newData.isNotEmpty) {
      setState(() {
        if (_page == 1) {
          // Replace the current list with new data for the first page
          _deliveryList = newData;
        } else {
          // Append new data to the list for subsequent pages
          _deliveryList.addAll(newData);
        }
        _page++;
      });
      // Save the updated data to the cache
      await saveDataToCache(_deliveryList);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("session expired please log in again.")),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}

Future<void> _loadNewData() async {
  setState(() => _isLoading = true);

  try {
    _page = 1; // Reset to the first page
    List<dynamic> newData = await fetchData(_page);
    setState(() {
      _deliveryList = newData;
      _hasMoreData = true; // Reset the flag
    });
    // Save the refreshed data to the cache
    await saveDataToCache(_deliveryList);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error refreshing data: $e")),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}


  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");

    await prefs.remove('cacheddelivered'); // Clear delivery cache
    print("User logged out. Cache cleared.");
    // Navigate to login screen
  }

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
        queryParameters: {'status': 'delivered', 'page': page},
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 50 &&
          !_isLoading) {
        _loadMoreData();
      }
    });
  }

  

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   void _showConfirmationDialog(String message) {
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
  //                         onTap: () async {
  //                           setState(() {
  //                             isLoggingOut = true; // Show loading indicator.
  //                           });
  //                           await _logout(); // Perform logout logic.
  //                           setState(() {
  //                             isLoggingOut = false; // Hide loading indicator.
  //                           });
  //                           Navigator.pushAndRemoveUntil(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) => LoginScreen()),
  //                             (Route<dynamic> route) => false,
  //                           );
  //                         },
  //                         child: Container(
  //                           height: 50,
  //                           width: 100,
  //                           padding: EdgeInsets.all(16),
  //                           child: Text(
  //                             "OK",
  //                             style: TextStyle(
  //                               color: MyColors.primaryColor,
  //                               fontFamily: "roboto",
  //                               fontWeight: FontWeight.w700,
  //                             ),
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ));
  //       },
  //     );
  //   }

  //   return Scaffold(
  //     drawer: MyDrawer(),
  //     appBar: AppBar(
  //       title: Text(
  //         "Home",
  //         style: TextStyle(color: Colors.red),
  //       ),
  //       backgroundColor: Colors.white,
  //       elevation: 1,
  //       centerTitle: true,
  //       leading: Builder(
  //         builder: (context) => IconButton(
  //           icon: Icon(Icons.menu, color: Colors.black),
  //           onPressed: () {
  //             Scaffold.of(context).openDrawer();
  //           },
  //         ),
  //       ),
  //     ),
  //     body: RefreshIndicator(
  //       onRefresh: () async {
  //         // Fetch new data when user pulls down to refresh
  //         await _loadNewData();
  //       },
  //       child: Scaffold(
  //         floatingActionButton: FloatingActionButton(
  //           onPressed: () {
  //             // Scroll to top with an animation
  //             _scrollController.animateTo(
  //               0.0,
  //               duration: Duration(milliseconds: 500),
  //               curve: Curves.easeInOut,
  //             );
  //           },
  //           child: Icon(Icons.arrow_upward),
  //         ),
  //         body: SingleChildScrollView(
  //           controller: _scrollController, // Attach the scroll controller
  //           child: Column(
  //             children: [
  //               ListView.builder(
  //                 shrinkWrap: true,
  //                 physics:
  //                     NeverScrollableScrollPhysics(), // Disable internal scrolling
  //                 itemCount: _deliveryList.length + (_isLoading ? 1 : 0),
  //                 itemBuilder: (context, index) {
  //                   if (index == _deliveryList.length) {
  //                     return Center(child: CircularProgressIndicator());
  //                   }
  //                   final item = _deliveryList[index];
  //                   return Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: buildDeliveryContainer(item, context),
  //                   );
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Delivered",
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
          await _loadNewData();
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Icon(Icons.arrow_upward),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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




  Widget buildDeliveryContainer(Map<String, dynamic> detail, BuildContext context) {
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.yellow,
              size: 30,
            ),
            onPressed: () {
              print('Order ${detail['orderId']} completed!');
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order ID: ${detail["tracking_code"] ?? 'Unknown Order'}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Container(
                width: 220,
                child: Text(
                  detail["receiver_address"] ?? 'Unknown Receiver',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.red,
              size: 30,
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


















