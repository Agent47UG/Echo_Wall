import 'package:echo_wall/components/my_settings_tile.dart';
import 'package:echo_wall/helper/navigate_pages.dart';
import 'package:echo_wall/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
        ],
      ),
    );
  }
}
