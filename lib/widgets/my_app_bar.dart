import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool hasReturnButton; 

  MyAppBar({this.title, this.actions, this.hasReturnButton = false});
  
  @override 
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Widget returnButton = IconButton(
      icon: Icon(Icons.arrow_back),
      color: Theme.of(context).accentColor, 
      onPressed: Navigator.of(context).pop,
    );

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(title),
      centerTitle: true,
      actions: this.actions,
      leading: hasReturnButton ? returnButton : null,
    );
  }
}