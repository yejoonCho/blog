import 'package:blog/models/post.dart';
import 'package:blog/models/blog_user.dart';
import 'package:blog/pages/blog/blog_page.dart';
import 'package:blog/pages/create/create_page.dart';
import 'package:blog/widgets/blog_list_tile.dart';
import 'package:blog/widgets/constrained_center.dart';
import 'package:blog/widgets/blog_scaffold.dart';
import 'package:blog/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<bool>(context);
    final posts = Provider.of<List<Post>>(context);
    final user = Provider.of<BlogUser>(context);

    return BlogScaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              child: Text(isUserLoggedIn ? 'Logout' : 'Login'),
              onPressed: () {
                if (isUserLoggedIn) {
                  FirebaseAuth.instance.signOut();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return LoginDialog();
                    },
                  );
                }
              },
            )
          ],
        ),
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
        floatingActionButton: isUserLoggedIn
            ? FloatingActionButton.extended(
                label: Text('New Post'),
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CreatePage()));
                },
              )
            : SizedBox());
  }
}
