import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'online_application_step5_nextscreen.dart';

class SelfieWithIDCardScreen extends StatefulWidget {
  const SelfieWithIDCardScreen({super.key});

  @override
  State<SelfieWithIDCardScreen> createState() => _SelfieWithIDCardScreenState();
}

class _SelfieWithIDCardScreenState extends State<SelfieWithIDCardScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _takeSelfie() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final File selfie = File(photo.path);

      // Navigate to next screen and pass the selfie
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SelfiePreviewScreen(selfie: selfie),
        ),
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
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/images/selfie_illustration.jpg',
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _takeSelfie,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Take Selfie",
                  style: TextStyle(fontSize: 16, color: Colors.white),
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
