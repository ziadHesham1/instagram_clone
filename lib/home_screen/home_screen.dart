import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/globals/global_variables.dart';
import '../core/globals/global_widgets/global_snackbar.dart';
import '../core/providers/users_provider.dart';
import '../profile/profile_screen.dart';
import 'app_drawer.dart';
import 'new_post/new_post_widget.dart';
import 'posts/post/posts_view_widget.dart';
import 'status/status_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);
    var loggedInUser = userProvider.loggedInUser();
    return Scaffold(
      key: GlobalVariables.homeScaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Arabian Social Media',
        ),
        actions: [
          // appbar profile picture
          InkWell(
            onTap: () {
              if (loggedInUser != null) {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              } else {
                GlobalSnackbar.showWithLoginAction(
                  context,
                  'You need to login to see your profile!!',
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  loggedInUser != null
                      ? loggedInUser.imgPath
                      : GlobalVariables.anonymousImg,
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Status(),
              NewPost(),
              SizedBox(
                height: 20,
              ),
              PostsView(),
            ],
          ),
        ),
      ),
    );
  }
}
