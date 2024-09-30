import 'package:flutter/material.dart';

Widget textFieldWidget(
    BuildContext context, TextEditingController controller, String title,
    {bool? isVisibility, IconButton? visibility}) {
  return TextField(
    obscureText: isVisibility ?? false,
    controller: controller,
    decoration: InputDecoration(
        hintText: title,
        suffixIcon: visibility
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}