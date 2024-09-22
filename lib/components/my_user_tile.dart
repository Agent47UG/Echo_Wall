import 'package:echo_wall/models/user.dart';
import 'package:echo_wall/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  final UserProfile user;
  const MyUserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondary),
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          user.name,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        subtitle: Text(
          '@${user.username}',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(uid: user.uid),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
