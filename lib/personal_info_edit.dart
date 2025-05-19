import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:country_picker/country_picker.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoEditPage extends StatefulWidget {
  @override
  _PersonalInfoEditPageState createState() => _PersonalInfoEditPageState();
}

class _PersonalInfoEditPageState extends State<PersonalInfoEditPage> {
  final TextEditingController _nameController =
      TextEditingController(text: "Kristian Lloyd Hernandez");
  final TextEditingController _phoneController =
      TextEditingController(text: "9123456789");
  final TextEditingController _emailController =
      TextEditingController(text: "hkristianlloyd2@gmail.com");
  final TextEditingController _dobController = TextEditingController();

  String _selectedGender = "Male";
  DateTime? _selectedDate;

  late Country _selectedCountry;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedCountry = Country.parse('PH'); // Proper initialization here
    if (_selectedDate != null) {
      _dobController.text = DateFormat('MM-dd-yyyy').format(_selectedDate!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  String getFullPhoneNumber() {
    String phone = _phoneController.text.trim();
    if (phone.startsWith('0')) {
      phone = phone.substring(1); // remove leading 0 if present
    }
    return '+${_selectedCountry.phoneCode} $phone';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Personal Info'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Avatar with editable functionality
            Stack(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : AssetImage('assets/images/2x2.jpg') as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 14,
                      child: Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Full Name
            _buildTextField(label: 'Full Name', controller: _nameController),

            // Phone Number with Country Picker
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            _selectedCountry = country;
                          });
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        _selectedCountry.flagEmoji,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            // Email
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              prefixIcon: Icon(Icons.alternate_email),
            ),

            // Gender
            _buildDropdownField(
              label: 'Gender',
              value: _selectedGender,
              items: ['Male', 'Female', 'Other'],
              onChanged: (value) => setState(() => _selectedGender = value!),
            ),

            // Date of Birth
            _buildDatePickerField(
              label: 'Date of Birth',
              controller: _dobController,
              onTap: () async {
                DateTime initialDate = _selectedDate ?? DateTime(1995, 12, 27);
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                    _dobController.text =
                        DateFormat('MM-dd-yyyy').format(picked);
                  });
                }
              },
            ),

            SizedBox(height: 30),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),

                // Save Changes Button
                ElevatedButton(
                  onPressed: () {
                    // Example save logic: print values and show snackbar
                    print('Name: ${_nameController.text}');
                    print('Phone: ${getFullPhoneNumber()}');
                    print('Email: ${_emailController.text}');
                    print('Gender: $_selectedGender');
                    print('DOB: ${_dobController.text}');

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Changes saved!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Save Changes',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    Widget? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        readOnly: true,
        onTap: onTap,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
