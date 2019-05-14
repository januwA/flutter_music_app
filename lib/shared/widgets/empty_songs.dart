import 'package:flutter/material.dart';

class EmptySongs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '没有找到本地音乐 >_<',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
