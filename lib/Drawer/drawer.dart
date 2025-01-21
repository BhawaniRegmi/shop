import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logistics/Drawer/contactDetails.dart';
import 'package:logistics/Drawer/privacyPolicy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';
import '../newChange/aboutUs.dart';
import '../newChange/rateApp.dart';
import '../newChange/riderDetailsScreen.dart';
import '../newChange/sidebarNotification.dart';
import '../utils/color.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String name = ''; // Default value
  String phoneNumber = ''; // Default value

  @override
  void initState() {
    super.initState();
    _loadRiderDetails();
  }

  // Future<void> _loadRiderDetails() async {
  //   try {
  //     final riderDetails = await fetchRiderDetails();
  //     setState(() {
  //       name = riderDetails['data']['fullName'] ?? 'Unknown Name';
  //       phoneNumber =
  //           riderDetails['data']['phoneNumber'] ?? 'Unknown Phone Number';
  //     });
  //   } catch (error) {
  //     debugPrint('Error fetching rider details: $error');
  //   }
  // }


  Future<void> _loadRiderDetails() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String cachedData = prefs.getString('riderDetails');

  if (cachedData != null) {
    // Load cached data
    final cachedRiderDetails = Map<String, dynamic>.from(
      jsonDecode(cachedData),
    );
    setState(() {
      name = cachedRiderDetails['fullName'] ?? 'Unknown Name';
      phoneNumber = cachedRiderDetails['phoneNumber'] ?? 'Unknown Phone Number';
    });
    debugPrint('Loaded data from cache');
  } else {
    // Fetch data from the server if no cache exists
    await _fetchAndCacheRiderDetails();
  }
}

Future<void> _fetchAndCacheRiderDetails() async {
  try {
    final riderDetails = await fetchRiderDetails();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Cache the response
    await prefs.setString('riderDetails', jsonEncode(riderDetails['data']));

    // Update the UI
    setState(() {
      name = riderDetails['data']['fullName'] ?? 'Unknown Name';
      phoneNumber =
          riderDetails['data']['phoneNumber'] ?? 'Unknown Phone Number';
    });

    debugPrint('Data fetched from server and cached');
  } catch (error) {
    debugPrint('Error fetching rider details: $error');
    // Optionally, show an error message to the user
  }
}


  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");

    await prefs.remove('cachedDeliveryList'); // Clear delivery cache
    print("User logged out. Cache cleared.");
    // Navigate to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.red, // Background color for the header
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30, // Adjust the size of the profile picture
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(width: 16), // Space between image and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: $name', // Updated with fetched name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Mobile: $phoneNumber', // Updated with fetched phone number
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    // Navigate to Profile screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RiderDetailsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    // Navigate to Settings screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RateAppScreen()),
                    );
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.notifications),
                //   title: Text('Notification'),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => SideBarNotificationScreen()),
                //     );
                //     // Navigate to Notification screen
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About Us'),
                  onTap: () {
                    // Navigate to About Us screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.description),
                  title: Text('Terms and Condition'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen()),
                    );
                    // Navigate to Notification screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shield),
                  title: Text('Privacy Policy'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen()),
                    );
                    // Navigate to Notification screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Contact Details'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactDetailsScreen()),
                    );
                    // Navigate to Notification screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                  onTap: () {
                    // Handle Log Out
                    _showConfirmationDialog("Are you sure you want to logout?");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> fetchRiderDetails() async {
    final Dio dio = Dio();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';

    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
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
}
