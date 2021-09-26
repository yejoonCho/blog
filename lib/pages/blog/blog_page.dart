import 'package:blog/models/blog_post.dart';
import 'package:blog/pages/blog/components/blog_scaffold.dart';
import 'package:blog/widgets/constrained_center.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  final BlogPost blogPost;
  BlogPage({required this.blogPost});

  @override
  Widget build(BuildContext context) {
    return BlogScaffold(
      children: [
        ConstrainedCenter(
          child: CircleAvatar(
            backgroundImage:
                NetworkImage('https://i.ibb.co/ZKkSW4H/profile-image.png'),
            radius: 54,
          ),
        ),
        SizedBox(height: 18),
        ConstrainedCenter(
          child: SelectableText(
            'Flutter Dev',
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
