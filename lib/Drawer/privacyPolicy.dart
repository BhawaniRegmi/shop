import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
          "Privacy Policy",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Introduction"),
            _buildSectionContent(
              "E-Commerce market is growing in Nepal and every E-commerce needs a trustworthy Last Mile Delivery partner which plays the most important role to run their business successfully. Dash Logistics will play a key role in systematic domestic delivery service for E-Commerce and other business houses as a Last Mile Delivery service provider.",
            ),
            _buildSectionTitle("Information Collection"),
            _buildSectionContent(
              "We may collect personal information such as your name, email address, and phone number when you fill out a form on our website or sign up for our newsletter. We may also collect information about your device, including your IP address, browser type, and operating system.",
            ),
            _buildSectionTitle("Information Use"),
            _buildSectionContent(
              "We use your personal information to respond to your requests, improve our website, and communicate with you. We may also use your information to provide you with updates about our products and services.",
            ),
            _buildSectionTitle("Information Sharing"),
            _buildSectionContent(
              "We do not share your personal information with third parties except as required by law or to protect our website and users from fraudulent activities.",
            ),
            _buildSectionTitle("Cookies"),
            _buildSectionContent(
              "Our website uses cookies to improve your experience and personalize content. Cookies are small data files that are stored on your device and help us recognize you when you return to our website.",
            ),
            _buildSectionTitle("Security"),
            _buildSectionContent(
              "We take reasonable measures to protect your personal information from unauthorized access, disclosure, or use. However, no transmission of data over the internet is completely secure, and we cannot guarantee the security of your information.",
            ),
            _buildSectionTitle("Children's Privacy"),
            _buildSectionContent(
              "Our website is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13.",
            ),
            _buildSectionTitle("Changes to this Privacy Policy"),
            _buildSectionContent(
              "We may update this privacy policy from time to time. We will notify you of any material changes to the policy by posting the updated policy on our website.",
            ),
            _buildSectionTitle("Contact Us"),
            _buildSectionContent(
              "If you have any questions or concerns about this privacy policy, please contact us at 9801878727 or email us at dash.operation@gmail.com.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6200EE), // Dark purple color for titles
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
          height: 1.6, // Improve line spacing for readability
        ),
      ),
    );
  }
}
