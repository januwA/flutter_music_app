import 'package:flutter/material.dart';

class PageLoading extends StatelessWidget {
  final Widget body;

  PageLoading({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body,
      ),
    );
  }
}
