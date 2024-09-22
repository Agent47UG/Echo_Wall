import 'package:echo_wall/components/my_drawer.dart';
import 'package:echo_wall/components/my_input_alert_box.dart';
import 'package:echo_wall/components/my_post_tile.dart';
import 'package:echo_wall/helper/navigate_pages.dart';
import 'package:echo_wall/models/post.dart';
import 'package:echo_wall/services/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _messageController = TextEditingController();
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
  late final listeningProvider = Provider.of<DatabaseProvider>(context);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadAllPost();
  }

  Future<void> loadAllPost() async {
    await databaseProvider.loadAllPost();
  }

  void _openPostMessageBox() {
    showDialog(
        context: context,
        builder: (context) => MyInputAlertBox(
            textController: _messageController,
            hintText: "Echo to the World",
            onPressed: () async {
              await postMessage(_messageController.text);
            },
            onPressedText: "Echo"));
  }

  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Image.asset(
          'assets/home_page_logo.png',
          scale: 12,
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openPostMessageBox,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: _buildPostList(listeningProvider.allPosts),
    );
  }

  Widget _buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? Center(
            child: Text("Nothing Here..!"),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return MyPostTile(
                post: post,
                onUserTap: () => goUserPage(context, post.uid),
                onPostTap: () => goPostPage(context, post),
              );
            });
  }
}
