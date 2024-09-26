import 'package:echo_wall/components/my_drawer.dart';
import 'package:echo_wall/components/my_input_alert_box.dart';
import 'package:echo_wall/components/my_post_tile.dart';
import 'package:echo_wall/helper/navigate_pages.dart';
import 'package:echo_wall/models/post.dart';
import 'package:echo_wall/services/database/database_provider.dart';
import 'package:echo_wall/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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

  Future<void> _handleRefresh() async {
    loadAllPost();
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Image.asset(
              'assets/home_page_logo.png',
              scale: 12,
            ),
            foregroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            bottom: TabBar(
              dividerColor: Colors.transparent,
              labelColor: Theme.of(context).colorScheme.onPrimary,
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              indicatorColor: Theme.of(context).colorScheme.onPrimary,
              tabs: [
                Tab(text: "For You"),
                Tab(text: "Following"),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 18.0),
                child: GestureDetector(
                  onTap: Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme,
                  child: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _openPostMessageBox,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TabBarView(children: [
              _buildPostList(listeningProvider.allPosts),
              _buildPostList(listeningProvider.followingPosts),
            ]),
          )),
    );
  }

  Widget _buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            color: Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 700,
            animSpeedFactor: 3,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 300.0),
                  child: Center(child: Text("No Posts Here!")),
                )
              ],
            ),
          )
        : LiquidPullToRefresh(
            color: Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            onRefresh: _handleRefresh,
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 700,
            animSpeedFactor: 3,
            child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return MyPostTile(
                    post: post,
                    onUserTap: () => goUserPage(context, post.uid),
                    onPostTap: () => goPostPage(context, post),
                  );
                }),
          );
  }
}
