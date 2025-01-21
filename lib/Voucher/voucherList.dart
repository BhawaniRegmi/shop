// import 'package:flutter/material.dart';

// class VoucherList extends StatelessWidget {
//   final Map<String, dynamic> response;

//   const VoucherList({Key key, this.response}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Extract data from the response
//     final List<dynamic> vouchers = response['data'] ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Voucher List'),
//       ),
//       body: ListView.builder(
//         itemCount: vouchers.length,
//         itemBuilder: (context, index) {
//           final voucher = vouchers[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text('Payment: \Rs ${voucher['voucherPayment']}'),
//               subtitle: Text('Created At: ${voucher['createdAt']}'),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.visibility),
//                     onPressed: () {
//                       // Handle view action
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('Voucher Details'),
//                           content: Text('Note: ${voucher['voucherNote']}\n\nStatus: ${voucher['voucherStatus']}'),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('Close'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () {
//                       // Handle delete action
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('Confirm Delete'),
//                           content: const Text('Are you sure you want to delete this voucher?'),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('Cancel'),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // Perform delete logic here
//                                 Navigator.pop(context);
                                
//                               },
//                               child: const Text('Delete'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }





//working perfectly for delete and show request but need to refresh for seeing delete
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class VoucherList extends StatelessWidget {
//   final Map<String, dynamic> response;

//   const VoucherList({Key key,  this.response}) : super(key: key);



//     Future<void> _deleteVoucher(BuildContext context,int id) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.post(
//         'https://dashlogistics.dev/api/v1/employee/ridervoucher/destroy/$id',
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Voucher deleted successfully!')),
//         );
//       } else {
//         throw Exception('Failed to delete voucher');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Extract data from the response
//     final List<dynamic> vouchers = response['data'] ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Voucher List'),
//       ),
//       body: ListView.builder(
//         itemCount: vouchers.length,
//         itemBuilder: (context, index) {
//           final voucher = vouchers[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text('Payment: \$${voucher['voucherPayment']}'),
//               subtitle: Text('Created At: ${voucher['createdAt']}'),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.visibility),
//                     onPressed: () {
//                       // Handle view action
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('Voucher Details'),
//                           content: Text('Note: ${voucher['voucherNote']}\n\nStatus: ${voucher['voucherStatus']}'),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('Close'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () {
//                       // Handle delete action
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('Confirm Delete'),
//                           content: const Text('Are you sure you want to delete this voucher?'),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('Cancel'),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context); // Close the confirmation dialog
//                                 _deleteVoucher(context, voucher['id']);
//                               },
//                               child: const Text('Delete'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




//perfectly working list of voucher but sent whole data not for particular id
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logistics/Voucher/viewDetailScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class VoucherList extends StatefulWidget {
//   final Map<String, dynamic> response;

//   const VoucherList({Key key,  this.response}) : super(key: key);

//   @override
//   _VoucherListState createState() => _VoucherListState();
// }

// class _VoucherListState extends State<VoucherList> {
//    List<dynamic> vouchers;

//   @override
//   void initState() {
//     super.initState();
//     vouchers = widget.response['data'] ?? [];
//   }

//   Future<void> _deleteVoucher(BuildContext context, int id) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String token = prefs.getString('token');

//       if (token == null) throw Exception('Token not found');

//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.post(
//         'https://dashlogistics.dev/api/v1/employee/ridervoucher/destroy/$id',
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           vouchers.removeWhere((voucher) => voucher['id'] == id);
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Voucher deleted successfully!')),
//         );
//       } else {
//         throw Exception('Failed to delete voucher');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Voucher List'),
//       ),
//       body: ListView.builder(
//         itemCount: vouchers.length,
//         itemBuilder: (context, index) {
//           final voucher = vouchers[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text('Payment: \Rs ${voucher['voucherPayment']}'),
//               subtitle: Text('Created At: ${voucher['createdAt']}'),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.visibility),
//                     onPressed: () {
//                       // Handle view action
//                       // showDialog(
//                       //   context: context,
//                       //   builder: (_) => AlertDialog(
//                       //     title: const Text('Voucher Details'),
//                       //     content: Text(
//                       //         'Note: ${voucher['voucherNote']}\n\nStatus: ${voucher['voucherStatus']}'),
//                       //     actions: [
//                       //       TextButton(
//                       //         onPressed: () => Navigator.pop(context),
//                       //         child: const Text('Close'),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // );
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => VoucherDetailScreen(response:widget.response ),));
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () {
//                       // Handle delete action
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('Confirm Delete'),
//                           content: const Text(
//                               'Are you sure you want to delete this voucher?'),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('Cancel'),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context); // Close dialog
//                                 _deleteVoucher(context, voucher['id']);
//                               },
//                               child: const Text('Delete'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/Voucher/viewDetailScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherList extends StatefulWidget {
  final Map<String, dynamic> response;

  const VoucherList({Key key, this.response}) : super(key: key);

  @override
  _VoucherListState createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  List<dynamic> vouchers;

  @override
  void initState() {
    super.initState();
    vouchers = widget.response['data'] ?? [];
  }

  // Future<void> _deleteVoucher(BuildContext context, int id) async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String token = prefs.getString('token');

  //     if (token == null) throw Exception('Token not found');

  //     final Dio dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $token';

  //     final response = await dio.post(
  //       'https://dashlogistics.dev/api/v1/employee/ridervoucher/destroy/$id',
  //     );

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         vouchers.removeWhere((voucher) => voucher['id'] == id);
  //       });

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Voucher deleted successfully!')),
  //       );
  //     } else {
  //       throw Exception('Failed to delete voucher');
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   }
  // }


  Future<void> _deleteVoucher(BuildContext context, int id) async {
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
      setState(() {
        vouchers.removeWhere((voucher) => voucher['id'] == id);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voucher deleted successfully!')),
      );
    } else if (response.statusCode == 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voucher cannot be deleted as it is already approved')),
      );
    } else {
      throw Exception('Failed to delete voucher');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Voucher can't be deleted as it is already approved.")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voucher List',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // body: ListView.builder(
      //   itemCount: vouchers.length,
      //   itemBuilder: (context, index) {
      //     final voucher = vouchers[index];
      //     return Card(
      //       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //       child: ListTile(
      //         title: Text('Payment: \Rs ${voucher['voucherPayment']}'),
      //         subtitle: Text('Created At: ${voucher['createdAt']}'),
      //         trailing: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //               IconButton(
      //               icon: const Icon(Icons.visibility, color: Colors.blue),
      //               onPressed: () {
      //                 // Navigate to the detail screen with the selected voucher
      //                 Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => VoucherDetailScreen(response: voucher),
      //                 ),
      //                 );
      //               },
      //               ),
      //             IconButton(
      //               icon: const Icon(Icons.delete),
      //               onPressed: () {
      //                 // Handle delete action
      //                 showDialog(
      //                   context: context,
      //                   builder: (_) => AlertDialog(
      //                     title: const Text('Confirm Delete'),
      //                     content: const Text(
      //                         'Are you sure you want to delete this voucher?'),
      //                     actions: [
      //                       TextButton(
      //                         onPressed: () => Navigator.pop(context),
      //                         child: const Text('Cancel'),
      //                       ),
      //                       TextButton(
      //                         onPressed: () {
      //                           Navigator.pop(context); // Close dialog
      //                           _deleteVoucher(context, voucher['id']);
      //                         },
      //                         child: const Text('Delete'),
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body:ListView.builder(
  itemCount: vouchers.length,
  itemBuilder: (context, index) {
    final voucher = vouchers[index];
    return Card(
      elevation: 4, // Adds shadow for a more elevated look
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Increased margin for spacing
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      color: Colors.white, // Set background color to white
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding for better spacing
        title: Text(
          'Payment: \Rs ${voucher['voucherPayment']}',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold for emphasis
            color: Colors.black87, // Better contrast for text
          ),
        ),
        subtitle: Text(
          'Created At: ${voucher['createdAt']}',
          style: TextStyle(
            
            fontSize: 14,
            color: Colors.grey[600], // Lighter text color for subtitle
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.visibility, color: Colors.blue),
              onPressed: () {
                // Navigate to the detail screen with the selected voucher
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VoucherDetailScreen(response: voucher),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red), // Red color for delete icon
              onPressed: () {
                // Handle delete action
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text(
                      'Are you sure you want to delete this voucher?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          _deleteVoucher(context, voucher['id']);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  },
)

    );
  }
}
