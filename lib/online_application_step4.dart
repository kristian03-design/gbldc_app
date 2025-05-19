import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'online_application_step4_nextscreen.dart';

void main() {
  runApp(const MaterialApp(
    home: IDCardUploadScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class IDCardUploadScreen extends StatefulWidget {
  const IDCardUploadScreen({super.key});

  @override
  State<IDCardUploadScreen> createState() => _IDCardUploadScreenState();
}

class _IDCardUploadScreenState extends State<IDCardUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final File file = File(photo.path);
      setState(() {
        _image = file;
      });

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NextScreen(imageFile: file),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "4 / 5",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LinearProgressIndicator(
              value: 0.8,
              color: Colors.green,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              "Upload ID Card Photo",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please upload clear photos of your ID card. This step is crucial for verifying your identity and securing your account.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/id_card_example.jpeg',
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        "Correct",
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Wrong Example",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/id_card_dark.jpeg',
                        height: 80,
                      ),
                      const SizedBox(height: 4),
                      const Text("Dark"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/id_card_blur.png',
                        height: 80,
                      ),
                      const SizedBox(height: 4),
                      const Text("Blur"),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _takePhoto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Take Photo",
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
