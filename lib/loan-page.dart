import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'landing_page.dart';
import 'profile.dart';

void main() {
  runApp(LoanApp());
}

class LoanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greater Bulacan Livelihood Development Cooperative',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.green,
      ),
      home: LoanPageHomepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoanPageHomepage extends StatefulWidget {
  @override
  _LoanPageHomepageState createState() => _LoanPageHomepageState();
}

class _LoanPageHomepageState extends State<LoanPageHomepage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    Widget targetPage;
    switch (index) {
      case 0:
        targetPage = LandingPage();
        break;
      case 2:
        targetPage = AccountPage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loanLimit = NumberFormat('#,###').format(20000);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildLoanLimitCard(loanLimit),
              const SizedBox(height: 24),
              _buildGridOptions(),
              const SizedBox(height: 28),
              _buildSpecialSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      selectedFontSize: 14,
      unselectedFontSize: 13,
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
      onTap: _onItemTapped,
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/logocoop.png',
          height: 50,
          width: 50,
        ),
        const Text(
          'GBLDC',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        CircleAvatar(
          backgroundColor: Colors.green[50],
          child: IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.green,
            ),
            onPressed: () {
              // No action here yet
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoanLimitCard(String loanLimit) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Your loan limit', style: TextStyle(color: Colors.white)),
              SizedBox(width: 6),
              Icon(Icons.info_outline, color: Colors.white70, size: 18),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '\₱$loanLimit',
            style: const TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: const Text('Get Loan Now',
                style: TextStyle(color: Colors.green, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildGridOptions() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _optionCard(
          'How to Get a Loan?',
          'Easy steps',
          Icons.info_outline,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('How to Get a Loan tapped')),
            );
          },
        ),
        _optionCard(
          'Increase Your Loan Limit',
          'Learn More',
          Icons.trending_up,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Increase Your Loan Limit tapped')),
            );
          },
        ),
      ],
    );
  }

  Widget _optionCard(
      String title, String subtitle, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Special for You',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'View All',
          style: TextStyle(color: Colors.green),
        ),
      ],
    );
  }
}
