import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A7B3D),
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Footer columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFooterColumn("PRODUCTS & SERVICES", [
                "Loan Products",
                "Deposit Products",
                "Insurance Products",
                "Social Services"
              ]),
              _buildFooterColumn("ABOUT", [
                "About Greater Bulacan Livelihood Development Cooperative",
                "Senior Management",
                "Officers & Committees"
              ]),
              _buildFooterColumn("OTHER QUICKLINKS", [
                "News & Events",
                "FAQs",
                "Contact",
                "Apply Now",
                "Downloadable Forms",
                "Privacy Policy"
              ]),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'GREATER BULACAN LIVELIHOOD DEVELOPMENT COOPERATIVE © 2025. ALL RIGHTS RESERVED.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(String heading, List<String> items) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            for (var item in items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}