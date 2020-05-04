import 'package:flutter/material.dart';
import 'package:todo_list/controllers/to_do_controller.dart';

class InputSection extends StatefulWidget {
  Function callback;

  InputSection(this.callback);

  @override
  _InputSectionState createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  
  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: textFieldController,
            decoration: InputDecoration(
              labelText: 'New To Do',
              labelStyle: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ),
        RaisedButton(
          color: Colors.blueAccent,
          child: Text('ADD'),
          textColor: Colors.white,
          onPressed: () {
            this.widget.callback(textFieldController.text);
          },
        )
      ],
    );
  }
}
