import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Post {
  final String? title;
  final DateTime? publishedDate;
  final String? body;
  final String? id;
  final bool? isLiked;

  String get date => DateFormat('d MMMM y').format(publishedDate!);

  Post({this.title, this.publishedDate, this.body, this.id, this.isLiked});

  factory Post.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return Post(
      title: map['title'],
      body: map['body'],
      publishedDate: map['published_date'].toDate(),
      id: doc.id,
      isLiked: map['is_liked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'published_date': Timestamp.fromDate(publishedDate!),
    };
  }
}
