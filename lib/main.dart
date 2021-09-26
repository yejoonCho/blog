import 'package:blog/models/post.dart';
import 'package:blog/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<Post>>(
          create: (context) => posts(),
          initialData: [],
        ),
        Provider<User>(create: (context) => user),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        home: HomePage(),
      ),
    );
  }
}

// 테마
ThemeData theme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyText2: TextStyle(fontSize: 22, height: 1.4),
    caption: TextStyle(fontSize: 18, height: 1.4),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
);

final user = User(
  name: 'Flutter Dev',
  profilePicture: 'https://i.ibb.co/ZKkSW4H/profile-image.png',
);

Future<List<Post>> posts() {
  return FirebaseFirestore.instance.collection('posts').get().then((snapshot) {
    return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
  });
}
