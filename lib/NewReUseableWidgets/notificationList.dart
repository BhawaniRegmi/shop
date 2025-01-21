// import 'package:flutter/material.dart';
// import 'package:logistics/utils/color.dart';

// class NotificationScreen extends StatefulWidget {
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   final List<Map<String, String>> notifications = [
//     {
//       "title": "New Comment Received For D-038391",
//       "date": "Sep 05 2022",
//       "time": "14:35 PM"
//     },
//     {
//       "title": "New Comment Received For D-037770",
//       "date": "Sep 02 2022",
//       "time": "18:11 PM"
//     },
//     {
//       "title": "New Comment Received For D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },
//     {
//       "title": "New Comment Received For D-036126",
//       "date": "Aug 18 2022",
//       "time": "13:36 PM"
//     },
//     {
//       "title": "New Comment Received For D-036126",
//       "date": "Aug 17 2022",
//       "time": "17:45 PM"
//     },
//     {
//       "title": "New Comment Received For D-020369",
//       "date": "May 08 2022",
//       "time": "15:23 PM"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {

//         void _addReplyDialog(BuildContext context) {
//     final TextEditingController commentController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Reply"),
//           content: TextField(
//           controller: commentController,
//           decoration: InputDecoration(
//             hintText: "Enter your Reply",
//             border: OutlineInputBorder(),
//           ),
//           maxLines: 3, // Allows the TextField to grow as needed for multiline input
//         ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Send"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//  void _opentab() {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//          // title: Text("        For D-038391"),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//                Text("Notification Deatail",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//                SizedBox(height: 7.2,),
//                Text("For D-038391",),
//               // SizedBox(height: 7.2,),
//               Text("Product Out of Stock"),
//               //SizedBox(height: 10),
//               Text(
//                 "Aug 18 2024 ",
//                // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
//               ),
//               Text(
//                 "15:23 PM",
//                // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Close"),
//             ),
//               TextButton(
//               onPressed: () {
//                _addReplyDialog(context);
//               },
//               child: Text("Reply"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//     // Convert List<Map<String, String>> to List<Widget>
//     List<Widget> notificationWidgets = notifications.map((notification) {
//       return MaterialButton(onPressed: (){_opentab();},
//         child: Card(
//           elevation: 2,
//           margin: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 1.8),
//           child: ListTile(
//             title: Text(
//               notification["title"] ?? "",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text("Comment"),
//             trailing: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(notification["date"] ?? ""),
//                 SizedBox(height: 4),
//                 Text(notification["time"] ?? ""),
//               ],
//             ),
//           ),
//         ),
//       );
//     }).toList();

//     return 
//     SingleChildScrollView(
//         padding: const EdgeInsets.all(.3),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children:notificationWidgets
         
//             ));
//   }
// }














// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/utils/color.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../edit/packageedit/package_edit_presenter.dart';
// import '../packagedetailpage/package_detail_screen.dart';

// class NotificationScreen extends StatefulWidget {
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   EditPackageScreenContract _view;
//   final Dio dio = Dio();
//   final ScrollController _scrollController = ScrollController();
//   List<dynamic> _deliveryList = [];
//   bool _isLoading = false;
//   int _page = 1; // Start with page 1

//   Future<List<dynamic>> fetchData(int page) async {
//     BaseOptions options = BaseOptions(
//       baseUrl: 'https://dashlogistics.dev/api/v1/employee/notificationData',
//       connectTimeout: Duration(milliseconds: 30000),
//       receiveTimeout: Duration(milliseconds: 30000),
//       validateStatus: (status) => status < 500,
//     );

//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String token = prefs.getString('token') ?? '';

//     dio.options.headers["Authorization"] = "Bearer $token";

//     try {
//       final response = await dio.get(
//         'https://dashlogistics.dev/api/v1/employee/notificationData',
//         queryParameters: {'page': page}, // Pass the page number
//       );

//       if (response.statusCode == 200) {
//         return response.data['data']; // Return the 'data' array
//       }
//       //    else {
//       //     throw Exception('Failed to load data');
//       //   }
//       // } catch (e) {
//       //   throw Exception('Error: $e');
//       // }
//       else {
//         _view.onError("Something Went Wrong");
//       }
//     } catch (e) {
//       _view.onError("Something Went Wrong");
//     }
//   }
//   Future<void> _clearCache() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove('cachedDeliveryList'); // Clear cache
//   print("Cache cleared for testing.");
// }

//   @override
//   void initState() {
//     super.initState();
//    // _clearCache();
//        _loadInitialData();
//    // _loadMoreData();

//     _scrollController.addListener(() {
//       print("5st***************");
//       // if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
//       //   print("Fetching more data...");
//       //   _loadMoreData();
//       // }
//       if (_scrollController.position.pixels >=
//               _scrollController.position.maxScrollExtent - 50 &&
//           !_isLoading) {
//         print("1st***************");
//          _loadMoreData();
//       }
//     });
//   }
//   Future<void> _loadInitialData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String cachedData = prefs.getString('cachedDeliveryList');
  
//   if (cachedData != null && cachedData.isNotEmpty) {
//      await _loadMoreData();
//     print("Cache data is present *************");
//     setState(() {
//       _deliveryList = List<dynamic>.from(json.decode(cachedData));
//     });
//   } else {
//     print("No cache data is present *************");
//     await _loadMoreData(); // Load from server if no cached data
//   }
// }




//   Future<void> _cacheData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('cachedDeliveryList', json.encode(_deliveryList));
//   print("Data cached successfully.");
// }

// Future<void> _loadMoreData() async {
//   if (_isLoading) return; // Prevent multiple calls

//   setState(() => _isLoading = true);

//   try {
//     List<dynamic> newData = await fetchData(_page);

//     if (newData.isNotEmpty) {
//       setState(() {
//         _deliveryList.addAll(newData);
//         _page++;
//       });

//       // Cache the updated data
//       await _cacheData();
//     } else {
//       print("No more data available."); // No further API calls
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error loading data: $e")),
//     );
//   } finally {
//     setState(() => _isLoading = false);
//   }
// }


//   // Function to fetch new data
// Future<void> _loadNewData() async {
//   setState(() => _isLoading = true); // Show loading indicator
//   try {
//     _page = 1; // Reset to first page
//     List<dynamic> newData = await fetchData(_page);
//     setState(() {
//       _deliveryList = newData; // Replace current data with new data
//     });
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error refreshing data: $e")),
//     );
//   } finally {
//     setState(() => _isLoading = false); // Hide loading indicator
//   }
// }

//   @override
// Widget build(BuildContext context) {
//   return RefreshIndicator(
//     onRefresh: () async {
//       // Fetch new data when user pulls down to refresh
//       await _loadNewData();
//     },
//     child: Scaffold(
//       floatingActionButton:     FloatingActionButton(
//         onPressed: () {
      
//         // Scroll to top with an animation
//                     _scrollController.animateTo(
//                       0.0,
//                       duration: Duration(milliseconds: 500),
//                       curve: Curves.easeInOut,
//                     );
//         },
//         child: Icon(Icons.arrow_upward),
//       ),
//       body: SingleChildScrollView(
//         controller: _scrollController, // Attach the scroll controller
//         child: Column(
//           children: [
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
//               itemCount: _deliveryList.length + (_isLoading ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index == _deliveryList.length) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 final item = _deliveryList[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: buildDeliveryContainer(item, context),
//                 );
//               },
//             ),               
//           ],
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
//             print('Order ${detail['id']} completed!');
//           },
//         ),
//         // Column for Order ID and Address
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
      
//             // Order ID
//             Text(
//               "Order ID: ${detail["order_id"] ?? 'Unknown Order'}",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             // Address
//             SizedBox(height: 4),
//             // Text(
//             //   detail["receiver_address"] ?? 'Unknown Address',
//             //   style: TextStyle(
//             //     fontSize: 14,
//             //     color: Colors.grey,
//             //   ),
//             // ),
//             Container(width: 220,
//                     child: Text(
//                       detail["comment"] ?? 'Unknown Receiver',
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










// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class NotificationScreen extends StatefulWidget {
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   List<dynamic> notifications = [];
//   bool isLoading = false;
//   bool isFetchingMore = false;
//   int currentPage = 1;
//   int totalPages = 1;
//   ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     fetchNotifications();
//     _scrollController.addListener(_handleScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   Future<void> fetchNotifications({bool isPagination = false}) async {
//     if (isLoading || isFetchingMore) return;

//     setState(() {
//       if (isPagination) {
//         isFetchingMore = true;
//       } else {
//         isLoading = true;
//       }
//     });

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String token = prefs.getString('token') ?? '';

//       Dio dio = Dio(BaseOptions(
//         baseUrl: 'https://dashlogistics.dev/api/v1/',
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//         connectTimeout: Duration(milliseconds: 30000),
//         receiveTimeout: Duration(milliseconds: 30000),
//       ));

//       final response = await dio.get('employee/notificationData', queryParameters: {
//         'page': currentPage,
//       });

//       if (response.statusCode == 200) {
//         final meta = response.data['meta']['pagination'];
//         final List<dynamic> newNotifications = response.data['data'];

//         setState(() {
//           notifications.addAll(newNotifications);
//           totalPages = meta['total_pages'];
//           currentPage += 1;
//         });
//       } else {
//         showError("Failed to load notifications.");
//       }
//     } catch (e) {
//       showError("An error occurred while fetching data.");
//     } finally {
//       setState(() {
//         isLoading = false;
//         isFetchingMore = false;
//       });
//     }
//   }

//   void showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   void _handleScroll() {
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 200 &&
//         currentPage <= totalPages) {
//       fetchNotifications(isPagination: true);
//     }
//   }

//   void _scrollToTop() {
//     _scrollController.animateTo(
//       0,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//         backgroundColor: Colors.red,
//       ),
//       body: isLoading && notifications.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : RefreshIndicator(
//               onRefresh: () async {
//                 setState(() {
//                   notifications.clear();
//                   currentPage = 1;
//                 });
//                 await fetchNotifications();
//               },
//               child: ListView.builder(
//                 controller: _scrollController,
//                 itemCount: notifications.length + (isFetchingMore ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index == notifications.length) {
//                     return Center(child: CircularProgressIndicator());
//                   }

//                   final notification = notifications[index];
//                   return Card(
//                     elevation: 2,
//                     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     child: ListTile(
//                       title: Text(
//                         notification['title'] ?? "",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(notification['comment'] ?? ""),
//                       trailing: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(notification['created_at'] ?? ""),
//                         ],
//                       ),
//                       onTap: () => _showNotificationDetails(notification),
//                     ),
//                   );
//                 },
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _scrollToTop,
//         child: Icon(Icons.arrow_upward),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void _showNotificationDetails(dynamic notification) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Notification Details"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Title: ${notification['title'] ?? ''}"),
//               SizedBox(height: 8),
//               Text("Comment: ${notification['comment'] ?? ''}"),
//               SizedBox(height: 8),
//               Text("Date: ${notification['created_at'] ?? ''}"),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logistics/Drawer/drawer.dart';
import 'package:logistics/Drawer/privacyPolicy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../login/login_screen.dart';
import '../newChange/aboutUs.dart';
import '../newChange/rateApp.dart';
import '../newChange/riderDetailsScreen.dart';
import '../newChange/sidebarNotification.dart';
import '../utils/color.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> notifications = [];
  bool isLoading = false;
  bool isFetchingMore = false;
  int currentPage = 1;
  int totalPages = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadCachedNotifications();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

    void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");

   
  await prefs.remove('cachedDeliveryList'); // Clear delivery cache
  print("User logged out. Cache cleared.");
  // Navigate to login screen
    
  }

  Future<void> loadCachedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedData = prefs.getString('cached_notifications');
    if (cachedData != null) {
      List<dynamic> cachedNotifications = json.decode(cachedData);
      setState(() {
        notifications = cachedNotifications;
      });
    } else {
      fetchNotifications();
    }
  }

  Future<void> fetchNotifications({bool isPagination = false}) async {
    if (isLoading || isFetchingMore) return;

    setState(() {
      if (isPagination) {
        isFetchingMore = true;
      } else {
        isLoading = true;
      }
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      Dio dio = Dio(BaseOptions(
        baseUrl: 'https://dashlogistics.dev/api/v1/',
        headers: {
          'Authorization': 'Bearer $token',
        },
        connectTimeout: Duration(milliseconds: 30000),
        receiveTimeout: Duration(milliseconds: 30000),
      ));

      final response = await dio.get('employee/notificationData', queryParameters: {
        'page': currentPage,
      });

      if (response.statusCode == 200) {
        final meta = response.data['meta']['pagination'];
        final List<dynamic> newNotifications = response.data['data'];

        setState(() {
          if (isPagination) {
            notifications.addAll(newNotifications);
          } else {
            notifications = newNotifications;
          }
          totalPages = meta['total_pages'];
          currentPage += 1;
        });

        prefs.setString('cached_notifications', json.encode(notifications));
      } else {
        showError("Failed to load notifications.");
      }
    } catch (e) {
      showError("An error occurred while fetching data.");
    } finally {
      setState(() {
        isLoading = false;
        isFetchingMore = false;
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        currentPage <= totalPages) {
      fetchNotifications(isPagination: true);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: MyDrawer(),

          appBar: AppBar(
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Stack(
        //       children: [
        //         Icon(Icons.notifications, color: Colors.black),
        //       ],
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
     
      body: isLoading && notifications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  notifications.clear();
                  currentPage = 1;
                });
                await fetchNotifications();
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: notifications.length + (isFetchingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == notifications.length) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final notification = notifications[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Text(
                        notification['title'] ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(notification['comment'] ?? ""),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(notification['created_at'] ?? ""),
                        ],
                      ),
                      onTap: () => _showNotificationDetails(notification),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: Icon(Icons.arrow_upward),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showNotificationDetails(dynamic notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Notification Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title: ${notification['title'] ?? ''}"),
              SizedBox(height: 8),
              Text("Comment: ${notification['comment'] ?? ''}"),
              SizedBox(height: 8),
              Text("Date: ${notification['created_at'] ?? ''}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
