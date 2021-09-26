import 'package:flutter/material.dart';

class BlogScaffold extends StatelessWidget {
  final List<Widget> children;
  BlogScaffold({required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 612,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}