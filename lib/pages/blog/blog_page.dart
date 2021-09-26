import 'package:blog/models/post.dart';
import 'package:blog/models/user.dart';
import 'package:blog/pages/blog/components/blog_scaffold.dart';
import 'package:blog/widgets/constrained_center.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatelessWidget {
  final Post blogPost;
  BlogPage({required this.blogPost});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return BlogScaffold(
      children: [
        ConstrainedCenter(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profilePicture!),
            radius: 54,
          ),
        ),
        SizedBox(height: 18),
        ConstrainedCenter(
          child: SelectableText(
            user.name!,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(height: 40),
        SelectableText(
          blogPost.title!,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: 20),
        SelectableText(
          blogPost.date,
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: 20),
        SelectableText(
          blogPost.body!,
        ),
      ],
    );
  }
}
