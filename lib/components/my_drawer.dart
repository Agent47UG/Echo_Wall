import 'package:echo_wall/models/user.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:echo_wall/services/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  final _auth = AuthService();

  UserProfile? user;
  bool _isLoading = true;
  Future<void> loadUser() async {
    user = await databaseProvider.userProfile(_auth.getCurrentUid());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _isLoading ? '' : user!.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Thank you for downloading Echo Wall!",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Post Something you would like to Echo to the world! and maybe those who hear it! Will Echo back.",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "This was a small passion project! and I'm so glad that its complete. Enjoy, Echo and Have Fun.",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Made with Love,",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 17),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "- By Ujwal",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
