import 'package:blog/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LikeNotifier extends ChangeNotifier {
  final Post post;
  LikeNotifier(this.post);
  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void init() {
    _isLiked = post.isLiked!;
  }

  void toggleLike() {
    _isLiked = !_isLiked;
    FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .update({'is_liked': _isLiked});
    notifyListeners();
  }
}
