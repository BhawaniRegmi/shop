// import 'package:flutter/material.dart';
// class RescheduledListScreen extends StatelessWidget {
//   final List<Map<String, String>> deliveredOrders = [
//     {"orderId": "R-123456", "address": "New Baneshwor, Kathmandu"},
//     {"orderId": "R-654321", "address": "Pulchowk, Lalitpur"},
//     {"orderId": "R-789012", "address": "Boudhanath, Kathmandu"},
//     {"orderId": "R-345678", "address": "Koteshwor, Kathmandu"},
//     {"orderId": "R-901234", "address": "Satdobato, Lalitpur"},
//     {"orderId": "R-567890", "address": "Kalanki, Kathmandu"},
//     {"orderId": "R-876543", "address": "Kumaripati, Lalitpur"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(2.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: deliveredOrders.map((order) {
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 4.0),
//             child: ListTile(
//               leading: Icon(Icons.check_circle, color: Colors.blue), // Changed to blue
//               title: Text(
//                 "Order Id: ${order['orderId']}",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(order['address'] ?? ""),
//               trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
//               onTap: () {
//                 // Add functionality to open details or perform actions
//               },
//             ),
//           );
//         }).toList(), // Convert to a List<Widget>
//       ),
//     );
//   }
// }







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


// class DynamicListScreennew extends StatefulWidget {
//   @override
//   DynamicListScreennewState createState() => DynamicListScreennewState();
// }

// class DynamicListScreennewState extends State<DynamicListScreennew> {
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
//         queryParameters: {'status': 'rescheduled', 'page': page},
//       );

//       if (response.statusCode == 200) {
//         return response.data['data'];
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
//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     drawer: MyDrawer(),
//         appBar: AppBar(
//         title: Text(
//           "Reschedule",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
     
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//       ),
//     body: RefreshIndicator(
//       onRefresh: () async {
//         // Fetch new data when user pulls down to refresh
//         await _loadNewData();
//       },
//       child: Scaffold(
//         floatingActionButton:     FloatingActionButton(
//           onPressed: () {
        
//           // Scroll to top with an animation
//                       _scrollController.animateTo(
//                         0.0,
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.easeInOut,
//                       );
//           },
//           child: Icon(Icons.arrow_upward),
//         ),
//         body: SingleChildScrollView(
//           controller: _scrollController, // Attach the scroll controller
//           child: Column(
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
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



// Widget buildDeliveryContainer(Map<String, dynamic> detail, BuildContext context) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(15),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black26,
//           blurRadius: 10,
//           offset: Offset(0, 4),
//         ),
//       ],
//     ),
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//                  // Icon button with a tick icon
//         IconButton(
//           icon: Icon(
//             Icons.check_circle,
//             color: Colors.green,
//             size: 30,
//           ),
//           onPressed: () {
//             // Add functionality if needed when the tick icon is pressed
//             print('Order ${detail['orderId']} completed!');
//           },
//         ),
//         // Column for Order ID and Address
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
      
//             // Order ID
//             Text(
//               "Order ID: ${detail["tracking_code"] ?? 'Unknown Order'}",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             // Address
//             SizedBox(height: 4),
     
//             Container(width: 220,
//                     child: Text(
//                       detail["receiver_address"] ?? 'Unknown Receiver',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.blue,
//                       ),
//                       softWrap: true, // Enable soft wrapping
//                       maxLines: 2, // Allow up to 2 lines
//                       overflow: TextOverflow
//                           .ellipsis, // Add ellipsis (...) if text overflows
//                     ),
//                   ),
//           ],
//         ),
//      IconButton(
//                         icon: Icon(
//                           Icons.remove_red_eye,
//                           color: Colors.red,
//                           size: 30,
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PackageDetailScreen(
//                                   code: detail[ "tracking_code"]),
//                             ),
//                           );
//                         },
//                       ),
//       ],
//     ),
//   );
// }

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

// class DynamicListScreennew extends StatefulWidget {
//   @override
//   DynamicListScreennewState createState() => DynamicListScreennewState();
// }

// class DynamicListScreennewState extends State<DynamicListScreennew> {
//   final Dio dio = Dio();
//   final ScrollController _scrollController = ScrollController();
//   List<dynamic> _deliveryList = [];
//   bool _isLoading = false;
//   int _page = 1; // Start with page 1
//   bool _cacheLoaded = false;

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
//         queryParameters: {'status': 'rescheduled', 'page': page},
//       );

//       if (response.statusCode == 200) {
//         return response.data['data'];
//       } else {
//         throw Exception("Failed to load data");
//       }
//     } catch (e) {
//       throw Exception("Error fetching data: $e");
//     }
//   }

//   Future<void> _loadInitialData() async {
//     if (!_cacheLoaded) {
//       await _loadFromCache();
//     }
//     await _loadMoreData();
//   }

//   Future<void> _loadFromCache() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String cachedData = prefs.getString('cachedDeliveryData');

//     if (cachedData != null) {
//       setState(() {
//         _deliveryList = jsonDecode(cachedData);
//       });
//     }

//     _cacheLoaded = true;
//   }

//   Future<void> _saveToCache() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('cachedDeliveryData', jsonEncode(_deliveryList));
//   }

//   Future<void> _clearCache() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('cachedDeliveryData');
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
//         await _saveToCache(); // Update cache with the new data
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
//     setState(() => _isLoading = true);

//     try {
//       _page = 1;
//       List<dynamic> newData = await fetchData(_page);

//       setState(() {
//         _deliveryList = newData;
//       });

//       await _clearCache(); // Clear old cache
//       await _saveToCache(); // Save new data to cache
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error refreshing data: $e")),
//       );
//     } finally {
//       setState(() => _isLoading = false);
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

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         title: Text(
//           "Reschedule",
//           style: TextStyle(color: Colors.red),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
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
//         onRefresh: () async {
//           await _loadNewData();
//         },
//         child: Scaffold(
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               _scrollController.animateTo(
//                 0.0,
//                 duration: Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//             child: Icon(Icons.arrow_upward),
//           ),
//           body: SingleChildScrollView(
//             controller: _scrollController,
//             child: Column(
//               children: [
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: _deliveryList.length + (_isLoading ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     if (index == _deliveryList.length) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                     final item = _deliveryList[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: buildDeliveryContainer(item, context),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

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
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           IconButton(
//             icon: Icon(
//               Icons.check_circle,
//               color: Colors.green,
//               size: 30,
//             ),
//             onPressed: () {
//               print('Order ${detail['orderId']} completed!');
//             },
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Order ID: ${detail["tracking_code"] ?? 'Unknown Order'}",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
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
//                   softWrap: true,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
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
//                   builder: (context) => PackageDetailScreen(
//                       code: detail["tracking_code"]),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
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



class DynamicListScreennew extends StatefulWidget {
  @override
  _DynamicListScreennewState createState() => _DynamicListScreennewState();
}

class _DynamicListScreennewState extends State<DynamicListScreennew> {
  final Dio dio = Dio();
  ScrollController _scrollController = ScrollController();
  List<dynamic> _deliveryList = [];
  bool _isLoading = false;
  int _page = 1;
  bool isLoggingOut = false;
    bool _hasMoreData = true; // Add a flag to indicate more data 


  Future<List<dynamic>> fetchDataFromCache() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String cachedData = prefs.getString('cachedreschedule');
  if (cachedData != null) {
    return json.decode(cachedData) as List<dynamic>;
  }
  return [];
}

Future<void> saveDataToCache(List<dynamic> data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Clear the previous cache before saving new data
  await prefs.remove('cachedcachedreschedule');
  // Save the new data to the cache
  await prefs.setString('cachedcachedreschedule', json.encode(data));
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

    await prefs.remove('cachedOutFordelivery'); // Clear delivery cache
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
        queryParameters: {'status': 'reschedule', 'page': page},
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
          "Reschedule",
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
              color: Colors.green,
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


















