import 'package:flutter/material.dart';
import 'package:instagram_clone/profile/profile_screen.dart';

import 'package:provider/provider.dart';

import '../../../core/globals/global_variables.dart';
import '../../../core/providers/posts_provider.dart';
import '../../../core/providers/users_provider.dart';
import '../../post_details_screen.dart';
import 'follow_button_widget.dart';
import 'post_interaction_widget.dart';

class PostWidget extends StatefulWidget {
  final String postId;
  const PostWidget(this.postId, {super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<PostsProvider>(context).findPostById(widget.postId);
    var userProvider = Provider.of<UsersProvider>(context);
    var user = userProvider.findUserById(post.userId);
    var postPublishTime =
        DateTime.now().difference(post.postPublishTime).inMinutes.toString();

    return Container(
      margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GlobalVariables.postBorderRadius),
        border: Border.all(color: GlobalVariables.post_border_color),
      ),
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            // open profile screen of the post publisher user
            onTap: () => setState(() {
              Navigator.of(context).pushNamed(ProfileScreen.routeName,arguments: user.id);
            }),
            // post publisher profile picture
            leading: CircleAvatar(
              backgroundImage: AssetImage(user.imgPath),
            ),
            // post publisher user name
            title: Text(user.name),
            // post date
            subtitle: Text('$postPublishTime min'),
            // follow button
            trailing: FollowButtonWidget(user.id),
          ),
          //post content
          InkWell(
            onTap: () {
              setState(() {
                Navigator.of(context)
                    .pushNamed(PostDetailsScreen.routeName, arguments: post);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text(post.postContent, style: GlobalVariables.postTextStyle),
            ),
          ),
          // like and comment buttons
          PostInteractionWidget(widget.postId),
        ],
      ),
    );
  }
}
