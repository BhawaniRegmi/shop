
// import 'package:flutter/material.dart';
// import 'package:logistics/Drawer/drawer.dart';
// import 'package:logistics/Drawer/privacyPolicy.dart';
// import 'package:logistics/NewReUseableWidgets/deliveredLIst.dart';
// import 'package:logistics/NewReUseableWidgets/dispatch.dart';
// import 'package:logistics/NewReUseableWidgets/notificationList.dart';
// import 'package:logistics/NewReUseableWidgets/paymentPictureScreen.dart';
// import 'package:logistics/NewReUseableWidgets/rescheduleList.dart';
// import 'package:logistics/newChange/aboutUs.dart';
// import 'package:logistics/newChange/rateApp.dart';
// import 'package:logistics/newChange/riderDetailsScreen.dart';
// import 'package:logistics/newChange/searchScreen.dart';
// import 'package:logistics/newChange/sidebarNotification.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../login/login_screen.dart';
// import '../scan.dart';
// import '../utils/color.dart';




// class UserMain extends StatefulWidget {
//    final ValueNotifier<int> unseenCountNotifier;
//    UserMain({this.unseenCountNotifier});
//   @override
//   _UserMainState createState() => _UserMainState();
// }

// class _UserMainState extends State<UserMain> {
//   int _bottomNavIndex = 0; // Track selected bottom navigation index
  

//   // Pages for Bottom Navigation
//   final List<Widget> _bottomNavPages = [
//     TopNavigationPage(
//         tabTitles: ['Out for Delivery', 'Reschedule', 'Delivered']),
//          DashboardScreenNew(),
//          PaymentRequestScreen(),
       
//           NotificationScreen()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//       backgroundColor: Colors.red,
//       child: Icon(Icons.qr_code, color: Colors.white),
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => QRViewExample()),
//         );
//       },
//     ),
//     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  
//       drawer: MyDrawer(),
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
//             icon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.payment),
//             label: 'Payment',
//           ),
//             BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_active),
//             label: 'Notification',
//           ),
          
//         ],
//          selectedItemColor: Colors.red,
//   unselectedItemColor: Colors.grey,
//   type: BottomNavigationBarType.fixed, // Prevents shifting effect
//       ),
//     );
//   }
// }


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
import 'package:logistics/Drawer/drawer.dart';
import 'package:logistics/NewReUseableWidgets/deliveredLIst.dart';
import 'package:logistics/NewReUseableWidgets/dispatch.dart';
import 'package:logistics/NewReUseableWidgets/notificationList.dart';
import 'package:logistics/NewReUseableWidgets/paymentPictureScreen.dart';
import 'package:logistics/NewReUseableWidgets/rescheduleList.dart';
import 'package:logistics/newChange/searchScreen.dart';
import 'package:logistics/scan.dart';


class UserMain extends StatefulWidget {
  final ValueNotifier<int> unseenCountNotifier;

  UserMain({ this.unseenCountNotifier});

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _bottomNavIndex = 0; // Track selected bottom navigation index

  // Pages for Bottom Navigation
   List<Widget> _bottomNavPages;

  @override
  void initState() {
    super.initState();
    _bottomNavPages = [
      TopNavigationPage(tabTitles: ['Out for Delivery', 'Reschedule', 'Delivered']),
      DashboardScreenNew(),
      PaymentRequestScreen(),
      NotificationScreen(unseenCountNotifier: widget.unseenCountNotifier) // Ensure this screen also uses the unseenCountNotifier
    ];
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
      drawer: MyDrawer(),
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
            icon: Stack(
              children: [
                Icon(Icons.notifications_active),
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