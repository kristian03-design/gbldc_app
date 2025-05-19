import 'package:flutter/material.dart';

void main() {
  runApp(HelpSupportApp());
}

class HelpSupportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelpSupportPage(),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  final List<String> items = [
    "FAQ",
    "Contact Support",
    "Privacy Policy",
    "Terms of Service",
    "Accessibility",
    "Feedback",
    "About us",
    "Rate us",
    "Visit Our Website",
    "Follow us on Social Media",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.8,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // back navigation
          },
        ),
        title: Text(
          "Help & Support",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  items[index],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                onTap: () {
                  // Add navigation or action here
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
