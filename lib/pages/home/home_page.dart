import 'package:blog/blog_post.dart';
import 'package:blog/constrained_center.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<BlogPost>>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 612,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedCenter(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.ibb.co/ZKkSW4H/profile-image.png'),
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
          ),
        ),
      ),
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
          onTap: () {},
        ),
        SizedBox(height: 10),
        SelectableText(
          DateFormat('d MMMM y').format(post.publishedDate!),
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}