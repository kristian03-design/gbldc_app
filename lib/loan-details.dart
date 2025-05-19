import 'package:flutter/material.dart';

class LoanDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Loan Summary
            _buildSectionCard(
              children: [
                _buildDetailRow("Loan Amount", "₱5,000.00"),
                _buildDetailRow("Daily Loan Interest", "0.08% (0.12%)"),
                _buildDetailRow("Repayment Amount", "₱5,500.00"),
                _buildDetailRow("Installment", "4 Months"),
                _buildDetailRow("Disbursement Bank", "BDO"),
                _buildDetailRow("Account Number", "6464 2345 5670"),
                _buildDetailRow("Disbursement Date", "Jan 22, 2025"),
                _buildDetailRow("Order ID", "2212240941"),
              ],
            ),

            SizedBox(height: 16),

            // Installment Card
            _buildSectionCard(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Installment 4 Months", style: TextStyle(fontWeight: FontWeight.w600)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text("Ongoing", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _buildDetailRow("Loan Amount", "₱5,000.00"),
                _buildDetailRow("Repayment Amount", "₱5,500.00"),
                _buildDetailRow("Due Date", "Jan 22, 2025"),
                _buildDetailRow("Repayment Date", "Jan 22, 2025"),
                _buildDetailRow("Repayment Method", "Mastercard"),
                _buildDetailRow("Repayment Origin", "•••• 4679"),
                _buildDetailRow("Loan ID", "220215"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(title, style: TextStyle(color: Colors.grey[700]))),
          SizedBox(width: 12),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
