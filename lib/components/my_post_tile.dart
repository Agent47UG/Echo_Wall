import 'package:echo_wall/models/post.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:echo_wall/services/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class MyPostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;

  const MyPostTile({
    super.key,
    required this.post,
    required this.onUserTap,
    required this.onPostTap,
  });

  @override
  State<MyPostTile> createState() => _MyPostTileState();
}

class _MyPostTileState extends State<MyPostTile> {
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
  late final listeningProvider = Provider.of<DatabaseProvider>(context);

  void _toggleLikePost() async {
    try {
      await databaseProvider.toggleLike(widget.post.id);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    _toggleLikePost();
    return !isLiked;
  }

  void _showOptions() {
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnPost = widget.post.uid == currentUid;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              if (isOwnPost)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text("Delete"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              else ...[
                ListTile(
                  leading: const Icon(Icons.flag),
                  title: Text("Report"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.block),
                  title: Text("Block"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
              ListTile(
                leading: const Icon(Icons.cancel),
                title: Text("Cancel"),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool likedByCurrentUser =
        listeningProvider.isPostLikedByCurrentUser(widget.post.id);
    int likeCount = listeningProvider.getLikeCount(widget.post.id);
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onUserTap,
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.post.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '@${widget.post.username}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _showOptions,
                    child: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.post.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                LikeButton(
                  size: 24,
                  onTap: onLikeButtonTapped,
                  isLiked: likedByCurrentUser,
                  bubblesSize: 60,
                  circleSize: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  likeCount != 0 ? likeCount.toString() : '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
