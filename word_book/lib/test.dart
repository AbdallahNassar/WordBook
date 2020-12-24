import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key key}) : super(key: key);
  void _no() {
    final word = 'klasdf1';
    if (word.isNotEmpty &&
        !word.contains(new RegExp(r'[*+,./\^`|~:;<=>?@0-9]')) &&
        word.contains(new RegExp(r'[A-Za-z]')))
      print('yes');
    else
      print('no');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: _no,
          child: Container(
            color: Colors.black,
            height: 500,
            width: 500,
            child: Text('no'),
          ),
        ),
      ),
    );
  }
}
