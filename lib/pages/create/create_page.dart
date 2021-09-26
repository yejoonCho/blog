import 'package:blog/models/post.dart';
import 'package:blog/widgets/blog_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: '');
    final bodyController = TextEditingController(text: '');

    return BlogScaffold(
      children: [
        TextField(
          controller: titleController,
          maxLines: null,
          style: Theme.of(context).textTheme.headline1,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Title'),
        ),
        TextField(
          controller: bodyController,
          maxLines: null,
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Write your post here ...'),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Submit'),
        icon: Icon(Icons.book),
        onPressed: () {
          final title = titleController.text;
          final body = bodyController.text;
          final post = Post(
            title: title,
            body: body,
            publishedDate: DateTime.now(),
          ).toMap();
          FirebaseFirestore.instance
              .collection('posts')
              .add(post)
              .then((_) => Navigator.of(context).pop());
        },
      ),
    );
  }
}
