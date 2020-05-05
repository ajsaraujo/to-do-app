import 'package:flutter/material.dart';
import 'package:todo_list/widgets/my_app_bar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      body: Center(
        child: Text('Welcome to the amazing settings page!')
      )
    );
  }
}