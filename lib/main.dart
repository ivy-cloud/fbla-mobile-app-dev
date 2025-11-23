import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/sign_in_screen.dart';
import 'screens/main_app_screen.dart';

void main() {
  runApp(const FBLAApp());
}

class FBLAApp extends StatelessWidget {
  const FBLAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FBLA Mobile App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow[700]!,
          primary: Colors.yellow[700]!,
          secondary: Colors.orange[600]!,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellow[700],
          foregroundColor: Colors.brown[900],
          elevation: 0,
        ),
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isSignedIn = false;
  String? _selectedChapter;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final chapter = prefs.getString('fbla_chapter');
    if (chapter != null) {
      setState(() {
        _selectedChapter = chapter;
        _isSignedIn = true;
      });
    }
  }

  void _onSignIn(String chapter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fbla_chapter', chapter);
    setState(() {
      _selectedChapter = chapter;
      _isSignedIn = true;
    });
  }

  Future<void> _onSignOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('fbla_chapter');
    setState(() {
      _selectedChapter = null;
      _isSignedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSignedIn && _selectedChapter != null) {
      return MainAppScreen(
        selectedChapter: _selectedChapter!,
        onSignOut: _onSignOut,
      );
    }
    return SignInScreen(onSignIn: _onSignIn);
  }
}

