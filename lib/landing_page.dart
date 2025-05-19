import 'package:flutter/material.dart';
import 'package:gbldc_application/loan-page.dart';
import 'online-application.dart';
import 'profile.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  // Sample notifications list
  List<String> notifications = [
    'Loan application approved',
    'New payment due date',
    'System maintenance scheduled',
    'New message from support',
    'Loan application is under review',
    'Loan application is rejected',
  ];

  // Track unread notification indexes
  Set<int> unreadNotificationIndexes = {0, 1, 2, 3, 4, 5,};

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoanPageHomepage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  void showNotificationsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 13.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              title: const Text(
                'Notifications',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: notifications.isEmpty
                    ? const Text('No notifications')
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: notifications.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          bool isUnread =
                              unreadNotificationIndexes.contains(index);
                          return Dismissible(
                            key: Key(notifications[index]),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (_) {
                              setStateDialog(() {
                                unreadNotificationIndexes.remove(index);
                                notifications.removeAt(index);

                                // Adjust unread indexes after removing item
                                unreadNotificationIndexes =
                                    unreadNotificationIndexes
                                        .where((i) => i != index)
                                        .map((i) => i > index ? i - 1 : i)
                                        .toSet();
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: isUnread
                                    ? Colors.green.shade50
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                leading: Icon(
                                  Icons.notifications,
                                  color: isUnread ? Colors.green : Colors.grey,
                                  size: 23,
                                ),
                                title: Text(
                                  notifications[index],
                                  style: TextStyle(
                                    fontWeight: isUnread
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: isUnread
                                        ? Colors.black
                                        : Colors.grey[700],
                                  ),
                                ),
                                trailing: isUnread
                                    ? Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : null,
                                onTap: () {
                                  setStateDialog(() {
                                    unreadNotificationIndexes.remove(index);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    setStateDialog(() {
                      unreadNotificationIndexes.clear();
                    });
                  },
                  child: const Text('Mark all as read',
                      style: TextStyle(fontSize: 16, color: Colors.green)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int unreadCount = unreadNotificationIndexes.length;

    return Scaffold(
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 23),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money, size: 23),
              label: 'Loan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 23),
              label: 'Profile',
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logocoop.png',
                      height: 50,
                      width: 50,
                    ),
                    const Text('GBLDC',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green[50],
                          child: IconButton(
                            icon: const Icon(
                              Icons.notifications_none,
                              color: Colors.green,
                              size: 25,
                            ),
                            onPressed: () {
                              showNotificationsPopup(context);
                            },
                          ),
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Greeting card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Welcome to Greater Bulacan Livelihood Development Cooperative',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Card 1
                _buildCard(
                  title: 'Borrow your way',
                  subtitle: 'Apply once and get continuous access to cash.',
                  imagePath: 'assets/images/phone.jpg',
                  buttons: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegistrationForm(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        'Learn more',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                // Card 2
                _buildCard(
                  title: 'Earn PHP 200',
                  subtitle:
                      'Reduce your payment by inviting friends to Greater Bulacan Livelihood Development Cooperative.',
                  imagePath: 'assets/images/joinus.jpg',
                  buttons: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                // Card 3
                _buildCard(
                  title: 'Need help?',
                  subtitle: 'Get answers to your questions',
                  imagePath: 'assets/images/help.jpg',
                  buttons: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View FAQ',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required List<Widget> buttons,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: buttons),
              ],
            ),
          ),

          // Image content
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
