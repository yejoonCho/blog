import 'package:blog/blog_post.dart';
import 'package:blog/pages/blog/blog_page.dart';
import 'package:blog/pages/home/components/constrained_center.dart';
import 'package:blog/pages/home/components/blog_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<BlogPost>>(context);
    return BlogScaffold(
      children: [
        ConstrainedCenter(
          child: CircleAvatar(
            backgroundImage:
                NetworkImage('https://i.ibb.co/ZKkSW4H/profile-image.png'),
            radius: 72,
          ),
        ),
        SizedBox(height: 18),
        ConstrainedCenter(
          child: SelectableText(
            'Flutter Dev',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SizedBox(height: 40),
        SelectableText(
          'Hello, I am a human. I am a Flutter devleoper.',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 40),
        SelectableText(
          'Blog',
          style: Theme.of(context).textTheme.headline2,
        ),
        for (var post in posts) BlogListTile(post: post),
      ],
    );
  }
}

class BlogListTile extends StatelessWidget {
  final BlogPost post;
  BlogListTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        InkWell(
          child: Text(
            post.title!,
            style: TextStyle(color: Colors.blueAccent.shade700),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BlogPage(blogPost: post)),
            );
          },
        ),
        SizedBox(height: 10),
        SelectableText(
          post.date,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
