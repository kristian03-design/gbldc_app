import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'online_application_step4.dart';
void main() => runApp(const MaterialApp(
  home: EmergencyContactsPage(),
  debugShowCheckedModeBanner: false,
));

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController1 = TextEditingController();
  final TextEditingController emailController1 = TextEditingController();
  final TextEditingController addressController1 = TextEditingController();

  final TextEditingController nameController2 = TextEditingController();
  final TextEditingController emailController2 = TextEditingController();
  final TextEditingController addressController2 = TextEditingController();

  String? selectedRelationship1;
  String? selectedRelationship2;
  String? phoneNumber1;
  String? phoneNumber2;

  final List<String> relationships = [
    'Parent',
    'Sibling',
    'Spouse',
    'Friend',
    'Relative',
    'Colleague'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.arrow_back),
                    Text("3 / 5", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 10),
                const LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Emergency Contacts",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please provide details of two trusted contacts. We’ll only reach out to them in case of emergencies related to your loan.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Emergency Contact 1",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                _buildLabel("Contact's Full Name"),
                _buildInput(
                  controller: nameController1,
                  hint: "Enter contact's full name",
                  validator: (value) =>
                  value!.isEmpty ? "Full name is required" : null,
                ),

                const SizedBox(height: 20),

                _buildLabel("Relationship to User"),
                DropdownButtonFormField<String>(
                  value: selectedRelationship1,
                  hint: const Text("Select relationship to you"),
                  items: relationships
                      .map((relation) => DropdownMenuItem(
                    value: relation,
                    child: Text(relation),
                  ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedRelationship1 = value),
                  decoration: _inputDecoration(),
                  validator: (value) =>
                  value == null ? "Please select a relationship" : null,
                ),
                const SizedBox(height: 20),

                _buildLabel("Phone Number"),
                IntlPhoneField(
                  decoration: _inputDecoration(
                    hint: 'Phone Number',
                  ),
                  initialCountryCode: 'PH',
                  onChanged: (phone) {
                    phoneNumber1 = phone.completeNumber;
                  },
                  validator: (value) {
                    if (value == null || value.number.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                _buildLabel("Contact's Email Address"),
                _buildInput(
                  controller: emailController1,
                  hint: "Enter contact's email address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                  value!.isEmpty ? "Email is required" : null,
                ),
                const SizedBox(height: 20),

                _buildLabel("Home Address"),
                _buildInput(
                  controller: addressController1,
                  hint: "Enter contact's home address",
                  validator: (value) =>
                  value!.isEmpty ? "Address is required" : null,
                ),
                const SizedBox(height: 30),

                const Text(
                  "Emergency Contact 2",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                _buildLabel("Contact's Full Name"),
                _buildInput(
                  controller: nameController2,
                  hint: "Enter contact's full name",
                  validator: (value) =>
                  value!.isEmpty ? "Full name is required" : null,
                ),

                const SizedBox(height: 20),

                _buildLabel("Relationship to User"),
                DropdownButtonFormField<String>(
                  value: selectedRelationship2,
                  hint: const Text("Select relationship to you"),
                  items: relationships
                      .map((relation) => DropdownMenuItem(
                    value: relation,
                    child: Text(relation),
                  ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedRelationship2 = value),
                  decoration: _inputDecoration(),
                  validator: (value) =>
                  value == null ? "Please select a relationship" : null,
                ),
                const SizedBox(height: 20),

                _buildLabel("Phone Number"),
                IntlPhoneField(
                  decoration: _inputDecoration(
                    hint: 'Phone Number',
                  ),
                  initialCountryCode: 'PH',
                  onChanged: (phone) {
                    phoneNumber2 = phone.completeNumber;
                  },
                  validator: (value) {
                    if (value == null || value.number.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                _buildLabel("Contact's Email Address"),
                _buildInput(
                  controller: emailController2,
                  hint: "Enter contact's email address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                  value!.isEmpty ? "Email is required" : null,
                ),
                const SizedBox(height: 20),

                _buildLabel("Home Address"),
                _buildInput(
                  controller: addressController2,
                  hint: "Enter contact's home address",
                  validator: (value) =>
                  value!.isEmpty ? "Address is required" : null,
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                          MaterialPageRoute(builder: (context) => IDCardUploadScreen())
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Continue",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600));
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: _inputDecoration(hint: hint),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
