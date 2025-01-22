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

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/Drawer/drawer.dart';

import 'package:logistics/edit/packageedit/package_edit_presenter.dart';
import 'package:logistics/newChange/commentList.dart';
import 'package:logistics/packagedetailpage/package_detail_screen.dart';
import 'package:logistics/response/PackageDetailM.dart';
import 'package:logistics/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

String formatDate(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);
  String day = DateFormat('d').format(parsedDate);
  String monthYear = DateFormat('MMMM yyyy').format(parsedDate);
  return '$day\n$monthYear';
}

// class DynamicListScreennew extends StatefulWidget {
//   @override
//   DynamicListScreennewState createState() => DynamicListScreennewState();
// }

// class DynamicListScreennewState extends State<DynamicListScreennew> {
//   EditPackageScreenContract _view;
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
//         //queryParameters: {'page': page}, // Pass the page number
//          queryParameters: {'status': 'rescheduled', 'page': page}, // Added status parameter
        
//       );

//       if (response.statusCode == 200) {
//         return response.data['data']; // Return the 'data' array
//       }
  
//       else {
//         _view.onError("Something Went Wrong");
//       }
//     } catch (e) {
//       _view.onError("Something Went Wrong");
//     }
//   }
//   Future<void> _clearCache() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove('cachedRescheduleList'); // Clear cache
//   print("Cache cleared for testing.");
// }

//   @override
//   void initState() {
//     super.initState();
//        _loadInitialData();
  

//     _scrollController.addListener(() {
//       print("5st***************");
     
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
//   String cachedData = prefs.getString('cachedRescheduleList');
  
//   if (cachedData != null && cachedData.isNotEmpty) {
//     // await _loadMoreData();
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
//   await prefs.setString('cachedRescheduleList', json.encode(_deliveryList));
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
//      SnackBar(
//   content: Text("Session Expired. Please log in again"),
//   duration: Duration(seconds: 3), // Set duration here
// )
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



class DynamicListScreennew extends StatefulWidget {
  @override
  DynamicListScreennewState createState() => DynamicListScreennewState();
}

class DynamicListScreennewState extends State<DynamicListScreennew> {
  final Dio dio = Dio();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _deliveryList = [];
  bool _isLoading = false;
  int _page = 1; // Start with page 1

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
        queryParameters: {'status': 'rescheduled', 'page': page},
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

  Future<void> _loadInitialData() async {
    setState(() {
      _deliveryList.clear(); // Clear existing data
    });
    await _loadMoreData(); // Fetch fresh data
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
      } else {
        print("No more data available.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading data: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadNewData() async {
    setState(() => _isLoading = true); // Show loading indicator

    try {
      _page = 1; // Reset to the first page
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
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
     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
                 // Icon button with a tick icon
        IconButton(
          icon: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 30,
          ),
          onPressed: () {
            // Add functionality if needed when the tick icon is pressed
            print('Order ${detail['orderId']} completed!');
          },
        ),
        // Column for Order ID and Address
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            // Order ID
            Text(
              "Order ID: ${detail["tracking_code"] ?? 'Unknown Order'}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            // Address
            SizedBox(height: 4),
     
            Container(width: 220,
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
                                  code: detail[ "tracking_code"]),
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
