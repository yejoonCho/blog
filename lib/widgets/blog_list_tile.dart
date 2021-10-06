import 'package:blog/like_notifier.dart';
import 'package:blog/models/post.dart';
import 'package:blog/pages/blog/blog_page.dart';
import 'package:blog/pages/create/create_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'like_button.dart';

class BlogListTile extends StatelessWidget {
  final Post post;
  BlogListTile({required this.post});

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<bool>(context);
    return ChangeNotifierProvider<LikeNotifier>(
      create: (context) => LikeNotifier(),
      builder: (context, child) {
        final likeNotifier = Provider.of<LikeNotifier>(context);
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
                  MaterialPageRoute(builder: (context) {
                    return ChangeNotifierProvider.value(
                      value: likeNotifier,
                      child: BlogPage(blogPost: post),
                    );
                  }),
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
                if (!isUserLoggedIn) LikeButton(likeNotifier: likeNotifier),
                if (isUserLoggedIn) BlogPopUpMenuButton(post: post)
              ],
            ),
            Divider(thickness: 2)
          ],
        );
      },
    );
  }
}

class BlogPopUpMenuButton extends StatelessWidget {
  const BlogPopUpMenuButton({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Action>(
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
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  contentPadding: EdgeInsets.all(18),
                  children: [
                    Text('Are you sure you want to delete'),
                    Text(post.title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        )),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: Text('Delete'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('posts')
                                .doc(post.id)
                                .delete();
                          },
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    )
                  ],
                );
              },
            );
            break;
          default:
        }
      },
    );
  }
}

enum Action { edit, delete }
