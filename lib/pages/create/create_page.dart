import 'package:blog/models/post.dart';
import 'package:blog/widgets/blog_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  final Post? post;
  CreatePage({this.post});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: post?.title ?? '');
    final bodyController = TextEditingController(text: post?.body ?? '');
    final isEdit = post != null;

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
        label: Text(isEdit ? 'Update' : 'Submit'),
        icon: Icon(isEdit ? Icons.check : Icons.book),
        onPressed: () {
          final title = titleController.text;
          final body = bodyController.text;
          final newPost = Post(
            title: title,
            body: body,
            publishedDate: DateTime.now(),
          );
          handleBlogUpdate(
            isEdit: isEdit,
            newPost: newPost,
            oldPost: post,
          ).then((value) => Navigator.of(context).pop());
        },
      ),
    );
  }
}

Future<void> handleBlogUpdate(
    {required bool isEdit, required Post newPost, Post? oldPost}) async {
  final newMapPost = newPost.toMap();
  if (isEdit) {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(oldPost!.id)
        .update(newMapPost);
  } else {
    await FirebaseFirestore.instance.collection('posts').add(newMapPost);
  }
}
