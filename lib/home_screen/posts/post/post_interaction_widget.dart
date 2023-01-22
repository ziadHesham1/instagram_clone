import 'package:flutter/material.dart';
import 'package:instagram_clone/core/providers/users_provider.dart';
import 'package:instagram_clone/core/globals/global_widgets/global_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../core/globals/global_variables.dart';
import '../../../core/providers/comment_provider.dart';
import '../../../core/providers/posts_provider.dart';
import '../../../core/globals/global_widgets.dart';
import '../../post_details_screen.dart';

class PostInteractionWidget extends StatefulWidget {
  final String postId;
  const PostInteractionWidget(this.postId, {super.key});

  @override
  State<PostInteractionWidget> createState() => _PostInteractionWidgetState();
}

class _PostInteractionWidgetState extends State<PostInteractionWidget> {
  @override
  Widget build(BuildContext context) {
    print('PostInteractionWidget build method called');

    PostsProvider providedPosts = Provider.of<PostsProvider>(context);
    PostModel post = providedPosts.findPostById(widget.postId);
    var loggedInUser = Provider.of<UsersProvider>(context).loggedInUser();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // likes buttons
          buildLikesButton(post),
          const SizedBox(width: 10),
          // comments button
          buildCommentButton(providedPosts, post, loggedInUser),
          // show comments button
          buildShowCommentButton(context, post) /* !NOT WORKING !!!!! */
        ],
      ),
    );
  }

  Widget buildLikesButton(PostModel post) {
    return TextButton.icon(
        icon: GlobalWidgets.like_icon,
        label: Text('${post.likesNumber}'),
        onPressed: () {});
  }
// replace it with the button with comment icon when new comment is ready

  Widget buildCommentButton(providedPosts, PostModel post, loggedInUser) {
    return TextButton.icon(
      icon: GlobalWidgets.comment_icon,
      label: Text('${post.comments.length}'),
      onPressed: () {
        setState(
          () {
            if (loggedInUser != null) {
              var commentContent2 =
                  '${post.userId} ${GlobalVariables.longText}';
              providedPosts.addComment(
                post.id,
                CommentModel(
                  id: DateTime.now.toString(),
                  userId: loggedInUser.id,
                  publishTime: DateTime.now(),
                  commentContent: commentContent2,
                ),
              );
              GlobalSnackbar.show(context,
                  '${loggedInUser.name} added this comment : $commentContent2');
            } else {
              GlobalSnackbar.showWithLoginAction(
                context,
                'You need to login to add a comment!!',
              );
            }
          },
        );
      },
    );
  }

  Widget buildShowCommentButton(BuildContext context, PostModel post) {
    return TextButton(
        onPressed: () {
          setState(() {
            Navigator.of(context)
                .pushNamed(PostDetailsScreen.routeName, arguments: post);
          });
        },
        child: const Text('Show Comments'));
  }
}
