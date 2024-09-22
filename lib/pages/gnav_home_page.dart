import 'package:echo_wall/components/my_bottom_nav.dart';
import 'package:echo_wall/pages/home_page.dart';
import 'package:echo_wall/pages/profile_page.dart';
import 'package:echo_wall/pages/search_page.dart';
import 'package:echo_wall/pages/settings_page.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class GnavHomePage extends StatefulWidget {
  GnavHomePage({super.key});
  @override
  State<GnavHomePage> createState() => _GnavHomePageState();
}

class _GnavHomePageState extends State<GnavHomePage> {
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(uid: AuthService().getCurrentUid()),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      bottomNavigationBar: isKeyboardOpen
          ? null
          : MyBottomNav(
              onTabChange: (index) => navigateBottomBar(index),
            ),
      body: _pages[_selectedIndex],
    );
  }
}
