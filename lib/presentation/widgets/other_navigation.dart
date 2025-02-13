import 'package:flutter/material.dart';

Future<dynamic> navigateTo(BuildContext context, Widget screen) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
