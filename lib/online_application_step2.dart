import 'package:flutter/material.dart';
import 'online_application_step3.dart';
class JobInformationForm extends StatefulWidget {
  const JobInformationForm({super.key});

  @override
  State<JobInformationForm> createState() => _JobInformationFormState();
}

class _JobInformationFormState extends State<JobInformationForm> {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController employerController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  String? selectedEmploymentType;
  String? selectedSalaryFrequency;

  final _formKey = GlobalKey<FormState>();

  List<String> employmentTypes = ['Full-time', 'Part-time', 'Freelancer'];
  List<String> salaryFrequencies = ['Monthly', 'Bi-weekly', 'Weekly'];

  double progress = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                  Text("2 / 5", style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.4,
                color: Colors.green,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                "Job Information",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please provide details about your current job and proof of income.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              _buildLabel("Job Title"),
              _buildInput(
                controller: jobTitleController,
                hint: "Enter your job title",
              ),
              const SizedBox(height: 20),

              _buildLabel("Employer Name"),
              _buildInput(
                controller: employerController,
                hint: "Enter your employer's name",
              ),
              const SizedBox(height: 20),

              _buildLabel("Employment Type"),
              _buildDropdown(
                value: selectedEmploymentType,
                items: employmentTypes,
                onChanged: (value) =>
                    setState(() => selectedEmploymentType = value),
                hint: 'Select employment type',
              ),
              const SizedBox(height: 20),

              _buildLabel("Salary"),
              _buildInput(
                controller: salaryController,
                hint: "Enter your salary",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              _buildLabel("Salary Frequency"),
              _buildDropdown(
                value: selectedSalaryFrequency,
                items: salaryFrequencies,
                onChanged: (value) =>
                    setState(() => selectedSalaryFrequency = value),
                hint: 'Select salary frequency',
              ),
              const SizedBox(height: 20),

              _buildLabel("Proof of Income (Text Description)"),
              _buildInput(
                controller: TextEditingController(),
                hint: "Describe your proof of income",
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
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmergencyContactsPage()),
                      );
                    }
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) =>
      value == null || value.isEmpty ? 'This field is required' : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
      validator: (value) => value == null ? 'Please select an option' : null,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
