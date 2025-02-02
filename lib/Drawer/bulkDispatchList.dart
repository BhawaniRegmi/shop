import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logistics/Drawer/bulkScanner.dart';
import 'package:logistics/Drawer/bulkdispatchDetailScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BulkDispatchListScreen extends StatefulWidget {
  @override
  _BulkDispatchListScreenState createState() => _BulkDispatchListScreenState();
}

class _BulkDispatchListScreenState extends State<BulkDispatchListScreen> {
  List<dynamic> bulkDispatchList = [];
  bool isLoading = true;
  final String apiUrl = 'https://dashlogistics.dev/api/v1/employee/bulkdispatch';

  @override
  void initState() {
    super.initState();
    fetchBulkDispatchData();
  }

  Future<void> fetchBulkDispatchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found');
      }

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        setState(() {
          bulkDispatchList = response.data['data'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text; // Handle empty strings
    return text[0].toUpperCase() + text.substring(1); // Capitalize first letter
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//            appBar: AppBar(
//   backgroundColor: Colors.white, // White background color
//   title: const Text(
//     'Bulk Dispatch List',
//     style: TextStyle(color: Colors.red), // Red text color
//   ),
//   iconTheme: const IconThemeData(
//     color: Colors.black, // Black color for back arrow
//   ),

// ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: bulkDispatchList.length,
//               itemBuilder: (context, index) {
//                 final item = bulkDispatchList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         // builder: (context) => DetailScreen(data: item,orderItems: []),
//                         builder: (context) => DetailScreen(data: item,batchCode:'${item['batchCode']}' ),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     margin: EdgeInsets.all(10),
//                     elevation: 5,
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 '${item['batchCode']}',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
                              
//                               Text('${item['batchTotalItem']} items'),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             '${item['fromHub']['name']} - ${item['toHub']['name']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('${item['createdAt']}'),
//                            Text(
//   'Status: ${capitalizeFirstLetter(item['status'] ?? 'N/A')}',
//   style: TextStyle(
//     color: item['status'] == 'complete' ? Colors.green : Colors.orange,
//     fontWeight: FontWeight.bold,
//   ),
// ),

//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }



@override
Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QRViewExampleBulk()),
      );
      return false; // Prevent default back behavior
    },
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Bulk Dispatch List',
          style: TextStyle(color: Colors.red),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: bulkDispatchList.length,
              itemBuilder: (context, index) {
                final item = bulkDispatchList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          data: item,
                          batchCode: '${item['batchCode']}',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item['batchCode']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${item['batchTotalItem']} items'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${item['fromHub']['name']} - ${item['toHub']['name']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${item['createdAt']}'),
                              Text(
                                'Status: ${capitalizeFirstLetter(item['status'] ?? 'N/A')}',
                                style: TextStyle(
                                  color: item['status'] == 'complete'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    ),
  );
}

}








