import 'package:flutter/material.dart';

class RateAppScreen extends StatefulWidget {
  @override
  _RateAppScreenState createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  int _rating = 0;
  final List<String> _feedbackTexts = ["Poor", "Fair", "Good", "Very Good", "Excellent"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        title: Text(
          "Rate Application",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "How would you rate this app?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.star,
                      size: 40,
                      color: index < _rating ? Colors.amber : Colors.grey[400],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Text(
                _rating > 0 ? _feedbackTexts[_rating - 1] : "Tap a star to rate",
                key: ValueKey(_rating),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _rating > 0
                  ? () {
                      // Handle submit logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Thank you for your feedback!")),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Submit"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red[50],
    );
  }
}
