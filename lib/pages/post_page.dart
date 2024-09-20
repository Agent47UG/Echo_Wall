import 'package:echo_wall/components/my_post_tile.dart';
import 'package:echo_wall/helper/navigate_pages.dart';
import 'package:echo_wall/models/post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  final Post post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Post"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        children: [
          MyPostTile(
              post: widget.post,
              onUserTap: () => goUserPage(context, widget.post.uid),
              onPostTap: () {})
        ],
      ),
    );
  }
}
