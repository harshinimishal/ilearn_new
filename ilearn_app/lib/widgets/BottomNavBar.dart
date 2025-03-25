import 'package:flutter/material.dart';
import '/HomeScreen.dart';
import '/ProfileScreen.dart';

class BottomNavBar extends StatefulWidget {
  final String userName;

  const BottomNavBar({super.key, required this.userName});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Prevent unnecessary rebuilds

    setState(() {
      _selectedIndex = index;
    });

    Widget screen;
    switch (index) {
      case 0:
        screen = HomeScreen(userName: widget.userName);
        break;
      case 1:
        screen = HomeScreen(userName: widget.userName); // Replace with correct screen
        break;
      case 2:
        screen = HomeScreen(userName: widget.userName); // Replace with correct screen
        break;
      case 3:
        screen = ProfileScreen(userName: widget.userName);
        break;
      default:
        screen = HomeScreen(userName: widget.userName);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: const Color(0xFF097D66),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "AI"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: "Scan"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
