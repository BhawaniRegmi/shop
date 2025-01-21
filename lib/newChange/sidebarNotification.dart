import 'package:flutter/material.dart';

class SideBarNotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "title": "New Comment Received For D-038391",
      "date": "Sep 05 2022",
      "time": "14:35 PM"
    },
    {
      "title": "New Comment Received For D-037770",
      "date": "Sep 02 2022",
      "time": "18:11 PM"
    },
    {
      "title": "New Comment Received For D-037322",
      "date": "Aug 31 2022",
      "time": "13:07 PM"
    },
    {
      "title": "New Comment Received For D-036126",
      "date": "Aug 18 2022",
      "time": "13:36 PM"
    },
    {
      "title": "New Comment Received For D-036126",
      "date": "Aug 17 2022",
      "time": "17:45 PM"
    },
    {
      "title": "New Comment Received For D-020369",
      "date": "May 08 2022",
      "time": "15:23 PM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    void _addReplyDialog(BuildContext context) {
      final TextEditingController commentController = TextEditingController();

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
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("Send"),
              ),
            ],
          );
        },
      );
    }

    void _opentab() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Notification Detail",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 7.2),
                Text("For D-038391"),
                Text("Product Out of Stock"),
                Text("Aug 18 2024"),
                Text("15:23 PM"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("Close"),
              ),
              TextButton(
                onPressed: () {
                  _addReplyDialog(context);
                },
                child: Text("Reply"),
              ),
            ],
          );
        },
      );
    }

    List<Widget> notificationWidgets = notifications.map((notification) {
      return MaterialButton(
        onPressed: () {
          _opentab();
        },
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 1.8),
          child: ListTile(
            title: Text(
              notification["title"] ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Comment"),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(notification["date"] ?? ""),
                SizedBox(height: 4),
                Text(notification["time"] ?? ""),
              ],
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: notificationWidgets,
        ),
      ),
    );
  }
}
