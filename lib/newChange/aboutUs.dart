import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        title: Text(
          "About Us",
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("About Dash Logistics"),
              SizedBox(height: 10),
              _buildSectionContent(
                "Dash Logistics aims to build an operating system for commerce in Nepal by providing Parcel Transportation, Warehousing, Reverse Logistics, B2B Logistics, Cross-Border Shipping & Record Management Services to Nepal’s growing e-commerce sector & leading business enterprises. As a way to connect the country through domestic logistics and transportation services, we will be focusing on E-Commerce Last Mile Delivery that would assist start-ups to get their packages out seamlessly and uniformly using the latest technology & providing everything from storage of their products to order fulfillment through effective supply chain management.",
              ),
              SizedBox(height: 30),
              _buildSectionTitle("Who We Are?"),
              SizedBox(height: 10),
              _buildSectionContent(
                "Dash logistics is not just a company but is a team of well-experienced professionals working in the field of last mile delivery for many years & We are committed to continue enhancing the logistics operations across the country. The company has different hierarchy of work flow from High profile shareholders, Top level management teams in the board as Board of Directors, Best managerial skilled Managers & Operation heads, Smart and Confident administrative & Business Development team, Tirelessly working dispatch departments who work sharply in sorting parcels and make ready for dispatch with no mistakes, Researched and selected highly professional contracted transportation companies & airlines and last but not the least our most important and key team members that are our delivery riders who help us to drop parcels till the door of customers and help us making our last mile delivery successful.",
              ),
              SizedBox(height: 30),
              _buildImageSection(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.red[50],
    );
  }

  // Helper method to create the title section
  Widget _buildSectionTitle(String title) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  // Helper method to create the content section with a little animation
  Widget _buildSectionContent(String content) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Text(
        content,
        style: TextStyle(fontSize: 16, color: Colors.black87),
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Helper method to add an image for visual interest
  Widget _buildImageSection() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Column(
        children: [
          Image.asset(
            'assets/images/dashLogo.png', // Replace with your image asset
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            "Dash Logistics Operations in Action",
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
