import 'package:blog/blog_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<List<BlogPost>>(create: (context) => _blogPost),
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

final _blogPost = [
  BlogPost(
    title: 'What is provider',
    publishedDate: DateTime(2020, 2, 1),
  ),
  BlogPost(
    title: 'What is multi-provider',
    publishedDate: DateTime(2020, 2, 15),
  )
];
