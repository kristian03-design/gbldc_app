import 'package:flutter/material.dart';
import 'online_application_step2.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // <-- Added for phone input

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  final TextEditingController yearsOfStayController = TextEditingController();

  String? selectedSalutation;
  String? selectedGender;
  String? selectedCivilStatus;
  String? selectedReligion;
  String? selectedNationality;

  final List<String> religions = [
    'Roman Catholic',
    'Islam',
    'Iglesia ni Cristo',
    'Evangelical',
    'Buddhism',
    'Hinduism',
    'Other'
  ];

  final List<String> nationalities = ['Filipino', 'American', 'Other'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 12, 27),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String fullAddress = [
          place.street,
          place.locality,
          place.administrativeArea,
          place.country
        ].where((e) => e != null && e.isNotEmpty).join(', ');

        setState(() {
          addressController.text = fullAddress;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get address: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.arrow_back, size: 24),
                    Text("1 / 5", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 10),
                const LinearProgressIndicator(
                  value: 0.3,
                  color: Colors.green,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Personal Information",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 8),
                const Text(
                  "We need some basic information to determine your loan eligibility. Your data is safe with us.",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 30),
                _buildLabel("Salutation"),
                _buildDropdown(
                  value: selectedSalutation,
                  items: ['Mr.', 'Ms.', 'Mrs.', 'Dr.'],
                  onChanged: (value) =>
                      setState(() => selectedSalutation = value),
                  hint: 'Select salutation',
                ),
                const SizedBox(height: 20),
                _buildLabel("Full Name"),
                _buildInput(
                  controller: fullNameController,
                  hint: "Enter your full name",
                  validator: (value) =>
                      value!.isEmpty ? 'Full name is required' : null,
                ),
                const SizedBox(height: 20),
                _buildLabel("Gender"),
                _buildDropdown(
                  value: selectedGender,
                  items: ['Male', 'Female', 'Other'],
                  onChanged: (value) => setState(() => selectedGender = value),
                  hint: 'Select gender',
                ),
                const SizedBox(height: 20),
                _buildLabel("Civil Status"),
                _buildDropdown(
                  value: selectedCivilStatus,
                  items: ['Single', 'Married', 'Divorced', 'Widowed'],
                  onChanged: (value) =>
                      setState(() => selectedCivilStatus = value),
                  hint: 'Select civil status',
                ),
                const SizedBox(height: 20),
                _buildLabel("Date of Birth"),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: _buildInput(
                      controller: dobController,
                      hint: "DD-MM-YYYY",
                      suffixIcon: Icons.calendar_today,
                      validator: (value) =>
                          value!.isEmpty ? 'Date of birth is required' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildLabel("Place of Birth"),
                _buildInput(
                  controller: birthPlaceController,
                  hint: "Enter your place of birth",
                ),
                const SizedBox(height: 20),
                _buildLabel("Email Address"),
                _buildInput(
                  controller: emailController,
                  hint: "Enter your email address",
                  validator: (value) =>
                      value!.isEmpty ? 'Email is required' : null,
                ),
                const SizedBox(height: 20),
                _buildLabel("Phone Number"),
                IntlPhoneField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 1.5),
                    ),
                  ),
                  initialCountryCode: 'PH',
                  onChanged: (phone) {
                    phoneController.text = phone.completeNumber;
                  },
                  onSaved: (phone) {
                    phoneController.text = phone!.completeNumber;
                  },
                ),
                const SizedBox(height: 20),
                _buildLabel("Religion"),
                _buildDropdown(
                  value: selectedReligion,
                  items: religions,
                  onChanged: (value) =>
                      setState(() => selectedReligion = value),
                  hint: 'Select your religion',
                ),
                const SizedBox(height: 20),
                _buildLabel("Nationality"),
                _buildDropdown(
                  value: selectedNationality,
                  items: nationalities,
                  onChanged: (value) =>
                      setState(() => selectedNationality = value),
                  hint: 'Select your nationality',
                ),
                const SizedBox(height: 20),
                _buildLabel("Home Address"),
                _buildInput(
                  controller: addressController,
                  hint: "Enter your home address",
                  validator: (value) =>
                      value!.isEmpty ? 'Address is required' : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _getCurrentLocation,
                    icon: const Icon(Icons.location_on, color: Colors.green),
                    label: const Text("Use Current Location",
                        style: TextStyle(color: Colors.green)),
                  ),
                ),
                const SizedBox(height: 20),
                _buildLabel("Province"),
                _buildInput(
                  controller: provinceController,
                  hint: "Enter your province",
                ),
                const SizedBox(height: 20),
                _buildLabel("City"),
                _buildInput(
                  controller: cityController,
                  hint: "Enter your city",
                ),
                const SizedBox(height: 20),
                _buildLabel("Barangay"),
                _buildInput(
                  controller: barangayController,
                  hint: "Enter your barangay",
                ),
                const SizedBox(height: 20),
                _buildLabel("Years of Stay"),
                _buildInput(
                  controller: yearsOfStayController,
                  hint: "Enter number of years",
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobInformationForm()),
                        );
                      }
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    String? prefixText,
    IconData? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: suffixIcon == Icons.calendar_today,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixText: prefixText,
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, size: 18, color: Colors.grey)
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
