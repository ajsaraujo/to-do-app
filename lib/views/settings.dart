import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:todo_list/widgets/my_app_bar.dart';

class SettingsPage extends StatefulWidget {
  final Function changeThemeCallback;

  SettingsPage({this.changeThemeCallback});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _showColorPickerDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Color colorBuffer;

          final colorPicker = MaterialColorPicker(
            onColorChange: (Color color) {
              colorBuffer = color;
              print('Você selecionou a cor ${colorBuffer.value}');
            },
            selectedColor: Theme.of(context).primaryColor,
          );

          final actionButtonTextStyle =
              TextStyle(color: Theme.of(context).primaryColor);

          final cancelButton = FlatButton(
            child: Text('CANCEL', style: actionButtonTextStyle),
            onPressed: Navigator.of(context).pop,
          );

          final okButton = FlatButton(
            child: Text('OK', style: actionButtonTextStyle),
            onPressed: () {
              Navigator.of(context).pop();
              this.widget.changeThemeCallback(newPrimaryColor: colorBuffer);
            },
          );

          return AlertDialog(
            contentPadding: const EdgeInsets.all(6.0),
            title: Text('Pick a color'),
            content: Container(
              height: 250.0,
              child: colorPicker,
            ),
            actions: [cancelButton, okButton],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: 'Settings', hasReturnButton: true),
        body: Center(
            child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Main color'),
              trailing: Material(
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 16,
                ),
              ),
              onTap: _showColorPickerDialog,
            ),
          ],
        )));
  }
}
