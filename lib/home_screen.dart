import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'Home_Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewsApp'),
      ),
    );
  }
}
