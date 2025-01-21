// import 'package:flutter/material.dart';
// import 'package:logistics/NewReUseableWidgets/deliveredLIst.dart';
// import 'package:logistics/NewReUseableWidgets/dispatch.dart';
// import 'package:logistics/NewReUseableWidgets/rescheduleList.dart';
// import 'package:logistics/newChange/rateApp.dart';
// import 'package:logistics/newChange/riderDetailsScreen.dart';
// import 'package:logistics/newChange/sidebarNotification.dart';

// import 'aboutUsScreen.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: NavigationExample(),
//     );
//   }
// }

// class NavigationExample extends StatefulWidget {
//   @override
//   _NavigationExampleState createState() => _NavigationExampleState();
// }

// class _NavigationExampleState extends State<NavigationExample> {
//   int _bottomNavIndex = 0; // Track selected bottom navigation index

//   // Pages for Bottom Navigation
//   final List<Widget> _bottomNavPages = [
//     TopNavigationPage(
//         tabTitles: ['Out for Delivery', 'Reschedule', 'Delivered']),
//     Center(child: Text('Settings Page', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Help Page', style: TextStyle(fontSize: 24))),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Home",
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
//       drawer: Drawer(
//         child: Column(
//           children: [
//             // UserAccountsDrawerHeader(
//             //   currentAccountPicture: CircleAvatar(
//             //     backgroundImage: AssetImage('assets/images/profile.png'), // Replace with your imagefsdf
//             //   ),
//             //   accountName: Text('Your Name'),
//             //   accountEmail: Text('Mobile: +123456789'),
//             //   decoration: BoxDecoration(
//             //     color: Colors.red,
//             //   ),
//             // ),

//             Container(
//               color: Colors.red, // Background color for the header
//               padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30, // Adjust the size of the profile picture
//                     backgroundImage: AssetImage('assets/images/profile.png'),
//                   ),
//                   SizedBox(width: 16), // Space between image and text
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Rohit Sharma',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Mobile: +977-9826478511',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text('Profile'),
//                     onTap: () {
//                       // Navigate to Profile screen
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => RiderDetailsScreen()),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.settings),
//                     title: Text('Settings'),
//                     onTap: () {
//                       // Navigate to Settings screen
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => RateAppScreen()),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.notifications),
//                     title: Text('Notification'),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SideBarNotificationScreen()),
//                       );
//                       // Navigate to Notification screen
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.info),
//                     title: Text('About Us'),
//                     onTap: () {
//                       // Navigate to About Us screen
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => AboutUsScreen()),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.description),
//                     title: Text('Terms and Condition'),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SideBarNotificationScreen()),
//                       );
//                       // Navigate to Notification screen
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.shield),
//                     title: Text('Privacy Policy'),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SideBarNotificationScreen()),
//                       );
//                       // Navigate to Notification screen
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.phone),
//                     title: Text('Contact Us'),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SideBarNotificationScreen()),
//                       );
//                       // Navigate to Notification screen
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.logout),
//                     title: Text('Log Out'),
//                     onTap: () {
//                       // Handle Log Out
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: _bottomNavPages[_bottomNavIndex], // Display selected page
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _bottomNavIndex,
//         onTap: (index) {
//           setState(() {
//             _bottomNavIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.help),
//             label: 'Help',
//           ),
//         ],
//       ),
//     );
//   }
// }




// // class TopNavigationPage extends StatelessWidget {
// //   final List<String> tabTitles;

// //   TopNavigationPage({ this.tabTitles});

// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       length: tabTitles.length,
// //       child: Scaffold(
// //         appBar: AppBar(
// //           bottom: TabBar(
// //             tabs: tabTitles.map((title) {
// //               IconData iconData;

// //               // Choose an appropriate icon for each title
// //               switch (title) {
// //                 case 'Out for Delivery':
// //                   iconData = Icons.delivery_dining;
// //                   break;
// //                 case 'Reschedule':
// //                   iconData = Icons.calendar_today;
// //                   break;
// //                 case 'Delivered':
// //                   iconData = Icons.check_circle;
// //                   break;
// //                 default:
// //                   iconData = Icons.help;
// //               }

// //               return Tab(
// //                 icon: Icon(iconData, size: 20), // Set icon size
// //                 child: Text(
// //                   title,
// //                   style: TextStyle(fontSize: 12), // Smaller font size
// //                   overflow: TextOverflow.ellipsis, // Avoid text clipping
// //                   maxLines: 1, // Single line text
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //         body: TabBarView(
// //           children: tabTitles.map((title) {
// //             // Placeholder for the tab view content
// //             return Center(
// //               child: Text(
// //                 'Content for $title',
// //                 style: TextStyle(fontSize: 24),
// //               ),
// //             );
// //           }).toList(),
// //         ),
// //       ),
// //     );
// //   }
// // }



// class TopNavigationPage extends StatelessWidget {
//   final List<String> tabTitles;

//   TopNavigationPage({ this.tabTitles});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: tabTitles.length,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white, // Set AppBar color to white
//           toolbarHeight: 0, // Reduce AppBar height
//           titleTextStyle: TextStyle(color: Colors.black, fontSize: 18), // Customize title style
//           iconTheme: IconThemeData(color: Colors.black), // Change icon color
//           bottom: TabBar(
//             indicatorColor: Colors.black, // Indicator color for active tab
//             labelColor: Colors.black, // Label color for selected tab
//             unselectedLabelColor: Colors.grey, // Label color for unselected tabs
//             tabs: tabTitles.map((title) {
//               IconData iconData;

//               // Choose an appropriate icon for each title
//               switch (title) {
//                 case 'Out for Delivery':
//                   iconData = Icons.delivery_dining;
//                   break;
//                 case 'Reschedule':
//                   iconData = Icons.calendar_today;
//                   break;
//                 case 'Delivered':
//                   iconData = Icons.check_circle;
//                   break;
//                 default:
//                   iconData = Icons.help;
//               }

//               return Tab(
//                 icon: Icon(iconData, size: 20), // Set icon size
//                 child: Text(
//                   title,
//                   style: TextStyle(fontSize: 12), // Smaller font size
//                   overflow: TextOverflow.ellipsis, // Avoid text clipping
//                   maxLines: 1, // Single line text
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         body: TabBarView(
//           children: tabTitles.map((title) {
//                 // Use conditional logic here
//           if (title == 'Out for Delivery') {
//             return DynamicListScreen();
//           } else if (title == 'Reschedule') {
//             return DynamicListScreennew();
//           } else if (title == 'Delivered') {
//             return DynamicListScreenDelivered();
//           } else {
//             return Center(
//               child: Text('Default Content', style: TextStyle(fontSize: 24)),
//             );
//           }
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
















import 'package:flutter/material.dart';
import 'package:logistics/Drawer/privacyPolicy.dart';
import 'package:logistics/NewReUseableWidgets/deliveredLIst.dart';
import 'package:logistics/NewReUseableWidgets/dispatch.dart';
import 'package:logistics/NewReUseableWidgets/notificationList.dart';
import 'package:logistics/NewReUseableWidgets/paymentPictureScreen.dart';
import 'package:logistics/NewReUseableWidgets/rescheduleList.dart';
import 'package:logistics/newChange/aboutUs.dart';
import 'package:logistics/newChange/rateApp.dart';
import 'package:logistics/newChange/riderDetailsScreen.dart';
import 'package:logistics/newChange/searchScreen.dart';
import 'package:logistics/newChange/sidebarNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';
import '../scan.dart';
import '../utils/color.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserMain(),
    );
  }
}

class UserMain extends StatefulWidget {
  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _bottomNavIndex = 0; // Track selected bottom navigation index

  // Pages for Bottom Navigation
  final List<Widget> _bottomNavPages = [
    TopNavigationPage(
        tabTitles: ['Out for Delivery', 'Reschedule', 'Delivered']),
         DashboardScreenNew(),
         PaymentRequestScreen(),
        // SubmitVoucherScreen(),
          NotificationScreen()
  ];

      void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");

   
  await prefs.remove('cachedDeliveryList'); // Clear delivery cache
  print("User logged out. Cache cleared.");
  // Navigate to login screen
    
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.red,
      child: Icon(Icons.qr_code, color: Colors.white),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QRViewExample()),
        );
      },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  
      drawer: Drawer(
        child: Column(
          children: [
            // UserAccountsDrawerHeader(
            //   currentAccountPicture: CircleAvatar(
            //     backgroundImage: AssetImage('assets/images/profile.png'), // Replace with your imagefsdf
            //   ),
            //   accountName: Text('Your Name'),
            //   accountEmail: Text('Mobile: +123456789'),
            //   decoration: BoxDecoration(
            //     color: Colors.red,
            //   ),
            // ),

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
                        'Rohit Sharma',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Mobile: +977-9826478511',
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
                        MaterialPageRoute(
                            builder: (context) => RateAppScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notification'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SideBarNotificationScreen()),
                      );
                      // Navigate to Notification screen
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About Us'),
                    onTap: () {
                      // Navigate to About Us screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutUsScreen()),
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
                    title: Text('Contact Us'),
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
      ),
      body: _bottomNavPages[_bottomNavIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notification',
          ),
          
        ],
         selectedItemColor: Colors.red,
  unselectedItemColor: Colors.grey,
  type: BottomNavigationBarType.fixed, // Prevents shifting effect
      ),
    );
  }
}




// class TopNavigationPage extends StatelessWidget {
//   final List<String> tabTitles;

//   TopNavigationPage({ this.tabTitles});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: tabTitles.length,
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: TabBar(
//             tabs: tabTitles.map((title) {
//               IconData iconData;

//               // Choose an appropriate icon for each title
//               switch (title) {
//                 case 'Out for Delivery':
//                   iconData = Icons.delivery_dining;
//                   break;
//                 case 'Reschedule':
//                   iconData = Icons.calendar_today;
//                   break;
//                 case 'Delivered':
//                   iconData = Icons.check_circle;
//                   break;
//                 default:
//                   iconData = Icons.help;
//               }

//               return Tab(
//                 icon: Icon(iconData, size: 20), // Set icon size
//                 child: Text(
//                   title,
//                   style: TextStyle(fontSize: 12), // Smaller font size
//                   overflow: TextOverflow.ellipsis, // Avoid text clipping
//                   maxLines: 1, // Single line text
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         body: TabBarView(
//           children: tabTitles.map((title) {
//             // Placeholder for the tab view content
//             return Center(
//               child: Text(
//                 'Content for $title',
//                 style: TextStyle(fontSize: 24),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }



class TopNavigationPage extends StatelessWidget {
  final List<String> tabTitles;

  TopNavigationPage({ this.tabTitles});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // Set AppBar color to white
          toolbarHeight: 0, // Reduce AppBar height
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18), // Customize title style
          iconTheme: IconThemeData(color: Colors.black), // Change icon color
          bottom: TabBar(
            indicatorColor: Colors.black, // Indicator color for active tab
            labelColor: Colors.black, // Label color for selected tab
            unselectedLabelColor: Colors.grey, // Label color for unselected tabs
            tabs: tabTitles.map((title) {
              IconData iconData;

              // Choose an appropriate icon for each title
              switch (title) {
                case 'Out for Delivery':
                  iconData = Icons.delivery_dining;
                  break;
                case 'Reschedule':
                  iconData = Icons.calendar_today;
                  break;
                case 'Delivered':
                  iconData = Icons.check_circle;
                  break;
                default:
                  iconData = Icons.help;
              }

              return Tab(
                icon: Icon(iconData, size: 20), // Set icon size
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12), // Smaller font size
                  overflow: TextOverflow.ellipsis, // Avoid text clipping
                  maxLines: 1, // Single line text
                ),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: tabTitles.map((title) {
                // Use conditional logic here
          if (title == 'Out for Delivery') {
            return DynamicListScreen();
          } else if (title == 'Reschedule') {
            return DynamicListScreennew();
          } else if (title == 'Delivered') {
            return DynamicListScreenDelivered();
          } else {
            return Center(
              child: Text('Default Content', style: TextStyle(fontSize: 24)),
            );
          }
          }).toList(),
        ),
      ),
    );
  }
}






