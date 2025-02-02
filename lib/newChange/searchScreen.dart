
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
