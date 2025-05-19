import 'dart:io';
import 'package:flutter/material.dart';
import 'landing_page.dart';

class SelfiePreviewScreen extends StatelessWidget {
  final File selfie;

  const SelfiePreviewScreen({super.key, required this.selfie});

  Future<void> _submitApplication(BuildContext context) async {
    // Step 1: Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.green),
            SizedBox(height: 20),
            Text("Submitting application..."),
          ],
        ),
      ),
    );

    // Simulate loading (e.g., uploading)
    await Future.delayed(const Duration(seconds: 2));

    // Step 2: Replace dialog with success check
    if (context.mounted) {
      Navigator.pop(context); // Close loading dialog

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 20),
              Text("Application submitted!"),
            ],
          ),
        ),
      );
    }

    // Step 3: Delay and navigate to landing page
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      Navigator.pop(context); // Close success dialog

      // Navigate to Landing Page (replace with your actual screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LandingPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "5 / 5",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LinearProgressIndicator(
              value: 1.0,
              color: Colors.green,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              "Selfie with ID Card",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Take a selfie holding your ID card next to your face. Ensure your face and ID card are clearly visible.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  selfie,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _submitApplication(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Submit Application",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
