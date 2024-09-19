import 'package:echo_wall/components/my_drawer_tile.dart';
import 'package:echo_wall/pages/settings_page.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final _auth = AuthService();

  void logout() {
    _auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            MyDrawerTile(
              title: "H O M E",
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            MyDrawerTile(
              title: "S E T T I N G",
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ));
              },
            ),
            const Spacer(),
            MyDrawerTile(
                title: "L O G O U T", icon: Icons.logout, onTap: logout)
          ],
        ),
      ),
    );
  }
}
