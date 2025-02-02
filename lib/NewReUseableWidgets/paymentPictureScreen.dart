
//everything working even submit button
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:logistics/Drawer/drawer.dart';
import 'package:logistics/Drawer/privacyPolicy.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Voucher/voucherList.dart';
import '../login/login_screen.dart';
import '../newChange/aboutUs.dart';
import '../newChange/rateApp.dart';
import '../newChange/riderDetailsScreen.dart';
import '../newChange/sidebarNotification.dart';
import '../utils/color.dart';
import 'package:image_picker/image_picker.dart';

class PaymentRequestScreen extends StatefulWidget {
  @override
  _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
}

class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  File _voucherImage;
  CameraController _cameraController;
  List<CameraDescription> _cameras;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  Future<void> _submitVoucher() async {
    // Show the loading dialog
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token');
      if (token == null) throw Exception('Token not found');
      if (amountController.text.isEmpty) throw Exception('Amount is required');
      if (noteController.text.isEmpty) throw Exception('Note is required');
      if (_voucherImage == null) throw Exception('Voucher Image is required');

      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      dio.options.headers['Accept'] = 'application/json';

      print('Authorization Header: Bearer $token');

      final formData = FormData.fromMap({
        'voucherPayment': amountController.text,
        'voucherNote': noteController.text,
        'voucherImage': await MultipartFile.fromFile(_voucherImage.path),
      });

      final response = await dio.post(
        'https://dashlogistics.dev/api/v1/employee/ridervoucher/store',
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status < 500,
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      // Close the loading dialog
      Navigator.of(context).pop();

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnackBar('Voucher submitted successfully!');
        // Navigate to Voucher List
        _fetchVoucherList();
      } else if (response.statusCode == 422) {
        final errors = response.data['errors'];
        _showSnackBar('Validation Errors: $errors');
      } else {
        throw Exception(
            'Failed to submit voucher. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      // Close the loading dialog in case of an error
      Navigator.of(context).pop();
      _showSnackBar('Error: $e');
    }
  }

// Helper function to show SnackBar at the top
  void _showSnackBar(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: kToolbarHeight + 10, left: 10, right: 10),
      ),
    );
  }

  Future<void> _fetchVoucherList() async {
    // Show the loading dialog
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'https://dashlogistics.dev/api/v1/employee/ridervoucher',
      );

      // Close the loading dialog
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoucherList(response: response.data),
          ),
        );
      } else {
        throw Exception('Failed to fetch voucher list');
      }
    } catch (e) {
      // Close the loading dialog in case of an error
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _selectImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile imageFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (imageFile != null) {
        setState(() {
          _voucherImage = File(imageFile.path); // Save the selected image
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image selected successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No image selected.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error selecting image: $e")),
      );
    }
  }

  Future<void> _fetchVoucherShow(int id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'https://dashlogistics.dev/api/v1/employee/ridervoucher/show/$id',
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voucher details fetched successfully!')),
        );
        print(response.data); // Process and display response data here
      } else {
        throw Exception('Failed to fetch voucher details');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _deleteVoucher(int id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'https://dashlogistics.dev/api/v1/employee/ridervoucher/destroy/$id',
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voucher deleted successfully!')),
        );
      } else {
        throw Exception('Failed to delete voucher');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _captureImage() async {
    if (!isCameraInitialized) return;

    try {
      final XFile imageFile = await _cameraController.takePicture();
      setState(() {
        _voucherImage =
            File(imageFile.path); // Convert XFile to File for display
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Image captured successfully!")),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error capturing image: $e")),
      );
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

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
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Payment Voucher",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          TextButton(
            //onPressed: () {},
            onPressed: _fetchVoucherList,
            child: Text(
              'View History',
              style: TextStyle(color: Colors.blue, fontSize: 12),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Rs',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/nepRs.png',
                      width: 16, // Reduced width
                      height: 16, // Reduced height
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                labelText: 'Note',
                prefixIcon: Icon(Icons.note, color: Color(0xFFCF0000)),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24.0),
            Center(
              child: Text(
                "Voucher Image",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            isCameraInitialized
                ? Column(
                    children: [
                      Center(
                        child: Container(
                          width: 250,
                          height: 250,
                          child: CameraPreview(_cameraController),
                        ),
                      ),
                      SizedBox(height: 10),

                      Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Capture Image Button
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        shadowColor: Colors.black12,
      ),
      onPressed: _captureImage,
      icon: Icon(Icons.camera_alt, size: 20),
      label: Text(
        'Capture',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Select Image Button
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[200],
        onPrimary: Colors.black87,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        shadowColor: Colors.black12,
      ),
      onPressed: _selectImageFromGallery,
      icon: Icon(Icons.photo_library, size: 20),
      label: Text(
        'Gallery',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Image Preview
    if (_voucherImage != null)
      Container(
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(20),
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.1,
                  maxScale: 4.0,
                  child: Image.file(_voucherImage),
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(Icons.image_search, size: 28, color: Colors.green[600]),
                SizedBox(width: 4),
                Text(
                  '',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
  ],
)
                  
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitVoucher,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize:
                    Size(double.infinity, 50), // Full width and fixed height
              ),
              child: Text('Submit'),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
