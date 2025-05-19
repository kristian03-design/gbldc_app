import 'package:flutter/material.dart';
import 'package:gbldc_application/help&support_page.dart';
import 'package:gbldc_application/loan-page.dart';
import 'payment_methods.dart';
import 'landing_page.dart';
import 'loan-history.dart';
import 'bank-account.dart';
import 'main.dart';
import 'personal_info_edit.dart'; // Assuming PersonalInfoEditPage is defined here

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Account'),
        centerTitle: true,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 16.0),
          color: Colors.white,
          child: Column(
            children: [
              // User Info Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalInfoEditPage()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/2x2.jpg'),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Kristian Lloyd Hernandez',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '+639 1234 5678',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),

              // Balance Section
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.account_balance_wallet,
                      color: Colors.black),
                  title: const Text(
                    '₱ 1,425.00',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Your balance',
                      style: TextStyle(color: Color.fromARGB(255, 77, 76, 76))),
                  trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 16),
                  onTap: () {},
                ),
              ),

              const Divider(),

              // Menu Items (Styled Individually)
              _buildMenuItem(
                Icons.history,
                "Loan History",
                iconColor: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoanHistoryPage()));
                },
              ),
              _buildMenuItem(
                Icons.account_balance,
                "Bank Account",
                iconColor: Colors.green,
                textStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BankAccountPage()));
                },
              ),
              _buildMenuItem(
                Icons.payment,
                "Payment Methods",
                iconColor: Colors.deepPurple,
                textStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethods()));
                },
              ),
              _buildMenuItem(
                Icons.lock,
                "Account & Security",
                iconColor: Colors.redAccent,
                textStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              _buildMenuItem(Icons.link, "Linked Accounts",
                  iconColor: Colors.teal,
                  textStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
              _buildMenuItem(
                Icons.help_outline,
                "Help & Support",
                iconColor: Colors.indigo,
                textStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpSupportPage()));
                },
              ),
              _buildMenuItem(Icons.star_border, "Rate us",
                  iconColor: Colors.amber[800],
                  textStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),

              // Logout
              _buildMenuItem(
                Icons.logout,
                "Logout",
                iconColor: Colors.red,
                textStyle: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w600),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0)),
                    ),
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(45.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Logout',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Are you sure you want to logout?',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Poppins'),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.green[50],
                                    ),
                                    child: Text('Cancel',
                                        style: TextStyle(
                                            color: Colors.green[600])),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WelcomeScreen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                    child: const Text('Yes, Logout',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 5,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          currentIndex: 2,
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoanPageHomepage()), // <-- Add this
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Loan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // Updated Menu Item Builder with styling support
  Widget _buildMenuItem(
    IconData icon,
    String title, {
    VoidCallback? onTap,
    Color? iconColor,
    TextStyle? textStyle,
    Color? tileColor,
  }) {
    return Container(
      color: tileColor ?? Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.black),
        title: Text(title,
            style: textStyle ?? const TextStyle(color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
