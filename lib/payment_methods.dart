import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Methods',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const PaymentMethods(),
    );
  }
}

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  List<Map<String, String>> paymentMethods = [
    {
      'name': 'GCASH',
      'number': '(+63) 912 345 6789',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/g-cash.jpeg',
    },
    {
      'name': 'Maya Bank',
      'number': '(+63) 912 345 6789',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/maya.jpeg',
    },
    {
      'name': 'GoTyme Bank',
      'number': '(+63) 912 345 6789',
      'owner': 'Kristian Lloyd DC Hernandez',
      'logo': 'assets/images/gotyme.jpeg',
    },
    {
      'name': 'Master Card',
      'number': '*** **** **89',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/master-card.jpeg',
    },
    {
      'name': 'Visa Card',
      'number': '*** **** **89',
      'owner': 'Kristian Lloyd DC Hernandez',
      'logo': 'assets/images/visa-card.png',
    },
  ];

  void _deleteAccount(int index) {
    setState(() {
      paymentMethods.removeAt(index);
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
          'Payment Methods',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: paymentMethods.isEmpty
                  ? const Center(
                child: Text(
                  'No Payment Methods Accounts available.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.separated(
                itemCount: paymentMethods.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final account = paymentMethods[index];
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
                            fit: BoxFit.cover,
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
                                    'Are you sure you want to delete this Payment Method?',
                                  style: TextStyle(
                                    height: 1.5,
                                  ),
                                ),
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

              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add Payment Method',
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
