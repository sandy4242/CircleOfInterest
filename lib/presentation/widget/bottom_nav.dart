import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';
import '../screens/create_event_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CreateEventScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
