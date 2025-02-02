// //code with the change in color after selected
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:logistics/Drawer/drawer.dart';
// import 'package:logistics/Drawer/privacyPolicy.dart';
// import 'package:logistics/newChange/commentList.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../login/login_screen.dart';
// import '../newChange/aboutUs.dart';
// import '../newChange/rateApp.dart';
// import '../newChange/riderDetailsScreen.dart';
// import '../newChange/sidebarNotification.dart';
// import '../utils/color.dart';

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
//   String trackingCode = "";
//   String customerLocation = "";
//   String customerName = "";
//   String customerPhone = "";

//   @override
//   void initState() {
//     super.initState();
//     loadCachedNotifications();
//     _scrollController.addListener(_handleScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   Future<void> loadCachedNotifications() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String cachedData = prefs.getString('cached_notifications');
//     if (cachedData != null) {
//       List<dynamic> cachedNotifications = json.decode(cachedData);
//       setState(() {
//         notifications = cachedNotifications;
//       });
//     } else {
//       fetchNotifications();
//     }
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

//       final response =
//           await dio.get('employee/notificationData', queryParameters: {
//         'page': currentPage,
//       });

//       if (response.statusCode == 200) {
//         final meta = response.data['meta']['pagination'];
//         final List<dynamic> newNotifications = response.data['data'];

//         setState(() {
//           if (isPagination) {
//             notifications.addAll(newNotifications);
//           } else {
//             notifications = newNotifications;
//           }
//           totalPages = meta['total_pages'];
//           currentPage += 1;
//         });

//         prefs.setString('cached_notifications', json.encode(notifications));
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

//   Future<void> markAsSeen(int index) async {
//     setState(() {
//       notifications[index]['seen'] = true;
//     });

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('cached_notifications', json.encode(notifications));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         title: Text(
//           "Notification",
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
//                   final bool seen = notification['seen'] ?? false;

//                   return Card(
//                     elevation: 2,
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     child: ListTile(
//                       title: Text(
//                         notification['title'] ?? "",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: seen ? Colors.grey : Colors.black, // Change title color based on seen state
//                         ),
//                       ),
//                       subtitle: Text(notification['comment'] ?? ""),
//                       trailing: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(notification['created_at'] ?? ""),
//                         ],
//                       ),
//                       onTap: () {
//                         setState(() {
//                           trackingCode = notification['trackingCode'] ?? ""; // Update trackingCode here
//                         });
//                         markAsSeen(index); // Mark notification as seen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 CommentList(trackingCode: trackingCode),
//                           ),
//                         );
//                       },
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
// }















// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:logistics/Drawer/drawer.dart';
// import 'package:logistics/Drawer/privacyPolicy.dart';
// import 'package:logistics/newChange/commentList.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../login/login_screen.dart';
// import '../newChange/aboutUs.dart';
// import '../newChange/rateApp.dart';
// import '../newChange/riderDetailsScreen.dart';
// import '../newChange/sidebarNotification.dart';
// import '../utils/color.dart';

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
//   int unseenCount = 0; // Variable to keep track of unseen notifications
//   ScrollController _scrollController = ScrollController();
//   String trackingCode = "";
//   String customerLocation = "";
//   String customerName = "";
//   String customerPhone = "";

//   @override
//   void initState() {
//     super.initState();
//     loadCachedNotifications();
//     _scrollController.addListener(_handleScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   Future<void> loadCachedNotifications() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String cachedData = prefs.getString('cached_notifications');
//     if (cachedData != null) {
//       List<dynamic> cachedNotifications = json.decode(cachedData);
//       setState(() {
//         notifications = cachedNotifications;
//         unseenCount = notifications
//             .where((n) => !(n['seen'] ?? false))
//             .length; // Update unseen count
//       });
//     } else {
//       fetchNotifications();
//     }
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

//       final response =
//           await dio.get('employee/notificationData', queryParameters: {
//         'page': currentPage,
//       });

//       if (response.statusCode == 200) {
//         final meta = response.data['meta']['pagination'];
//         final List<dynamic> newNotifications = response.data['data'];

//         setState(() {
//           if (isPagination) {
//             notifications.addAll(newNotifications);
//           } else {
//             notifications = newNotifications;
//           }
//           unseenCount = notifications
//               .where((n) => !(n['seen'] ?? false))
//               .length; // Update unseen count
//           totalPages = meta['total_pages'];
//           currentPage += 1;
//         });

//         prefs.setString('cached_notifications', json.encode(notifications));
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

//   Future<void> markAsSeen(int index) async {
//     setState(() {
//       notifications[index]['seen'] = true;
//       unseenCount = notifications
//           .where((n) => !(n['seen'] ?? false))
//           .length; // Update unseen count
//     });

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('cached_notifications', json.encode(notifications));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         title: Text(
//           "Notification",
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
//         actions: [
//           Builder(
//             builder: (context) => IconButton(
//               icon: Stack(
//                 children: [
//                   Icon(Icons.notifications, color: Colors.black),
//                   if (unseenCount > 0)
//                     Positioned(
//                       right: 0,
//                       child: Container(
//                         padding: EdgeInsets.all(1),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         constraints: BoxConstraints(
//                           minWidth: 12,
//                           minHeight: 12,
//                         ),
//                         child: Text(
//                           '$unseenCount',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 8,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               onPressed: () {
//                 // Optionally, navigate to a notification screen or perform another action
//               },
//             ),
//           ),
//         ],
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
//                   final bool seen = notification['seen'] ?? false;

//                   return Card(
//                     elevation: 2,
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     child: ListTile(
//                       title: Text(
//                         notification['title'] ?? "",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: seen
//                               ? Colors.grey
//                               : Colors
//                                   .black, // Change title color based on seen state
//                         ),
//                       ),
//                       subtitle: Text(notification['comment'] ?? ""),
//                       trailing: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(notification['created_at'] ?? ""),
//                         ],
//                       ),
//                       onTap: () {
//                         setState(() {
//                           trackingCode = notification['trackingCode'] ??
//                               ""; // Update trackingCode here
//                         });
//                         markAsSeen(index); // Mark notification as seen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 CommentList(trackingCode: trackingCode),
//                           ),
//                         );
//                       },
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
// }






















import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logistics/Drawer/drawer.dart';
import 'package:logistics/newChange/commentList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class NotificationScreen extends StatefulWidget {
  final ValueNotifier<int> unseenCountNotifier;

  NotificationScreen({ this.unseenCountNotifier});

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
  Timer _timer;
  String trackingCode = "";

  @override
  void initState() {
    super.initState();
    loadCachedNotifications();
    _scrollController.addListener(_handleScroll);
    // Schedule the GET request to run every minute
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      fetchNotifications();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> loadCachedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedData = prefs.getString('cached_notifications') ?? '';
    if (cachedData.isNotEmpty) {
      List<dynamic> cachedNotifications = json.decode(cachedData);
      setState(() {
        notifications = cachedNotifications;
        widget.unseenCountNotifier.value =
            notifications.where((n) => !(n['seen'] ?? false)).length;
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
          widget.unseenCountNotifier.value =
              notifications.where((n) => !(n['seen'] ?? false)).length;
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
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
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

  Future<void> markAsSeen(int index) async {
    setState(() {
      notifications[index]['seen'] = true;
      widget.unseenCountNotifier.value =
          notifications.where((n) => !(n['seen'] ?? false)).length;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cached_notifications', json.encode(notifications));
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
        actions: [
          Builder(
          builder: (context) => IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications, color: Colors.black),
                ValueListenableBuilder<int>(
                  valueListenable: widget.unseenCountNotifier,
                  builder: (context, unseenCount, child) {
                    return unseenCount > 0
                        ? Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: Text(
                                '$unseenCount',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ],
            ),
            onPressed: () {
              // Optionally, navigate to a notification screen or perform another action
            },
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
                  final bool seen = notification['seen'] ?? false;

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Text(
                        notification['title'] ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: seen ? Colors.grey : Colors.black, // Change title color based on seen state
                        ),
                      ),
                      subtitle: Text(notification['comment'] ?? ""),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(notification['created_at'] ?? ""),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          trackingCode = notification['trackingCode'] ?? ""; // Update trackingCode here
                        });
                        markAsSeen(index); // Mark notification as seen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentList(trackingCode: trackingCode),
                          ),
                        );
                      },
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
}