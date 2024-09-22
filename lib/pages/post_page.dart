import 'package:echo_wall/components/my_comment_tile.dart';
import 'package:echo_wall/components/my_post_tile.dart';
import 'package:echo_wall/helper/navigate_pages.dart';
import 'package:echo_wall/models/post.dart';
import 'package:echo_wall/services/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final allComments = listeningProvider.getComment(widget.post.id);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("P O S T"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: MyPostTile(
                post: widget.post,
                onUserTap: () => goUserPage(context, widget.post.uid),
                onPostTap: () {}),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 25, bottom: 5),
            child: Text(
              "Comments",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          allComments.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Text(
                      "No Comments Here....",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: allComments.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final comment = allComments[index];
                    return MyCommentTile(
                      comment: comment,
                      onUserTap: () => goUserPage(context, comment.uid),
                    );
                  },
                )
        ],
      ),
    );
  }
}
