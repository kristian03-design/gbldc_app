import 'package:flutter/material.dart';
import 'add_bank_account.dart'; // Make sure this file exists or create a placeholder

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Accounts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const BankAccountPage(),
    );
  }
}

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  List<Map<String, String>> bankAccounts = [
    {
      'name': 'Security Bank',
      'number': '4567 9012 3456',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/Security-bank.jpeg',
    },
    {
      'name': 'BDO (Banco de Oro)',
      'number': '6789 0123 4567',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/bdo.png',
    },
    {
      'name': 'PNB Bank',
      'number': '5678 9012 3456',
      'owner': 'Kristian Lloyd DC Hernandez',
      'logo': 'assets/images/pnb.png',
    },
    {
      'name': 'Union Bank',
      'number': '3456 7890 1234',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/union-bank.jpeg',
    },
    {
      'name': 'BPI Bank',
      'number': '2345 6789 0123',
      'owner': 'Kristian Lloyd DC Hernandez',
      'logo': 'assets/images/bpi.jpeg',
    },
  ];

  void _deleteAccount(int index) {
    setState(() {
      bankAccounts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Bank Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: bankAccounts.isEmpty
                  ? const Center(
                child: Text(
                  'No bank accounts available.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.separated(
                itemCount: bankAccounts.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final account = bankAccounts[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            account['logo']!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 48),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                account['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${account['number']} - ${account['owner']}',
                                style: const TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: Colors.white,
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this bank account?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteAccount(index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete',
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBankAccountPage()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add Bank Account',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
