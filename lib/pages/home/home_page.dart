import 'package:blog/models/post.dart';
import 'package:blog/models/user.dart';
import 'package:blog/pages/blog/blog_page.dart';
import 'package:blog/pages/create/create_page.dart';
import 'package:blog/widgets/constrained_center.dart';
import 'package:blog/widgets/blog_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);
    final user = Provider.of<User>(context);

    return BlogScaffold(
      children: [
        ConstrainedCenter(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profilePicture!),
            radius: 72,
          ),
        ),
        SizedBox(height: 18),
        ConstrainedCenter(
          child: SelectableText(
            user.name!,
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text('New Post'),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreatePage()));
        },
      ),
    );
  }
}

class BlogListTile extends StatelessWidget {
  final Post post;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              post.date,
              style: Theme.of(context).textTheme.caption,
            ),
            PopupMenuButton<Action>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('Edit'),
                    value: Action.edit,
                  ),
                  PopupMenuItem(
                    child: Text('Delete'),
                    value: Action.delete,
                  ),
                ];
              },
              onSelected: (value) {
                switch (value) {
                  case Action.edit:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreatePage(post: post)));
                    break;
                  case Action.delete:
                    break;
                  default:
                }
              },
            )
          ],
        )
      ],
    );
  }
}

enum Action { edit, delete }
