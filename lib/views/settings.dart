import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:todo_list/widgets/my_app_bar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Settings', hasReturnButton: true),
      body: Center(
        child: MaterialColorPicker(
          allowShades: false,
          onMainColorChange: (ColorSwatch color) {
            print('O usuário escolheu uma cor!');
          },
        )
      )
    );
  }
}