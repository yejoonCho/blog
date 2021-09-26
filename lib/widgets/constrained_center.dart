import 'package:flutter/material.dart';

class ConstrainedCenter extends StatelessWidget {
  final Widget child;
  ConstrainedCenter({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(child: child),
    );
  }
}
