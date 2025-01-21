// import 'package:flutter/material.dart';

// class RiderDetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Rider Details"),
//         backgroundColor: Colors.red, // App bar background color
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Rider Photo and Basic Info
//             Center(
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 60,
//                     backgroundImage: AssetImage(
//                         'assets/images/profile.png'), // Replace with actual image
//                   ),
//                   SizedBox(width: 15),
//                   Column(
//                     children: [
//                       SizedBox(height: 10),
//                       _animatedText("John Doe", 22, FontWeight.bold),
//                       SizedBox(height: 5),
//                       _animatedText("Phone: +123456789", 16, FontWeight.normal),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             // Join Date and Gender
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _infoTile("Join Date", "  2024-01-01"),
//                 _infoTile("Gender", "  Male"),
//               ],
//             ),

//             SizedBox(height: 10),
//             _infoTile("Bike License Number", "DL-123456789"),
//             SizedBox(height: 10),
//             _infoTile("Bike Number Assigned", "BA-1234-XY"),
//             SizedBox(height: 10),

//             // Assigned Department
//             _infoTile("Assigned Department", "Logistics"),
//             SizedBox(height: 20),

//             // Permission of Rider
//             _sectionHeader("Permission of Rider"),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 _animatedText(
//                     "Order Placed", 16, FontWeight.bold, Colors.green),
//                 SizedBox(width: 7),
//                 _animatedText(
//                     "Order Picked", 16, FontWeight.bold, Colors.green),
//                 SizedBox(width: 7),
//               ],
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 _animatedText(
//                     "Order Deployed", 16, FontWeight.bold, Colors.green),
//                 SizedBox(width: 7),
//                 _animatedText(
//                     "Out for delivery", 16, FontWeight.bold, Colors.green),
//               ],
//             ),
//             SizedBox(height: 10),
//             // Identification and Passport Images
//             _sectionHeader("Identification Image"),
//             SizedBox(height: 10),
//             _imageCard('assets/images/identification.png'),
//             SizedBox(height: 20),
//             _sectionHeader("Passport Image"),
//             SizedBox(height: 10),
//             _imageCard('assets/images/passport.png'),
//             SizedBox(height: 10),
//             // Bike Details
//             _sectionHeader("Bike Driving License"),
//             SizedBox(height: 10),
//             _imageCard('assets/images/bike_license.png'),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.red[50], // Light red background
//     );
//   }

//   // Helper widget for displaying animated text
//   Widget _animatedText(String text, double fontSize, FontWeight fontWeight,
//       [Color color]) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       decoration: BoxDecoration(
//         // color: Colors.red[100],
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//           color: color ?? Colors.black,
//         ),
//       ),
//     );
//   }

//   // Helper widget for displaying section headers
//   Widget _sectionHeader(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Colors.red[800],
//       ),
//     );
//   }

//   // Helper widget for displaying images with a card style
//   Widget _imageCard(String imagePath) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade300,
//             blurRadius: 6,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Image.asset(
//           imagePath,
//           height: 150,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   // Helper widget for displaying key-value tiles
//   Widget _infoTile(String label, String value) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       margin: EdgeInsets.symmetric(vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             value,
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RiderDetailsScreen extends StatelessWidget {


// //   Future<dynamic> fetchRiderDetails() async {
// //   final Dio dio = Dio();
// //   final prefs = await SharedPreferences.getInstance();

// //   // Retrieve token from SharedPreferences
// //   final token = prefs.getString('authToken');

// //   // Ensure token exists
// //   if (token == null || token.isEmpty) {
// //     throw Exception('Authentication token is missing!');
// //   }

// //   // Log the token for debugging purposes
// //   debugPrint("Using Token: $token");

// //   try {
// //     // Set headers and make the request
// //     final response = await dio.get(
// //       'https://dashlogistics.dev/api/v1/employee',
// //       options: Options(
// //         headers: {
// //           'Authorization': 'Bearer $token',
// //         },
// //       ),
// //     );

// //     // Check if response is successful
// //     if (response.statusCode == 200) {
// //       return response.data;
// //     } else {
// //       throw Exception('Failed to fetch rider details!');
// //     }
// //   } on DioError catch (e) {
// //     // Handle Dio errors
// //     if (e.response != null) {
// //       debugPrint("Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
// //       throw Exception('Request failed: ${e.response?.statusMessage}');
// //     } else {
// //       debugPrint("Dio Error: ${e.message}");
// //       throw Exception('Network error occurred!');
// //     }
// //   }
// // }


// Future<Map<String, dynamic>> fetchRiderDetails() async {
//   final Dio dio = Dio();
//   final prefs = await SharedPreferences.getInstance();

//   // Retrieve token from SharedPreferences
//   final token = prefs.getString('authToken');

//   // Ensure token exists
//   if (token == null || token.isEmpty) {
//     throw Exception('Authentication token is missing!');
//   }

//   // Log the token for debugging purposes
//   debugPrint("Using Token: $token");

//   try {
//     // Set headers and make the request
//     final response = await dio.get(
//       'https://dashlogistics.dev/api/v1/employee',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       ),
//     );

//     // Check if response is successful and return as Map<String, dynamic>
//     if (response.statusCode == 200) {
//       return response.data as Map<String, dynamic>;
//     } else {
//       throw Exception('Failed to fetch rider details!');
//     }
//   } on DioError catch (e) {
//     // Handle Dio errors
//     if (e.response != null) {
//       debugPrint(
//           "Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
//       throw Exception('Request failed: ${e.response?.statusMessage}');
//     } else {
//       debugPrint("Dio Error: ${e.message}");
//       throw Exception('Network error occurred!');
//     }
//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Rider Details"),
//         backgroundColor: Colors.red, // App bar background color
//         centerTitle: true,
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchRiderDetails(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No data available'));
//           }

//           final riderData = snapshot.data;

//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Rider Photo and Basic Info
//                 Center(
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 60,
//                         backgroundImage: riderData['profileImage'] != null
//                             ? NetworkImage(riderData['profileImage'])
//                             : AssetImage('assets/images/profile.png')
//                                 as ImageProvider,
//                       ),
//                       SizedBox(width: 15),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 10),
//                           _animatedText(riderData['fullName'], 22, FontWeight.bold),
//                           SizedBox(height: 5),
//                           _animatedText("Phone: ${riderData['phoneNumber']}", 16, FontWeight.normal),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Join Date and Gender
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _infoTile("Join Date", riderData['joinDate'] ?? 'N/A'),
//                     _infoTile("Gender", riderData['gender'] ?? 'N/A'),
//                   ],
//                 ),

//                 SizedBox(height: 10),
//                 _infoTile("Bike License Number", riderData['licenseNumber'] ?? 'N/A'),
//                 SizedBox(height: 10),
//                 _infoTile("Bike Number Assigned", riderData['deliveryVehicleNumber'] ?? 'N/A'),
//                 SizedBox(height: 10),

//                 // Assigned Department
//                 _infoTile("Assigned Department", riderData['department'] ?? 'N/A'),
//                 SizedBox(height: 20),

//                 // Permission of Rider
//                 _sectionHeader("Permission of Rider"),
//                 SizedBox(height: 10),
//                 Wrap(
//                   spacing: 7,
//                   runSpacing: 8,
//                   children: List.generate(
//                     riderData['permissions']?.length ?? 0,
//                     (index) => _animatedText(
//                       riderData['permissions'][index],
//                       16,
//                       FontWeight.bold,
//                       Colors.green,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Identification and Passport Images
//                 _sectionHeader("Identification Image"),
//                 SizedBox(height: 10),
//                 _imageCard('assets/images/identification.png'),
//                 SizedBox(height: 20),
//                 _sectionHeader("Passport Image"),
//                 SizedBox(height: 10),
//                 _imageCard('assets/images/passport.png'),
//                 SizedBox(height: 10),

//                 // Bike Details
//                 _sectionHeader("Bike Driving License"),
//                 SizedBox(height: 10),
//                 _imageCard('assets/images/bike_license.png'),
//                 SizedBox(height: 20),
//               ],
//             ),
//           );
//         },
//       ),
//       backgroundColor: Colors.red[50], // Light red background
//     );
//   }

//   Widget _animatedText(String text, double fontSize, FontWeight fontWeight,
//       [Color color]) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//           color: color ?? Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _sectionHeader(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Colors.red[800],
//       ),
//     );
//   }

//   Widget _imageCard(String imagePath) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade300,
//             blurRadius: 6,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Image.asset(
//           imagePath,
//           height: 150,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _infoTile(String label, String value) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       margin: EdgeInsets.symmetric(vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             value,
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }






import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiderDetailsScreen extends StatefulWidget {
  @override
  _RiderDetailsScreenState createState() => _RiderDetailsScreenState();
}

class _RiderDetailsScreenState extends State<RiderDetailsScreen> {
  Map<String, dynamic> riderDetails;

  @override
  void initState() {
    super.initState();
    _loadCachedData();
    _fetchRiderDetails();
  }

  void _loadCachedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cachedData = prefs.getString('cachedRiderDetails') ?? '';
    if (cachedData.isNotEmpty) {
      setState(() {
        riderDetails = Map<String, dynamic>.from(json.decode(cachedData));
      });
    }
  }

  void _fetchRiderDetails() async {
    try {
      final details = await fetchRiderDetails();
      setState(() {
        riderDetails = details;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('cachedRiderDetails', json.encode(details));
    } catch (error) {
      debugPrint('Error fetching rider details: $error');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        title: Text(
          "Rider Details",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
         leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
     
      body: riderDetails == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rider Photo and Basic Info
                  Center(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: riderDetails['data']
                                      ['profileImage'] !=
                                  null
                              ? NetworkImage(riderDetails['data']
                                  ['profileImage']) as ImageProvider
                              : AssetImage('assets/images/profile.png'),
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            SizedBox(height: 10),
                            _animatedText(
                                "Name: ${riderDetails['data']['fullName'] ?? ''}",
                                22,
                                FontWeight.bold),
                            SizedBox(height: 5),
                            _animatedText(
                                "Mobile: ${riderDetails['data']['phoneNumber'] ?? ''}",
                                16,
                                FontWeight.normal),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Join Date and Gender
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoTile("Join Date  ",
                          riderDetails['data']['joinDate'] ?? ""),
                      _infoTile("Gender  ",
                          riderDetails['data']['gender'] ?? ""),
                    ],
                  ),
                  SizedBox(height: 10),
                  _infoTile(
                      "Bike License Number",
                      riderDetails['data']['licenseNumber'] ??
                          ""),
                  SizedBox(height: 10),
                  _infoTile(
                      "Bike Number Assigned",
                      riderDetails['data']['deliveryVehicleNumber'] ??
                          ""),
                  SizedBox(height: 10),
                  // Assigned Department
                  _infoTile("Assigned Department",
                      riderDetails['data']['department'] ?? "Logistics"),
                  SizedBox(height: 20),
                  // Permission of Rider
                  // _sectionHeader("Permission of Rider"),
                  // SizedBox(height: 10),
                  // Wrap(
                  //   spacing: 10,
                  //   runSpacing: 8,
                  //   children: (riderDetails['data']['permissions'] as List)
                  //       .map((permission) => _animatedText(
                  //           permission, 16, FontWeight.bold, Colors.green))
                  //       .toList(),
                  // ),
                  // SizedBox(height: 20),
                  // Identification and Passport Images
                  _sectionHeader("ID Card"),
                  SizedBox(height: 10),
             //     _imageCard('assets/images/identification.png'),
             Container(
  margin: const EdgeInsets.symmetric(horizontal: 12),
  height: 300, // Height equivalent to CircleAvatar diameter
  width: double.infinity, // Full width of the screen minus the margin
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12), // Rounded corners
    image: DecorationImage(
      image: riderDetails['data']['profileImage'] != null
          ? NetworkImage(riderDetails['data']['idCard']) as ImageProvider
          : AssetImage('assets/images/profile.png'),
      fit: BoxFit.cover, // Ensures the image covers the container
    ),
  ),
),
                  SizedBox(height: 20),
                  _sectionHeader("Citizenship Image"),
                  SizedBox(height: 10),
                //  _imageCard('assets/images/passport.png'),
                Container(
  margin: const EdgeInsets.symmetric(horizontal: 12),
  height: 300, // Height equivalent to CircleAvatar diameter
  width: double.infinity, // Full width of the screen minus the margin
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12), // Rounded corners
    image: DecorationImage(
      image: riderDetails['data']['profileImage'] != null
          ? NetworkImage(riderDetails['data']['citizenship']) as ImageProvider
          : AssetImage('assets/images/profile.png'),
      fit: BoxFit.cover, // Ensures the image covers the container
    ),
  ),
),
                  SizedBox(height: 10),
                  // Bike Details
                  _sectionHeader("Bike Driving License"),
                  SizedBox(height: 10),
                 // _imageCard('assets/images/bike_license.png'),
Container(
  margin: const EdgeInsets.symmetric(horizontal: 12),
  height: 300, // Height equivalent to CircleAvatar diameter
  width: double.infinity, // Full width of the screen minus the margin
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12), // Rounded corners
    image: DecorationImage(
      image: riderDetails['data']['profileImage'] != null
          ? NetworkImage(riderDetails['data']['licensePhoto']) as ImageProvider
          : AssetImage('assets/images/profile.png'),
      fit: BoxFit.cover, // Ensures the image covers the container
    ),
  ),
),


                  SizedBox(height: 20),
                ],
              ),
            ),
      backgroundColor: Colors.red[50], // Light red background
    );
  }

  // Helper widget for displaying animated text
  Widget _animatedText(String text, double fontSize, FontWeight fontWeight,
      [Color color]) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? Colors.black,
        ),
      ),
    );
  }

  // Helper widget for displaying section headers
  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.red[800],
      ),
    );
  }

  // Helper widget for displaying images with a card style
  Widget _imageCard(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  

  // Helper widget for displaying key-value tiles
  Widget _infoTile(String label, String value) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}




