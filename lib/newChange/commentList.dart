
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // For formatting date and time

// class CommentList extends StatefulWidget {
//   @override
//   State<CommentList> createState() => _CommentListState();
// }

// class _CommentListState extends State<CommentList> {
//   final List<Map<String, String>> notifications = [
//     {
//       "title": "D-038391",
//       "date": "Sep 05 2022",
//       "time": "14:35 PM"
//     },
//     {
//       "title": "D-037770",
//       "date": "Sep 02 2022",
//       "time": "18:11 PM"
//     },
//     {
//       "title": "D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },
//        {
//       "title": "D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },   {
//       "title": "D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },   {
//       "title": "D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },   {
//       "title": "D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },   {
//       "title": "D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },   {
//       "title": "D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },   {
//       "title": "D-037322",
//       "date": "Aug 31 2022",
//       "time": "13:07 PM"
//     },
    
//     // Add more initial comments if needed
//   ];

//   void _opentab(BuildContext context) {
//     // Function to open the detail dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Comment Detail",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//               SizedBox(height: 7.2),
//               Text("For D-038391"),
//               SizedBox(height: 1),
//               Text("Product Out of Stock"),
//               SizedBox(height: 1),
//               Text("By Ravi Giri"),
//               SizedBox(height: 1),
//               Text("Aug 18 2024"),
//               SizedBox(height: 1),
//               Text("15:23 PM"),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Close"),
//             ),
//             TextButton(
//               onPressed: () {
//                _addReplyDialog(context);
//               },
//               child: Text("Reply"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//     void _addReplyDialog(BuildContext context) {
//     final TextEditingController commentController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Reply"),
//           content: TextField(
//           controller: commentController,
//           decoration: InputDecoration(
//             hintText: "Enter your Reply",
//             border: OutlineInputBorder(),
//           ),
//           maxLines: 3, // Allows the TextField to grow as needed for multiline input
//         ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Send"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _addCommentDialog(BuildContext context) {
//     final TextEditingController commentController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Add Comment"),
//           content: TextField(
//           controller: commentController,
//           decoration: InputDecoration(
//             hintText: "Enter your comment",
//             border: OutlineInputBorder(),
//           ),
//           maxLines: 3, // Allows the TextField to grow as needed for multiline input
//         ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 final String commentText = commentController.text;
//                 if (commentText.isNotEmpty) {
//                   // Add the comment to the notifications list
//                   setState(() {
//                     notifications.add({
//                       "title": commentText,
//                       "date": DateFormat('MMM dd yyyy').format(DateTime.now()),
//                       "time": DateFormat('HH:mm a').format(DateTime.now()),
//                     });
//                   });
//                   Navigator.of(context).pop(); // Close the dialog
//                 }
//               },
//               child: Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Comments"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: notifications.map((notification) {
//             return GestureDetector(
//               onTap: () {
//                 _opentab(context);
//               },
//               child: Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 child: ListTile(
//                   title: Text(
//                     notification["title"] ?? "",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     "Ravi Giri",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   trailing: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(notification["date"] ?? ""),
//                       SizedBox(height: 4),
//                       Text(notification["time"] ?? ""),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _addCommentDialog(context); // Open the dialog to add a comment
//         },
//         child: Icon(Icons.add),
//         tooltip: "Add Comment",
//       ),
//     );
//   }
// }



// all working code else than cache and pagination
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';

// class CommentList extends StatefulWidget {
//   final String trackingCode;
//   CommentList({ this.trackingCode});

//   @override
//   State<CommentList> createState() => _CommentListState();
// }

// class _CommentListState extends State<CommentList> {
//   List<Map<String, dynamic>> comments = [];
//   bool isLoading = false;

//   Future<String> getToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   Future<void> fetchComments() async {
//     setState(() {
//       isLoading = true;
//     });

//     final String token = await getToken();

//     if (token == null || token.isEmpty) {
//       print("Bearer token is not available. Please login to obtain the token.");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please log in to continue.")),
//       );
//       setState(() {
//         isLoading = false;
//       });
//       return;
//     }

//     try {
//       final Dio dio = Dio();
//       final response = await dio.get(
//         'https://dashlogistics.dev/api/v1/employee/ordercomment',
//         queryParameters: {
//           'trackingCcode': widget.trackingCode,
//           'page': 1,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           comments = List<Map<String, dynamic>>.from(response.data['data']);
//         });
//         print("Comments fetched successfully: ${response.data}");
//       } else {
//         print("Failed to fetch comments: ${response.statusMessage}");
//       }
//     } catch (e) {
//       print("Error occurred while fetching comments: $e");
//       if (e is DioError && e.response?.statusCode == 401) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Session expired. Please log in again.")),
//         );
//       }
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchComments();
//   }

//   void _showCommentDetails(Map<String, dynamic> comment) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Comment Detail",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//               SizedBox(height: 7.2),
//               Text("For Order ID: ${comment['orderId'] ?? ''}"),
//               SizedBox(height: 1),
//               Text(comment['comment'] ?? "No comment"),
//               SizedBox(height: 1),
//               Text("By: ${comment['commentBy'] ?? "Unknown"}"),
//               SizedBox(height: 1),
//               Text(comment['createdAt'] ?? ""),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Close"),
//             ),
//             TextButton(
//               onPressed: () {
//                 _addReplyDialog(context);
//               },
//               child: Text("Reply"),
//             ),
//           ],
//         );
//       },
//     );
//   }




// Map<String, String> getFormattedDateAndTime(String responseDate) {
//   // Parse the date string
//   DateFormat inputFormat = DateFormat("d MMM yyyy HH:mm:ss");
//   DateTime parsedDate = inputFormat.parse(responseDate);

//   // Format the date and time separately
//   String formattedDate = DateFormat('d MMM yyyy').format(parsedDate);
//   String formattedTime = DateFormat('HH:mm:ss').format(parsedDate);

//   return {
//     'date': formattedDate,
//     'time': formattedTime,
//   };
// }


//   void _addReplyDialog(BuildContext context) {
//     final TextEditingController commentController = TextEditingController();
//     final scaffoldMessenger = ScaffoldMessenger.of(context);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Reply"),
//           content: TextField(
//             controller: commentController,
//             decoration: InputDecoration(
//               hintText: "Enter your Reply",
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 3,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 final reply = commentController.text.trim();
//                 if (reply.isEmpty) {
//                   scaffoldMessenger.showSnackBar(
//                     SnackBar(content: Text("Reply cannot be empty.")),
//                   );
//                   return;
//                 }

//                 Navigator.of(context).pop();

//                 try {
//                   final String token = await getToken();

//                   if (token == null || token.isEmpty) {
//                     scaffoldMessenger.showSnackBar(
//                       SnackBar(content: Text("Please log in to continue.")),
//                     );
//                     return;
//                   }

//                   final Dio dio = Dio();
//                   final requestData = {
//                     "trackingCode": widget.trackingCode,
//                     "comment": reply,
//                   };

//                   print("Request Data: $requestData");

//                   final response = await dio.post(
//                     'https://dashlogistics.dev/api/v1/employee/ordercomment',
//                     data: requestData,
//                     options: Options(
//                       headers: {
//                         'Authorization': 'Bearer $token',
//                         'Content-Type': 'application/json',
//                       },
//                     ),
//                   );

//                   print("Response: ${response.statusCode}, Body: ${response.data}");

//                   if (response.statusCode == 200 || response.statusCode == 201) {
//                     scaffoldMessenger.showSnackBar(
//                       SnackBar(content: Text("Reply sent successfully!")),
//                     );
//                     fetchComments();
//                   } else {
//                     scaffoldMessenger.showSnackBar(
//                       SnackBar(content: Text("Failed to send reply.")),
//                     );
//                   }
//                 } catch (e) {
//                   print("Error while sending reply: $e");
//                   scaffoldMessenger.showSnackBar(
//                     SnackBar(content: Text("An error occurred while sending the reply.")),
//                   );
//                 }
//               },
//               child: Text("Send"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Comments"),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: comments.length,
//               itemBuilder: (context, index) {
//                 final comment = comments[index];
//                 Map<String, String> result = getFormattedDateAndTime(comment['createdAt'] ?? "");
//                 return GestureDetector(
//                   onTap: () {
//                     _showCommentDetails(comment);
//                   },
//                   child: Card(
//                     elevation: 2,
//                     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     child: ListTile(
//                       title: Text(
//                         "Tracking Code: ${widget.trackingCode ?? "Unknown"}",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(comment['commentBy'] ?? "Unknown"),
//                       trailing: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text("Date: ${result['date']}"), 
//                           Text("Time: ${result['time']}"), 
                         
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }










//every thing working perfectly but loading even no more data is present making unneccesary pagination 
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CommentList extends StatefulWidget {
  final String trackingCode;
  CommentList({this.trackingCode});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  List<Map<String, dynamic>> comments = [];
  bool isLoading = false;
  int currentPage = 1;
  bool hasMore = true;
  ScrollController _scrollController = ScrollController();
  bool showScrollToTopButton = false;

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }




Future<void> fetchComments({bool refresh = false}) async {
  if (isLoading) return; // Prevent duplicate requests if already loading.

  setState(() {
    isLoading = true; // Start loading.
  });

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await getToken();

  if (token == null || token.isEmpty) {
    print("Bearer token is not available. Please login to obtain the token.");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please log in to continue.")),
    );
    setState(() {
      isLoading = false; // Stop loading.
    });
    return;
  }

  try {
    // Always load data from the server, ignoring any cached data.
    final Dio dio = Dio();
    print('Tracking Code: ${widget.trackingCode}');
    final response = await dio.get(
      'https://dashlogistics.dev/api/v1/employee/ordercomment',
      queryParameters: {
        'trackingCcode': widget.trackingCode,
        'page': currentPage,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> newComments = List<Map<String, dynamic>>.from(response.data['data']);
      comments = newComments; // Replace old comments with new ones.
      hasMore = newComments.isNotEmpty; // Check if there are more comments to fetch.

      // Cache the latest comments.
      prefs.setStringList(
        'cachedComments',
        comments.map((e) => e.toUriEncodedString()).toList(),
      );
    } else {
      print("Failed to fetch comments: ${response.statusMessage}");
    }
  } catch (e) {
    print("Error occurred while fetching comments: $e");
    if (e is DioError && e.response?.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Session expired. Please log in again.")),
      );
    }
  } finally {
    setState(() {
      isLoading = false; // Stop the loader regardless of success or failure.
      hasMore = false; // Prevent further pagination if desired.
    });
  }
}


@override
void initState() {
  super.initState();
  fetchComments();

  _scrollController.addListener(() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        hasMore && // Pagination disabled once data is fetched.
        !isLoading) {
      // Pagination logic removed.
    }

    if (_scrollController.offset > 200) {
      setState(() {
        showScrollToTopButton = true;
      });
    } else {
      setState(() {
        showScrollToTopButton = false;
      });
    }
  });
}





  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

 



void _showCommentDetails(Map<String, dynamic> comment) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        title: Center(
          child: Text(
            "Comment Detail",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.blueAccent,
            ),
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow("Tracking Code:", widget.trackingCode ?? "N/A"),
            SizedBox(height: 8),
            _buildDetailRow("Comment:", comment['comment'] ?? "No Comment"),
            SizedBox(height: 8),
            _buildDetailRow("By:", comment['commentBy'] ?? "Unknown"),
            SizedBox(height: 8),
            _buildDetailRow(
              "Date:",
              comment['createdAt'] ?? "",
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Close",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              _addReplyDialog(context);
            },
            child: Text(
              "Reply",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}

  Map<String, String> getFormattedDateAndTime(String responseDate) {
    DateFormat inputFormat = DateFormat("d MMM yyyy HH:mm:ss");
    DateTime parsedDate = inputFormat.parse(responseDate);

    String formattedDate = DateFormat('d MMM yyyy').format(parsedDate);
    String formattedTime = DateFormat('HH:mm:ss').format(parsedDate);

    return {
      'date': formattedDate,
      'time': formattedTime,
    };
  }

  void _addReplyDialog(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reply"),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: "Enter your Reply",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final reply = commentController.text.trim();
                if (reply.isEmpty) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text("Reply cannot be empty.")),
                  );
                  return;
                }

                Navigator.of(context).pop();
                Navigator.of(context).pop();

                try {
                  final String token = await getToken();

                  if (token == null || token.isEmpty) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text("Please log in to continue.")),
                    );
                    return;
                  }

                  final Dio dio = Dio();
                  final requestData = {
                    "trackingCode": widget.trackingCode,
                    "comment": reply,
                  };

                  print("Request Data: $requestData");

                  final response = await dio.post(
                    'https://dashlogistics.dev/api/v1/employee/ordercomment',
                    data: requestData,
                    options: Options(
                      headers: {
                        'Authorization': 'Bearer $token',
                        'Content-Type': 'application/json',
                      },
                    ),
                  );

                  print("Response: ${response.statusCode}, Body: ${response.data}");

                  if (response.statusCode == 200 || response.statusCode == 201) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text("Reply sent successfully!")),
                    );
                    fetchComments(refresh: true);
                  } else {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text("Failed to send reply.")),
                    );
                  }
                } catch (e) {
                  print("Error while sending reply: $e");
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text("An error occurred while sending the reply.")),
                  );
                }
              },
              child: Text("Send"),
            ),
          ],
        );
      },
    );
  }




// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.white, // Set AppBar color to white
//       iconTheme: IconThemeData(color: Colors.black), // Set back arrow color to black
//       title: Text(
//         "Comments",
//         style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
//       ),
//       elevation: 1, // Add a subtle shadow for the AppBar
//     ),
//     body: isLoading && comments.isEmpty
//         ? Center(child: CircularProgressIndicator())
//         : Stack(
//             children: [
//               ListView.builder(
//                 controller: _scrollController,
//                 itemCount: comments.length + (hasMore ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index == comments.length) {
//                     return Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   }

//                   final comment = comments[index];
//                   Map<String, String> result =
//                       getFormattedDateAndTime(comment['createdAt'] ?? "");

//                   return GestureDetector(
//                     onTap: () {
//                       _showCommentDetails(comment);
//                     },
//                     child: Card(
//                       elevation: 4,
//                       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12), // Rounded corners
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Tracking Code: ${widget.trackingCode ?? "Unknown"}",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               comment['commentBy'] ?? "Unknown",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Date: ${result['date']}",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Time: ${result['time']}",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               if (showScrollToTopButton)
//                 Positioned(
//                   bottom: 20,
//                   right: 20,
//                   child: FloatingActionButton(
//                     onPressed: scrollToTop,
//                     backgroundColor: Colors.red,
//                     child: Icon(Icons.arrow_upward, color: Colors.white),
//                   ),
//                 ),
//             ],
//           ),
//   );
// }



@override
Widget build(BuildContext context) {
  return Scaffold(
       appBar: AppBar(
      backgroundColor: Colors.white, // Set AppBar color to white
      iconTheme: IconThemeData(color: Colors.black), // Set back arrow color to black
      title: Text(
        "Comments",
        style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      elevation: 1, // Add a subtle shadow for the AppBar
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator()) // Loading state
        : comments.isEmpty // If no comments are present
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container with message and IconButton
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Currently, no comments are present.',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
GestureDetector(
  onTap: () {
    // Handle comment creation
    _addReplyDialog(context);
  },
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 15), // Margin on left and right
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjusted padding
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.red, width: 2),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.add_comment,
          size: 30.0, // Reduced icon size
          color: Colors.red,
        ),
        SizedBox(width: 8),
        Text(
          'Add Comment',
          style: TextStyle(
            fontSize: 16.0, // Reduced text size
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    ),
  ),
)



                  ],
                ),
              )
            :   ListView.builder(
                controller: _scrollController,
                itemCount: comments.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == comments.length) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final comment = comments[index];
                  Map<String, String> result =
                      getFormattedDateAndTime(comment['createdAt'] ?? "");

                  return GestureDetector(
                    onTap: () {
                      _showCommentDetails(comment);
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tracking Code: ${widget.trackingCode ?? "Unknown"}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              comment['commentBy'] ?? "Unknown",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date: ${result['date']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  "Time: ${result['time']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
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
    floatingActionButton: showScrollToTopButton
        ? FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: () {
              _scrollController.animateTo(0,
                  duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          )
        : null,
  );
}


}

extension UriEncodable on Map<String, dynamic> {
  String toUriEncodedString() => Uri.encodeComponent(this.toString());
}

extension UriDecodable on String {
  Map<String, dynamic> toDecodedMap() {
    try {
      String decoded = Uri.decodeComponent(this);
      decoded = decoded.replaceAll("{", "").replaceAll("}", "");
      return Map.fromEntries(
        decoded.split(", ").map((e) {
          final split = e.split(": ");
          return MapEntry(split[0].trim(), split[1].trim());
        }),
      );
    } catch (e) {
      print("Failed to decode string to map: $e");
      return {};
    }
  }
}
