
// code which is working perfectly but need to refresh or logout for replacing cache data
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/Drawer/drawer.dart';
// import 'package:logistics/Drawer/privacyPolicy.dart';
// import 'package:logistics/edit/packageedit/package_edit_presenter.dart';
// import 'package:logistics/newChange/commentList.dart';
// import 'package:logistics/newChange/scrollabletest.dart';

// import 'package:logistics/packagedetailpage/package_detail_screen.dart';
// import 'package:logistics/response/PackageDetailM.dart';
// import 'package:logistics/scan.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:intl/intl.dart';

// import '../login/login_screen.dart';
// import '../newChange/aboutUs.dart';
// import '../newChange/rateApp.dart';
// import '../newChange/riderDetailsScreen.dart';
// import '../newChange/sidebarNotification.dart';
// import '../utils/color.dart';

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
//   ScrollController _scrollController = ScrollController();
//   List<dynamic> _deliveryList = [];
//   bool _isLoading = false;
//   int _page = 1;
//   bool isLoggingOut = false;
//   bool _hasMoreData = true; // Add a flag to indicate more data

//   Future<List<dynamic>> fetchDataFromCache() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String cachedData = prefs.getString('cachedOutFordelivery');
//     if (cachedData != null) {
//       return json.decode(cachedData) as List<dynamic>;
//     }
//     return [];
//   }

//   Future<void> saveDataToCache(List<dynamic> data) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // Clear the previous cache before saving new data
//     await prefs.remove('cachedOutFordelivery');
//     // Save the new data to the cache
//     await prefs.setString('cachedOutFordelivery', json.encode(data));
//   }

//   Future<void> _loadInitialData() async {
//     // Load data from cache first
//     List<dynamic> cachedData = await fetchDataFromCache();
//     if (cachedData.isNotEmpty) {
//       setState(() {
//         _deliveryList = cachedData;
//       });
//     }

//     // Load data from server
//     await _loadMoreData();
//   }

//   Future<void> _loadMoreData() async {
//     if (_isLoading || !_hasMoreData) return;

//     setState(() => _isLoading = true);

//     try {
//       List<dynamic> newData = await fetchData(_page);

//       if (newData.length < 20) {
//         setState(() => _hasMoreData = false);
//       }

//       if (newData.isNotEmpty) {
//         setState(() {
//           if (_page == 1) {
//             // Replace the current list with new data for the first page
//             _deliveryList = newData;
//           } else {
//             // Append new data to the list for subsequent pages
//             _deliveryList.addAll(newData);
//           }
//           _page++;
//         });
//         // Save the updated data to the cache
//         await saveDataToCache(_deliveryList);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         // SnackBar(content: Text("Error loading data: $e")),
//         SnackBar(content: Text("session expired please log in again.")),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _loadNewData() async {
//     setState(() => _isLoading = true);

//     try {
//       _page = 1; // Reset to the first page
//       List<dynamic> newData = await fetchData(_page);
//       setState(() {
//         _deliveryList = newData;
//         _hasMoreData = true; // Reset the flag
//       });
//       // Save the refreshed data to the cache
//       await saveDataToCache(_deliveryList);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error refreshing data: $e")),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _logout() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('token', "");

//     await prefs.remove('cachedOutFordelivery'); // Clear delivery cache
//     print("User logged out. Cache cleared.");
//     // Navigate to login screen
//   }

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
//         queryParameters: {'status': 'outForDelivery', 'page': page},
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

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     void _showConfirmationDialog(String message) {
//       // flutter defined function
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           // return object of type Dialog
//           return AlertDialog(
//               insetPadding: EdgeInsets.all(16),
//               contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               content: Container(
//                 child: new Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(16, 6, 16, 16),
//                       child: Text(
//                         message,
//                         style: TextStyle(
//                             fontFamily: "Roboto",
//                             fontWeight: FontWeight.w700,
//                             color: MyColors.ligtBlack,
//                             fontSize: 16),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Container(
//                       color: MyColors.scanDivider,
//                       height: 1,
//                     ),
//                     new Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                               setState(() {});
//                             },
//                             child: Container(
//                                 height: 50,
//                                 width: 100,
//                                 padding: EdgeInsets.all(16),
//                                 child: new Text(
//                                   "Cancel",
//                                   style: TextStyle(
//                                       color: MyColors.primaryColor,
//                                       fontFamily: "roboto",
//                                       fontWeight: FontWeight.w700),
//                                   textAlign: TextAlign.center,
//                                 ))),
//                         GestureDetector(
//                           onTap: () async {
//                             setState(() {
//                               isLoggingOut = true; // Show loading indicator.
//                             });
//                             await _logout(); // Perform logout logic.
//                             setState(() {
//                               isLoggingOut = false; // Hide loading indicator.
//                             });
//                             Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginScreen()),
//                               (Route<dynamic> route) => false,
//                             );
//                           },
//                           child: Container(
//                             height: 50,
//                             width: 100,
//                             padding: EdgeInsets.all(16),
//                             child: Text(
//                               "OK",
//                               style: TextStyle(
//                                 color: MyColors.primaryColor,
//                                 fontFamily: "roboto",
//                                 fontWeight: FontWeight.w700,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ));
//         },
//       );
//     }

//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         title: Text(
//           "Home",
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
//           // Fetch new data when user pulls down to refresh
//           await _loadNewData();
//         },
//         child: Scaffold(
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               // Scroll to top with an animation
//               _scrollController.animateTo(
//                 0.0,
//                 duration: Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//             child: Icon(Icons.arrow_upward),
//           ),
//           body: SingleChildScrollView(
//             controller: _scrollController, // Attach the scroll controller
//             child: Column(
//               children: [
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics:
//                       NeverScrollableScrollPhysics(), // Disable internal scrolling
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

//   Widget buildDeliveryContainer(
//       Map<String, dynamic> detail, BuildContext context) {
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
//             detail['product_name'] != null && detail['product_name'].length > 20
//                 ? '${detail['product_name'].substring(0, 20)}...'
//                 : detail['product_name'] ?? 'Unknown Product',
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
//               SizedBox(
//                 width: 5,
//               ),
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
//                         detail['initial_package_weight']?.toString() ??
//                             'Unknown Product',
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
//               // SizedBox(
//               //   width: 4,    //9
//               // ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 2),
//                   Container(
//                     width: 125,
//                     child: Text(
//                       detail['receiver_name'] ?? 'Unknown Receiver',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.blue,
//                       ),
//                       softWrap: true, // Enable soft wrapping
//                       maxLines: 2, // Allow up to 2 lines
//                       overflow: TextOverflow
//                           .ellipsis, // Add ellipsis (...) if text overflows
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   Text(
//                     detail["receiver_contact"] ?? 'Unknown Receiver',
//                     style: TextStyle(
//                       color: Colors.blueGrey,
//                       fontSize: 14,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   Container(
//                     width: 125,
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
//                 ],
//               ),
//               // VerticalDivider(
//               //   color: Colors.grey,
//               //   thickness: 1,
//               //   indent: 8,
//               //   endIndent: 8,
//               // ),
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
//                                   code: detail["tracking_code"]),
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
//                         onPressed: () async {
//                           // Show a loading dialog
//                           showDialog(
//                             context: context,
//                             barrierDismissible: false,
//                             builder: (BuildContext context) {
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             },
//                           );

//                           try {
//                             // Simulate data loading or perform an async operation
//                             await Future.delayed(Duration(
//                                 seconds:
//                                     2)); // Replace with actual async data fetch if needed

//                             // Close the loader dialog
//                             Navigator.of(context).pop();

//                             // Navigate to the next screen
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CommentList(
//                                     trackingCode: detail["tracking_code"],
//                                     customerLocation:
//                                         detail["receiver_address"],
//                                     customerName: detail["receiver_name"],
//                                     customerPhone: detail["receiver_contact"]),
//                               ),
//                             );
//                           } catch (e) {
//                             // Close the loader in case of an error
//                             Navigator.of(context).pop();

//                             // Optionally show an error message
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Error: $e')),
//                             );
//                           }
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
//                             // Format the phone number with the 'tel:' scheme
//                             String phoneUrl = 'tel:$phoneNumber';

//                             if (await canLaunch(phoneUrl)) {
//                               await launch(phoneUrl);
//                             } else {
//                               print('Could not launch $phoneUrl');
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





















//new code which is working perfectly with functionality of refreshing in every 15 sec
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/Drawer/drawer.dart';

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
  final Dio dio = Dio();
  ScrollController _scrollController = ScrollController();
  List<dynamic> _deliveryList = [];
  bool _isLoading = false;
  int _page = 1;
  bool isLoggingOut = false;
  bool _hasMoreData = true; // Add a flag to indicate more data
  bool _showScrollToTopButton = false; // Add a flag to show the scroll-to-top button

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _startPeriodicFetch(); // Start periodic fetch

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50 && !_isLoading) {
        _loadMoreData();
      }
      // Update the visibility of the scroll-to-top button
      setState(() {
        _showScrollToTopButton = _scrollController.position.pixels > 0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _stopPeriodicFetch(); // Stop periodic fetch
    super.dispose();
  }

  Future<List<dynamic>> fetchDataFromCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cachedData = prefs.getString('cachedOutFordelivery');
    if (cachedData != null) {
      return json.decode(cachedData) as List<dynamic>;
    }
    return [];
  }

  Future<void> saveDataToCache(List<dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear the previous cache before saving new data
    await prefs.remove('cachedOutFordelivery');
    // Save the new data to the cache
    await prefs.setString('cachedOutFordelivery', json.encode(data));
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
        // SnackBar(content: Text("Error loading data: $e")),
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
        queryParameters: {'status': 'outForDelivery', 'page': page},
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

  Timer _periodicFetchTimer;

  void _startPeriodicFetch() {
    _periodicFetchTimer = Timer.periodic(Duration(seconds: 15), (timer) async {
      await _loadNewData();
    });
  }

  void _stopPeriodicFetch() {
    _periodicFetchTimer?.cancel();
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
          floatingActionButton: _showScrollToTopButton
              ? FloatingActionButton(
                  onPressed: () {
                    // Scroll to top with an animation
                    _scrollController.animateTo(
                      0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(Icons.arrow_upward),
                )
              : null,
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

  Widget buildDeliveryContainer(Map<String, dynamic> detail, BuildContext context) {
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
            detail['product_name'] != null && detail['product_name'].length > 20
                ? '${detail['product_name'].substring(0, 20)}...'
                : detail['product_name'] ?? 'Unknown Product',
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
                        detail['initial_package_weight']?.toString() ?? 'Unknown Product',
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
              // SizedBox(
              //   width: 4,    //9
              // ),
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
                      overflow: TextOverflow.ellipsis, // Add ellipsis (...) if text overflows
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
                      overflow: TextOverflow.ellipsis, // Add ellipsis (...) if text overflows
                    ),
                  ),
                ],
              ),
              // VerticalDivider(
              //   color: Colors.grey,
              //   thickness: 1,
              //   indent: 8,
              //   endIndent: 8,
              // ),
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
                              builder: (context) => PackageDetailScreen(code: detail["tracking_code"]),
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
                                builder: (context) => CommentList(
                                    trackingCode: detail["tracking_code"],
                                    customerLocation: detail["receiver_address"],
                                    customerName: detail["receiver_name"],
                                    customerPhone: detail["receiver_contact"]),
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
    String monthYear = DateFormat('MMM yyyy').format(parsedDate); // Use 'MMM' for abbreviated month
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