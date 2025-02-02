import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String batchCode;

  DetailScreen({this.data, this.batchCode});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic> data = {};
  List<Map<String, dynamic>> orderItems = [];

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData(widget.batchCode);
  }

  Widget buildCompactText(String label, String value) {
  return Expanded(
    child: RichText(
      text: TextSpan(
        text: '$label ',
        style: TextStyle(color: Colors.black, fontSize: 14),
        children: [
          TextSpan(
            text: value ?? 'N/A',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

  Future<void> fetchData(String batchCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      if (token == null) {
        throw Exception('No token found in SharedPreferences');
      }

      Dio dio = Dio();
      dio.options.headers = {'Authorization': 'Bearer $token'};

      Response response = await dio.get(
        'https://dashlogistics.dev/api/v1/employee/bulkdispatch-item/$batchCode/list',
      );

      if (response.statusCode == 200) {
        setState(() {
          // Extract the 'data' array from the response
          final dataList = response.data['data'] ?? [];

          // Populate orderItems with all 'orderItem' objects from the response
          orderItems = dataList
              .where((item) =>
                  item['orderItem'] != null) // Filter out null orderItem
              .map<Map<String, dynamic>>(
                  (item) => item['orderItem'] as Map<String, dynamic>)
              .toList();

          // Assign the entire data object for the first item (optional)
          data = dataList.isNotEmpty ? dataList[0] : {};

          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text; // Handle empty strings
    return text[0].toUpperCase() + text.substring(1); // Capitalize first letter
  }

  // Default to an empty list if null
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White background color
        title: const Text(
          'Detail Screen',
          style: TextStyle(
            color: MyColors.primaryColor,
          ), // Red text color
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, // Black color for back arrow
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextSection(
                          'Batch Code',
                          capitalizeFirstLetter(
                              widget.data['batchCode'] ?? 'N/A')),
                      buildTextSection(
                          'Total Items',
                          capitalizeFirstLetter(
                              widget.data['batchTotalItem']?.toString() ??
                                  'N/A')),
                      buildTextSection(
                        'From Hub',
                        capitalizeFirstLetter(
                            '${widget.data['fromHub']['name'] ?? 'Unknown'} (${widget.data['fromHub']['code'] ?? 'N/A'})'),
                      ),
                      buildTextSection(
                        'To Hub',
                        capitalizeFirstLetter(
                            '${widget.data['toHub']['name'] ?? 'Unknown'} (${widget.data['toHub']['code'] ?? 'N/A'})'),
                      ),
                      buildTextSection(
                          'Batch Weight',
                          capitalizeFirstLetter(
                              '${widget.data['batchWeight'] ?? 'N/A'} kg')),
                      buildTextSection(
                        'Type',
                        capitalizeFirstLetter(
                            '${widget.data['type'] ?? 'N/A'} (${widget.data['typeValue'] ?? 'N/A'})'),
                      ),
                      buildTextSection(
                          'CN Number',
                          capitalizeFirstLetter(
                              widget.data['cnNumber'] ?? 'N/A')),
                      buildTextSection(
                          'Receiver Contact',
                          capitalizeFirstLetter(
                              widget.data['receiverContact'] ?? 'N/A')),
                      buildTextSection(
                          'Remarks',
                          capitalizeFirstLetter(
                              widget.data['remarks'] ?? 'N/A')),
                      buildTextSection(
                        'Status',
                        capitalizeFirstLetter(widget.data['status'] ?? 'N/A'),
                        valueColor: widget.data['status'] == 'complete'
                            ? Colors.green
                            : Colors.orange,
                      ),
                      buildTextSection(
                          'Created At',
                          capitalizeFirstLetter(
                              widget.data['createdAt'] ?? 'N/A')),
                      buildTextSection(
                          'Dispatch At',
                          capitalizeFirstLetter(
                              widget.data['dispatchAt'] ?? 'N/A')),
                      buildTextSection(
                          'Receive At',
                          capitalizeFirstLetter(
                              widget.data['receiveAt'] ?? 'N/A')),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Order Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 4),
            if (orderItems.isNotEmpty)
              ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: orderItems.length,
  itemBuilder: (context, index) {
    final order = orderItems[index];

    if (order == null) {
      return Center(
        child: Text(
          'Order data not available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

// Helper Function for RichText
Widget buildRichText(String label, String value, Color labelColor, {Color textColor = Colors.black}) {
  return RichText(
    text: TextSpan(
      text: '$label\n',
      style: TextStyle(color: MyColors.myColorCode, fontSize: 14),
      children: [
        TextSpan(
          text: value ?? 'N/A',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

    return Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  elevation: 3,
  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
  child: Padding(
    padding: EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status and Tracking Code
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildRichText('Tracking Code:', order['trackingCode'], Colors.black),
            ),
            Expanded(
              child: buildRichText('Current Status:', capitalizeFirstLetter(order['currentStatus']), MyColors.primaryColor),
            ),
          ],
        ),
        SizedBox(height: 8),

        // Client Name and Address
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildRichText('Client Name:', order['clientName'], MyColors.primaryColor, textColor: Colors.black),
            ),
            Expanded(
              child: buildRichText('Client Address:', capitalizeFirstLetter(order['clientAddress']), MyColors.primaryColor),
            ),
          ],
        ),
        SizedBox(height: 8),

        // Client Contact and Receiver Name
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildRichText('Client Contact:', order['clientContact'], MyColors.primaryColor),
            ),
            Expanded(
              child: buildRichText('Receiver Name:', order['receiverName'], MyColors.primaryColor),
            ),
          ],
        ),
        SizedBox(height: 8),

        // Receiver Address and Receiver Contact
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildRichText('Receiver Address:', capitalizeFirstLetter(order['receiverAddress']), MyColors.primaryColor),
            ),
            Expanded(
              child: buildRichText('Receiver Contact:', order['receiverContact'], MyColors.primaryColor),
            ),
          ],
        ),
        SizedBox(height: 8),

        // Order Date
        buildCompactRow(
          'Order Date:',
          capitalizeFirstLetter(order['orderDate'] ?? 'N/A'),
        ),
      ],
    ),
  ),
);

  },
)

// Helper function for text layout


            else
              Text(
                '',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCompactRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 2.0), // Reduced spacing between rows
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14, // Smaller font size
              
              color:MyColors.myColorCode,
            ),
          ),
          SizedBox(width: 5), // Minimal spacing between title and value
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold,// Consistent compact font size
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis, // Prevents long text overflow
            ),
          ),
        ],
      ),
    );
  }



Widget buildTextSection(String title, String value, {Color valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0), // Reduced vertical spacing
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120, // Adjust width to ensure alignment
          child: Text(
            '$title:',
            style: TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.bold,
              color: MyColors.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}


}
