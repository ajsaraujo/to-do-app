import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:todo_list/widgets/my_app_bar.dart';

class SettingsPage extends StatefulWidget {
  Function changeThemeCallback;

  SettingsPage({this.changeThemeCallback});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ColorSwatch _appColor = Colors.blue;

  void changeAppColor({ColorSwatch newPrimaryColor}) {
    // We need to redraw this screen to change the circle's color.
    setState( () => _appColor = newPrimaryColor );

    this.widget.changeThemeCallback(newPrimaryColor: newPrimaryColor);
  }

  void _showColorPickerDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          ColorSwatch colorBuffer;

          final colorPicker = MaterialColorPicker(
            allowShades: false,
            onMainColorChange: (ColorSwatch color) => colorBuffer = color,
            selectedColor: _appColor,
          );

          final actionButtonTextStyle = TextStyle(color: Theme.of(context).primaryColor);

          final cancelButton = FlatButton(
            child: Text('CANCEL', style: actionButtonTextStyle),
            onPressed: Navigator.of(context).pop,
          );

          final okButton = FlatButton(
            child: Text('OK', style: actionButtonTextStyle),
            onPressed: () {
              Navigator.of(context).pop();
              changeAppColor(newPrimaryColor: colorBuffer);
            },
          );

          return AlertDialog(
            contentPadding: const EdgeInsets.all(6.0),
            title: Text('Pick a color'),
            content: Container(
                height: 250.0,
                child: colorPicker,
                ),
            actions: [
              cancelButton, 
              okButton
            ],
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
                  backgroundColor: _appColor,
                  radius: 16,
                ),
              ),
              onTap: _showColorPickerDialog,
            ),
          ],
        )
            /*child: MaterialColorPicker(
          allowShades: false,
          onMainColorChange: (ColorSwatch color) {
            setState(() {
              print('mudou a cor!');
              this.widget.changeThemeCallback(newPrimaryColor: color);
            });
          },
        )*/
        ));
  }
}
