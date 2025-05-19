import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddBankAccountPage(),
    );
  }
}

class AddBankAccountPage extends StatefulWidget {
  const AddBankAccountPage({super.key});

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedBank;
  String? accountType;

  final List<String> banks = [
    'Security Bank', 'BDO (Banco de Oro)', 'PNB Bank (Philippine National Bank)', 'Union Bank of the Philippines', 'BPI (Bank of the Philippine Islands)'
  ];

  final List<String> accountTypes = [
    'Checking', 'Savings', 'Business'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Bank Account', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Bank Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  hint: Text('Select your bank'),
            items: banks.map((bank) => DropdownMenuItem(
              value: bank,
              child: Row(
                children: [
                  Icon(Icons.account_balance, size: 20, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    bank,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
                  )).toList(),
                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                  onChanged: (value) {
                    setState(() => selectedBank = value);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Account Number',
                    hintText: 'Enter your account number',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Account Holder\'s Name',
                    hintText: 'Enter your account name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Account Type',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  hint: Text('Choose the type of account'),
                  items: accountTypes.map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  )).toList(),
                  onChanged: (value) {
                    setState(() => accountType = value);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Routing Number',
                    hintText: 'Enter your bank\'s routing number',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Branch Name',
                    hintText: 'Enter branch name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save logic
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
