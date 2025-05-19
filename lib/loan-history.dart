import 'package:flutter/material.dart';
import 'loan-details.dart';

class LoanHistoryPage extends StatelessWidget {
  final List<Map<String, String>> loanHistory = [
    {'amount': '₱ 5,200.00', 'date': 'Jan 22, 2025 - 09:41 AM'},
    {'amount': '₱ 10,800.00', 'date': 'Nov 15, 2024 - 11:15 PM'},
    {'amount': '₱ 15,500.00', 'date': 'Oct 28, 2024 - 10:30 AM'},
    {'amount': '₱ 12,600.00', 'date': 'Sep 10, 2024 - 10:00 AM'},
    {'amount': '₱ 8,700.00', 'date': 'Aug 05, 2024 - 08:05 AM'},
    {'amount': '₱ 9,900.00', 'date': 'Jul 20, 2024 - 12:02 PM'},
    {'amount': '₱ 20,400.00', 'date': 'Jun 18, 2024 - 10:00 AM'},
    {'amount': '₱ 25,100.00', 'date': 'Jun 01, 2024 - 04:00 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan History'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(18),
        itemCount: loanHistory.length,
        separatorBuilder: (context, index) => SizedBox(height: 15),
        itemBuilder: (context, index) {
          final loan = loanHistory[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoanDetailsPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 2,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Loan Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loan['amount']!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        loan['date']!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  // Paid Off Button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Paid Off',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.white, size: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
