import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'connect_screen.dart';
import 'chatbot_screen.dart';
import 'documents_screen.dart';

class MainAppScreen extends StatefulWidget {
  final String selectedChapter;
  final VoidCallback onSignOut;

  const MainAppScreen({
    super.key,
    required this.selectedChapter,
    required this.onSignOut,
  });

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomeScreen(selectedChapter: widget.selectedChapter),
      const ConnectScreen(),
      const ChatbotScreen(),
      const DocumentsScreen(),
      ProfileScreen(
        selectedChapter: widget.selectedChapter,
        onSignOut: widget.onSignOut,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Connect',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Chatbot',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Documents',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

