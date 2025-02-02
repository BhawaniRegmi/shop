import 'package:dio/dio.dart';
import 'package:logistics/packagedetailpage/package_detail_screen.dart';
import 'package:logistics/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistory {
  final String trackingCode;
  final String receiverName;
  final String receiverContact;
  final String receiverAlternateNumber;
  final String receiverLocationId;
  final String receiverHubId;
  final String receiverAddress;
  final String productName;
  final String paymentType;
  final double productPrice;
  final double collectionPrice;
  final String finalPrice;
  final double initialPackageWeight;
  final double confirmedPackageWeight;
  final String currentStatus;
  final String clientNote;
  final String clientId;
  final String clientName;
  final String clientHubId;
  final String senderLocationId;
  final String receiverLandmark;
  final String orderReferenceId;
  final int isOpenable;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderHistory({
    this.trackingCode,
    this.receiverName,
    this.receiverContact,
    this.receiverAlternateNumber,
    this.receiverLocationId,
    this.receiverHubId,
    this.receiverAddress,
    this.productName,
    this.paymentType,
    this.productPrice,
    this.collectionPrice,
    this.finalPrice = "0",
    this.initialPackageWeight,
    this.confirmedPackageWeight,
    this.currentStatus,
    this.clientNote,
    this.clientId,
    this.clientName,
    this.clientHubId,
    this.senderLocationId,
    this.receiverLandmark,
    this.orderReferenceId,
    this.isOpenable,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      trackingCode: json['tracking_code'],
      receiverName: json['receiver_name'],
      receiverContact: json['receiver_contact'],
      receiverAlternateNumber: json['receiver_alternate_number'],
      receiverLocationId: json['receiver_location_id'],
      receiverHubId: json['receiver_hub_id'],
      receiverAddress: json['receiver_address'],
      productName: json['product_name'],
      paymentType: json['payment_type'],
      // productPrice: json['product_price'].toDouble() ??0.00,
      // collectionPrice: json['collection_price'].toDouble()??0.00,
      productPrice: 0,
      collectionPrice: 0,
      finalPrice: json['final_price'],
      // initialPackageWeight: json['initial_package_weight'].toDouble()??0.00,
      // confirmedPackageWeight: json['confirmed_package_weight'].toDouble()??0.00,
      initialPackageWeight: 0,
      confirmedPackageWeight: 0,
      currentStatus: json['current_status'],
      clientNote: json['client_note'],
      clientId: json['client_id'],
      clientName: json['client_name'],
      clientHubId: json['client_hub_id'],
      senderLocationId: json['sender_location_id'],
      receiverLandmark: json['receiver_landmark'],
      orderReferenceId: json['order_reference_id'],
      isOpenable: json['is_openable'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class OrderHistoryService {
  static Future<List<OrderHistory>> fetchOrderHistory({
    String fromDate,
    String toDate,
    String status,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null) {
      throw Exception('No token found in SharedPreferences');
    }

    Dio dio = Dio();
    dio.options.headers = {'Authorization': 'Bearer $token'};

    final response = await dio.get(
      'https://www.dashlogistics.dev/api/v1/employee/orderHistory',
      queryParameters: {
        "fromDate": fromDate,
        "toDate": toDate,
        "ssatus": status
      },
    );

    if (response.statusCode == 200) {
      List<OrderHistory> orderHistoryList = (response.data['data'] as List)
          .map((order) => OrderHistory.fromJson(order))
          .toList();
      return orderHistoryList;
    } else {
      throw Exception('Failed to load order history');
    }
  }
}

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  Future<List<OrderHistory>> futureOrderHistory;
  DateTimeRange selectedDateRange;
  String selectedStatus;

  final List<String> statusOptions = [
    "Order Verified",
    "Processing",
    "Dispatched To Hub",
    "Order Received AtHub",
    "Out For Delivery",
    "Rescheduled",
    "Delivered",
    "Cancelled",
    "Return Dispatched ToHub",
    "Return Received AtHub",
    "Returned To Client",
    "Hold",
    "Goods Damage",
    "Goods Loss",
    "Redirect To"
  ];

  final Map<String, String> statusMapping = {
    "Order Verified": "orderVerified",
    "Processing": "processing",
    "Dispatched To Hub": "dispatchedToHub",
    "Order Received AtHub": "orderReceivedAtHub",
    "Out For Delivery": "outForDelivery",
    "Rescheduled": "rescheduled",
    "Delivered": "delivered",
    "Cancelled": "cancelled",
    "Return Dispatched ToHub": "returnDispatchedToHub",
    "Return Received AtHub": "returnReceivedAtHub",
    "Returned To Client": "returnedToClient",
    "Hold": "hold",
    "Goods Damage": "goodsDamage",
    "Goods Loss": "goodsLoss",
    "Redirect To": "redirectTo"
  };

  void _fetchOrderHistory() {
    if (selectedDateRange != null && selectedStatus != null) {
      String fromDate =
          DateFormat('yyyy-MM-dd').format(selectedDateRange.start);
      String toDate = DateFormat('yyyy-MM-dd').format(selectedDateRange.end);
      String status = statusMapping[selectedStatus];
      print("$fromDate $toDate $status ");

      setState(() {
        futureOrderHistory = OrderHistoryService.fetchOrderHistory(
          fromDate: fromDate,
          toDate: toDate,
          status: status,
        );
      });
    }
  }

  void _selectDateRange() async {
    DateTimeRange picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  void _submit() {
    if (selectedDateRange == null && selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date range and status')),
      );
    } else if (selectedDateRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date range')),
      );
    } else if (selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a status')),
      );
    } else {
      _fetchOrderHistory();
    }
  }

  @override
  void initState() {
    super.initState();
    futureOrderHistory = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
          style: TextStyle(color: MyColors.primaryColor),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  onChanged: (String newValue) {
                    setState(() {
                      selectedStatus = newValue;
                    });
                  },
                  items: statusOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Status',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(),
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        onTap: _selectDateRange,
                        controller: TextEditingController(
                          text: selectedDateRange == null
                              ? 'Select Date Range'
                              : '${DateFormat('yyyy-MM-dd').format(selectedDateRange.start)} - ${DateFormat('yyyy-MM-dd').format(selectedDateRange.end)}',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors
                            .primaryColor, // Set background color to red
                      ),
                      child: Text('Submit'),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<OrderHistory>>(
              future: futureOrderHistory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(child: Text('No order history found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          leading:
                              Icon(Icons.delivery_dining, color: Colors.orange),
                          title: Text('${order.trackingCode}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('${order.receiverHubId}'   '${order.clientHubId}'),
                              Text.rich(
                                TextSpan(style:TextStyle(color: Colors.red),
                                  children: [
                                    TextSpan(text: '${order.receiverHubId}'),
                                    WidgetSpan(
                                      child: Icon(Icons.arrow_forward,
                                          size: 16), // Adjust size as needed
                                    ),
                                    TextSpan(text: ' ${order.clientHubId}'),
                                  ],
                                ),
                              ),

                              Text(
                                  '${DateFormat('yyyy-MM-dd HH:mm:ss').format(order.createdAt)}'),
                                  
                                  
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: MyColors.primaryColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PackageDetailScreen(
                                      code: order.trackingCode),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}









//       {
//     "meta": {
//         "copyright": "Dash Logistics",
//         "site": "http://localhost",
//         "emails": [
//             "info@dashlogistics.com.np"
//         ],
//         "api": {
//             "version": 1
//         },
//         "pagination": {
//             "total": 6,
//             "count": 7,
//             "per_page": 20,
//             "current_page": 1,
//             "total_pages": 1,
//             "links": []
//         }
//     },
//     "data": [
//         {
//             "tracking_code": "WIH2501KTMR8WA",
//             "receiver_name": "bbdsj",
//             "receiver_contact": "9836547511",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Kalabanjar",
//             "receiver_hub_id": "Itahari",
//             "receiver_address": "l;lolol",
//             "product_name": "6652",
//             "payment_type": "cashOnDelivery",
//             "product_price": 1000,
//             "collection_price": 600,
//             "final_price": "1000",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "loloklolo",
//             "order_reference_id": "696561000",
//             "is_openable": 0,
//             "created_at": "2025-01-21 03:44:14",
//             "updated_at": "2025-01-21 05:12:36"
//         },
//         {
//             "tracking_code": "MQC2501KTMS4P8",
//             "receiver_name": "dfsf",
//             "receiver_contact": "1234567891",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "AchhamSanfebagar",
//             "receiver_hub_id": "Achham",
//             "receiver_address": "fdsfjksd",
//             "product_name": "fdsfas",
//             "payment_type": "cashOnDelivery",
//             "product_price": 4545,
//             "collection_price": 400,
//             "final_price": "4545",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "5455",
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-23 11:53:21",
//             "updated_at": "2025-01-23 12:45:27"
//         },
//         {
//             "tracking_code": "KGM2501KTMV7YB",
//             "receiver_name": "dfsfds",
//             "receiver_contact": "1234567895",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "MahendraGufa",
//             "receiver_hub_id": "Pokhara",
//             "receiver_address": "sfdsf",
//             "product_name": "asfddf",
//             "payment_type": "cashOnDelivery",
//             "product_price": 441,
//             "collection_price": 400,
//             "final_price": "441",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "554",
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-23 12:46:42",
//             "updated_at": "2025-01-23 01:08:58"
//         },
//         {
//             "tracking_code": "NRC2501KTM0SCT",
//             "receiver_name": "LastCacheCheck",
//             "receiver_contact": "123456789",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Adarshanagar",
//             "receiver_hub_id": "Nepalgunj",
//             "receiver_address": "dfs",
//             "product_name": "LastCacheCheck",
//             "payment_type": "cashOnDelivery",
//             "product_price": 7454,
//             "collection_price": 700,
//             "final_price": "7454",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-23 02:53:48",
//             "updated_at": "2025-01-23 04:44:45"
//         },
//         {
//             "tracking_code": "QRE2501KTMTRMH",
//             "receiver_name": "newRequest",
//             "receiver_contact": "1234567894",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "AchhamSanfebagar",
//             "receiver_hub_id": "Achham",
//             "receiver_address": "sfdsf",
//             "product_name": "newRequest",
//             "payment_type": "cashOnDelivery",
//             "product_price": 4554,
//             "collection_price": null,
//             "final_price": "4554",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "outForDelivery",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-23 04:48:45",
//             "updated_at": "2025-01-24 10:39:13"
//         },
//         {
//             "tracking_code": "QRE2501KTMTRMH",
//             "receiver_name": "newRequest",
//             "receiver_contact": "1234567894",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "AchhamSanfebagar",
//             "receiver_hub_id": "Achham",
//             "receiver_address": "sfdsf",
//             "product_name": "newRequest",
//             "payment_type": "cashOnDelivery",
//             "product_price": 4554,
//             "collection_price": null,
//             "final_price": "4554",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "outForDelivery",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-23 04:48:45",
//             "updated_at": "2025-01-24 10:39:13"
//         },
//         {
//             "tracking_code": "PEB2501KTMKG70",
//             "receiver_name": "TEst",
//             "receiver_contact": "92929292929",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Kathjor",
//             "receiver_hub_id": "Manthali/Ramechhap",
//             "receiver_address": ";ksddf",
//             "product_name": "23fsdfsdf",
//             "payment_type": "cashOnDelivery",
//             "product_price": 10000,
//             "collection_price": null,
//             "final_price": "10000",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1.5,
//             "current_status": "cancelled",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": ";sdfk",
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-30 12:56:21",
//             "updated_at": "2025-01-30 01:00:03"
//         }
//     ]
// }








// {
//     "meta": {
//         "copyright": "Dash Logistics",
//         "site": "http://localhost",
//         "emails": [
//             "info@dashlogistics.com.np"
//         ],
//         "api": {
//             "version": 1
//         },
//         "pagination": {
//             "total": 26,
//             "count": 20,
//             "per_page": 20,
//             "current_page": 1,
//             "total_pages": 2,
//             "links": {
//                 "next": "https://dashlogistics.dev/api/v1/employee/orderHistory?page=2"
//             }
//         }
//     },
//     "data": [
//         {
//             "tracking_code": "BSM2501KTMZ2BF",
//             "receiver_name": "Sushil Subedi",
//             "receiver_contact": "9854210000",
//             "receiver_alternate_number": "9856421001",
//             "receiver_location_id": "Nepalgunj",
//             "receiver_hub_id": "Nepalgunj",
//             "receiver_address": "Address",
//             "product_name": "Produt3",
//             "payment_type": "cashOnDelivery",
//             "product_price": 2365,
//             "collection_price": 250,
//             "final_price": "2365",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "Landmark",
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-05 08:56:50",
//             "updated_at": "2025-01-15 08:42:30"
//         },
//         {
//             "tracking_code": "ZSQ2501KTM7594",
//             "receiver_name": "Sushil Subedi",
//             "receiver_contact": "9854210000",
//             "receiver_alternate_number": "9854210001",
//             "receiver_location_id": "Nepalgunj",
//             "receiver_hub_id": "Nepalgunj",
//             "receiver_address": "Address",
//             "product_name": "Product 123",
//             "payment_type": "cashOnDelivery",
//             "product_price": 264,
//             "collection_price": 264,
//             "final_price": "264",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": "sdfasdf sdaf",
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "Landmark",
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-05 08:55:26",
//             "updated_at": "2025-01-16 12:15:16"
//         },
//         {
//             "tracking_code": "DNA2501KTMJRD6",
//             "receiver_name": "Jenish  Acharya",
//             "receiver_contact": "9841712054",
//             "receiver_alternate_number": "9841712054",
//             "receiver_location_id": "Bhairahawa",
//             "receiver_hub_id": "Bhairahawa",
//             "receiver_address": "Devkota Chowk",
//             "product_name": "PAK062532-2081/82",
//             "payment_type": "pre-paid",
//             "product_price": 0,
//             "collection_price": 0,
//             "final_price": "0",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "Jeevee Office",
//             "order_reference_id": "JEV72778-2081/82",
//             "is_openable": 0,
//             "created_at": "2025-01-12 02:41:33",
//             "updated_at": "2025-01-16 12:38:24"
//         },
//         {
//             "tracking_code": "LWG2501KTM7WQR",
//             "receiver_name": "Sushila Tamang",
//             "receiver_contact": "9861374661",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Pokhara",
//             "receiver_hub_id": "Pokhara",
//             "receiver_address": "Gorkha Naya bazar",
//             "product_name": "NIGHT DRESS  71 KG WHITE BLACK",
//             "payment_type": "cashOnDelivery",
//             "product_price": 1600,
//             "collection_price": 700,
//             "final_price": "1600",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": "abc",
//             "is_openable": 0,
//             "created_at": "2025-01-06 03:56:15",
//             "updated_at": "2025-01-16 02:50:42"
//         },
//         {
//             "tracking_code": "XCM2501KTMO120",
//             "receiver_name": "Aniket Chaudhary",
//             "receiver_contact": "9825628805",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Pokhara",
//             "receiver_hub_id": "Pokhara",
//             "receiver_address": "abc",
//             "product_name": "abc",
//             "payment_type": "cashOnDelivery",
//             "product_price": 89,
//             "collection_price": 89,
//             "final_price": "89",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": "daio",
//             "is_openable": 0,
//             "created_at": "2025-01-06 03:56:15",
//             "updated_at": "2025-01-16 02:59:23"
//         },
//         {
//             "tracking_code": "CBY2501KTMDM9W",
//             "receiver_name": "sfda",
//             "receiver_contact": "5412574512",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Abukhaireni",
//             "receiver_hub_id": "Abukhaireni",
//             "receiver_address": "fsdsdf",
//             "product_name": "sfsd",
//             "payment_type": "cashOnDelivery",
//             "product_price": 545,
//             "collection_price": 545,
//             "final_price": "545",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 2.20000000000000017763568394002504646778106689453125,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "4545",
//             "order_reference_id": "7445",
//             "is_openable": 0,
//             "created_at": "2025-01-16 03:04:48",
//             "updated_at": "2025-01-16 03:17:12"
//         },
//         {
//             "tracking_code": "DWG2501KTMLXNC",
//             "receiver_name": "abc",
//             "receiver_contact": "9830918211",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Taplejung",
//             "receiver_hub_id": "Taplejung",
//             "receiver_address": "khumaltar",
//             "product_name": "abc",
//             "payment_type": "cashOnDelivery",
//             "product_price": 900,
//             "collection_price": 500,
//             "final_price": "900",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": "ASBSas",
//             "is_openable": 0,
//             "created_at": "2025-01-01 12:30:59",
//             "updated_at": "2025-01-16 04:43:02"
//         },
//         {
//             "tracking_code": "WQN2501KTM6S1I",
//             "receiver_name": "Aniket Chaudhary",
//             "receiver_contact": "9825628805",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Pokhara",
//             "receiver_hub_id": "Pokhara",
//             "receiver_address": "abc",
//             "product_name": "abc",
//             "payment_type": "cashOnDelivery",
//             "product_price": 931,
//             "collection_price": 930,
//             "final_price": "931",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": "rfa",
//             "is_openable": 0,
//             "created_at": "2025-01-06 03:56:15",
//             "updated_at": "2025-01-16 05:17:25"
//         },
//         {
//             "tracking_code": "GTA2501KTMN9IM",
//             "receiver_name": "shyam",
//             "receiver_contact": "9836547511",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Abukhaireni",
//             "receiver_hub_id": "Abukhaireni",
//             "receiver_address": "sfdsdf",
//             "product_name": "fsdfsd",
//             "payment_type": "cashOnDelivery",
//             "product_price": 4524,
//             "collection_price": 4500,
//             "final_price": "4524",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "dfsdf",
//             "order_reference_id": "5423565",
//             "is_openable": 0,
//             "created_at": "2025-01-21 03:44:14",
//             "updated_at": "2025-01-21 04:08:31"
//         },
//         {
//             "tracking_code": "WIH2501KTMR8WA",
//             "receiver_name": "bbdsj",
//             "receiver_contact": "9836547511",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Kalabanjar",
//             "receiver_hub_id": "Itahari",
//             "receiver_address": "l;lolol",
//             "product_name": "6652",
//             "payment_type": "cashOnDelivery",
//             "product_price": 1000,
//             "collection_price": 600,
//             "final_price": "1000",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "loloklolo",
//             "order_reference_id": "696561000",
//             "is_openable": 0,
//             "created_at": "2025-01-21 03:44:14",
//             "updated_at": "2025-01-21 05:12:36"
//         },
//         {
//             "tracking_code": "FRP2501KTM4QXS",
//             "receiver_name": "fdsdf",
//             "receiver_contact": "9854125744",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Arunkhola",
//             "receiver_hub_id": "Kawasoti",
//             "receiver_address": "fsdfsedf",
//             "product_name": "fsdsdfds",
//             "payment_type": "cashOnDelivery",
//             "product_price": 54654,
//             "collection_price": 5000,
//             "final_price": "54654",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "sdfdsf",
//             "order_reference_id": "5445454",
//             "is_openable": 0,
//             "created_at": "2025-01-21 05:15:14",
//             "updated_at": "2025-01-21 05:17:05"
//         },
//         {
//             "tracking_code": "GQW2501KTM24QW",
//             "receiver_name": "fdsdfdfd",
//             "receiver_contact": "9865741255",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Bankatti",
//             "receiver_hub_id": "SUNWAL",
//             "receiver_address": "sdfsfds",
//             "product_name": "sdfdsf",
//             "payment_type": "cashOnDelivery",
//             "product_price": 5545,
//             "collection_price": 200,
//             "final_price": "5545",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "sfsdfds",
//             "order_reference_id": "254545",
//             "is_openable": 0,
//             "created_at": "2025-01-21 05:15:14",
//             "updated_at": "2025-01-21 05:25:07"
//         },
//         {
//             "tracking_code": "RVD2501KTMZC7P",
//             "receiver_name": "Aniket Chaudhary",
//             "receiver_contact": "9825628805",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Pokhara",
//             "receiver_hub_id": "Pokhara",
//             "receiver_address": "Dhangadhi banbehada",
//             "product_name": "abc",
//             "payment_type": "pre-paid",
//             "product_price": 0,
//             "collection_price": 1,
//             "final_price": "0",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": "csa",
//             "is_openable": 1,
//             "created_at": "2025-01-06 03:56:15",
//             "updated_at": "2025-01-22 08:14:11"
//         },
//         {
            // "tracking_code": "YWB2412KTM2BR7",
            // "receiver_name": "Test by sahil",
            // "receiver_contact": "9876543120",
            // "receiver_alternate_number": null,
            // "receiver_location_id": "Kathmandu",
            // "receiver_hub_id": "Kathmandu",
            // "receiver_address": "dash",
            // "product_name": "shabcunawiefnaisnfiaskcndaslhkgsdnjfndsjafs",
            // "payment_type": "cashOnDelivery",
            // "product_price": 9898212,
            // "collection_price": 2000,
            // "final_price": "9898212",
            // "initial_package_weight": 1,
            // "confirmed_package_weight": 12,
            // "current_status": "delivered",
            // "client_note": "Can you please deliver it on urgent basis",
            // "client_id": "Test Company NB",
            // "client_name": "Sushil Subedi",
            // "client_hub_id": "Kathmandu",
            // "sender_location_id": "Kathmandu",
            // "receiver_landmark": "old baneshwor, near apex college opposite of mr. momo sahaj secutiry building ground floor dash logistics office",
            // "order_reference_id": "SR- 0111",
            // "is_openable": 0,
            // "created_at": "2024-12-31 04:32:07",
            // "updated_at": "2025-01-22 11:12:44"
//         },
//         {
//             "tracking_code": "TKV2501KTM7LZP",
//             "receiver_name": "fdsafd",
//             "receiver_contact": "4568741255",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Abukhaireni",
//             "receiver_hub_id": "Abukhaireni",
//             "receiver_address": "sfddf",
//             "product_name": "fdsffsd",
//             "payment_type": "pre-paid",
//             "product_price": 0,
//             "collection_price": 0,
//             "final_price": "0",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": "dfs",
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-22 11:34:39",
//             "updated_at": "2025-01-22 11:45:51"
//         },
//         {
//             "tracking_code": "JQS2501KTMBWOZ",
//             "receiver_name": "Test com",
//             "receiver_contact": "123465780",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "AchhamSanfebagar",
//             "receiver_hub_id": "Achham",
//             "receiver_address": "abc",
//             "product_name": "abc",
//             "payment_type": "cashOnDelivery",
//             "product_price": 980,
//             "collection_price": 200,
//             "final_price": "980",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": "1234",
//             "is_openable": 0,
//             "created_at": "2025-01-01 12:25:27",
//             "updated_at": "2025-01-22 11:46:40"
//         },
//         {
//             "tracking_code": "JVL2501KTM7G5B",
//             "receiver_name": "sdf",
//             "receiver_contact": "1254785247",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "AchhamSanfebagar",
//             "receiver_hub_id": "Achham",
//             "receiver_address": "fdfsd",
//             "product_name": "fdssd",
//             "payment_type": "cashOnDelivery",
//             "product_price": 545,
//             "collection_price": 500,
//             "final_price": "545",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-22 11:50:18",
//             "updated_at": "2025-01-22 11:51:45"
//         },
//         {
//             "tracking_code": "OMT2410KTMI2SV",
//             "receiver_name": "jfgjfj",
//             "receiver_contact": "15665165156",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Aapipal",
//             "receiver_hub_id": "Palungtar",
//             "receiver_address": "jhgg",
//             "product_name": "hgfhf",
//             "payment_type": "cashOnDelivery",
//             "product_price": 654,
//             "collection_price": 654,
//             "final_price": "654",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": "568345683",
//             "is_openable": 0,
//             "created_at": "2024-10-19 07:30:14",
//             "updated_at": "2025-01-22 11:55:14"
//         },
//         {
//             "tracking_code": "PMV2501KTM37CX",
//             "receiver_name": "fssfdsf",
//             "receiver_contact": "52456541254",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "AchhamSanfebagar",
//             "receiver_hub_id": "Achham",
//             "receiver_address": "fdsd",
//             "product_name": "fsddsfsd",
//             "payment_type": "pre-paid",
//             "product_price": 0,
//             "collection_price": 0,
//             "final_price": "0",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 2.5,
//             "current_status": "delivered",
//             "client_note": null,
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-22 11:55:45",
//             "updated_at": "2025-01-22 11:58:03"
//         },
//         {
//             "tracking_code": "OQV2501KTMVJA4",
//             "receiver_name": "Sahil Raut",
//             "receiver_contact": "12384213031",
//             "receiver_alternate_number": null,
//             "receiver_location_id": "Pokhara",
//             "receiver_hub_id": "Pokhara",
//             "receiver_address": "Pokhara",
//             "product_name": "abc",
//             "payment_type": "cashOnDelivery",
//             "product_price": 900000,
//             "collection_price": 90000,
//             "final_price": "900000",
//             "initial_package_weight": 1,
//             "confirmed_package_weight": 1.5,
//             "current_status": "delivered",
//             "client_note": "fast",
//             "client_id": "Test Company NB",
//             "client_name": "Sushil Subedi",
//             "client_hub_id": "Kathmandu",
//             "sender_location_id": "Kathmandu",
//             "receiver_landmark": null,
//             "order_reference_id": null,
//             "is_openable": 0,
//             "created_at": "2025-01-22 01:23:44",
//             "updated_at": "2025-01-22 01:29:38"
//         }
//     ]
// }
