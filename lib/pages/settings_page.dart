import 'package:echo_wall/components/my_loading_circle.dart';
import 'package:echo_wall/components/my_settings_tile.dart';
import 'package:echo_wall/helper/navigate_pages.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:echo_wall/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _auth = AuthService();

  void logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to Logout?"),
        actions: [
          TextButton(
            onPressed: () async {
              showLoadingCircle(context);
              _auth.logout();
              await Future.delayed(Duration(seconds: 1));
              Navigator.pop(context);
              hideLoadingCircle(context);
            },
            child: Text(
              "Logout",
              style: TextStyle(color: const Color.fromARGB(255, 248, 101, 90)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          MySettingsTile(
            title: "Dark Mode",
            action: CupertinoSwitch(
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            ),
          ),
          GestureDetector(
            onTap: () => goToBlockedUserPage(context),
            child: MySettingsTile(
              title: "Blocked Users",
              action: Padding(
                padding: const EdgeInsets.all(3),
                child: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => goAccountSettingsPage(context),
            child: MySettingsTile(
              title: "Account Settings",
              action: Padding(
                padding: const EdgeInsets.all(3),
                child: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: logout,
            child: MySettingsTile(
              title: "Logout",
              action: Padding(
                padding: const EdgeInsets.all(3),
                child: Icon(
                  Icons.logout,
                  color: const Color.fromARGB(255, 248, 101, 90),
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            "Made By Ujwal",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      _launchUrl('https://github.com/Agent47UG');
                    },
                    child: Icon(
                      Ionicons.logo_github,
                      size: 35,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      _launchUrl(
                          'https://www.linkedin.com/in/ujwal-ghodeswar-268209241');
                    },
                    child: Icon(
                      Ionicons.logo_linkedin,
                      size: 35,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      _launchUrl('https://www.ujwalg.tech/');
                    },
                    child: Icon(
                      Ionicons.logo_web_component,
                      size: 35,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      _launchUrl('https://www.instagram.com/ujwal_ghodeswar');
                    },
                    child: Icon(
                      Ionicons.logo_instagram,
                      size: 35,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      _launchUrl('https://x.com/GhodeswarUjwal');
                    },
                    child: Icon(
                      Ionicons.logo_twitter,
                      size: 35,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
