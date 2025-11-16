import 'package:flutter/material.dart';

class AppAppBar extends AppBar {
  AppAppBar({
    super.key,
    required String titleText,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
  }) : super(
          title: Text(titleText),
          centerTitle: false,
          elevation: 0,
          actions: actions,
          bottom: bottom,
        );
}


